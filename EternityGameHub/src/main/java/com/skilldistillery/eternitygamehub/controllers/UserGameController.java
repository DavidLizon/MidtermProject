package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.data.SaleDAO;
import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.*;

@Controller
public class UserGameController {

	@Autowired
	private UserDAO userDao;

	@Autowired
	private GameDAO gameDao;

	@Autowired
	private SaleDAO saleDao;

	@RequestMapping(path = "search.do") // testmapping
	public String buyButton(Model model) {
		List<Platform> platforms = gameDao.listPlatforms();
		model.addAttribute("platforms", platforms);
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		return "search";
	}

	@RequestMapping(path = "goToAddGame.do", method = RequestMethod.GET) // testmapping
	public String addNewGameButton(HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		}

		List<Genre> genres = userDao.listGenres();
		model.addAttribute("genres", genres);

		List<Rating> ratings = userDao.listRatings();
		model.addAttribute("ratings", ratings);

		return "addGame";
	}

	@RequestMapping(path = "addToCart.do", params = "addToCartByInventoryId", method = RequestMethod.GET)
	public String addItemToCart(Integer addToCartByInventoryId, HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		}
		if (session.getAttribute("gamesInCart") == null) {
			List<GameInventory> gamesInCart = new ArrayList<>();
			GameInventory game = gameDao.findGameInventoryById(addToCartByInventoryId);
			gamesInCart.add(game);
			session.setAttribute("gamesInCart", gamesInCart);
		} else {
			List<GameInventory> gamesInCart = (List<GameInventory>) session.getAttribute("gamesInCart");
			GameInventory game = gameDao.findGameInventoryById(addToCartByInventoryId);
			if (gamesInCart.contains(game)) {
				String gameAlreadyInCart = "Sorry, game is already in cart";
				model.addAttribute("gameAlreadyInCart", gameAlreadyInCart);
				model.addAttribute("gameItem", game);
				return "gameInfo";
			} else {
				gamesInCart.add(game);
				session.setAttribute("gamesInCart", gamesInCart);
			}
		}
		return "cart";
	}

	@RequestMapping(path = "navToCart.do", method = RequestMethod.GET)
	public String checkUserIsInSession(HttpSession session) {
		return "cart";
	}

	@RequestMapping(path = "completePurchase.do", method = RequestMethod.GET)
	public String checkUserIsInSession(HttpSession session, User user, Model model) {
		user = (User) session.getAttribute("user");

		List<GameInventory> itemsInCart = (List<GameInventory>) session.getAttribute("gamesInCart");
		if (itemsInCart != null && itemsInCart.size() > 0) {
			List<Sale> listofSales = new ArrayList<>();

			for (GameInventory item : itemsInCart) {
				Sale sale = new Sale();
				sale.setBuyer(user);
				sale.setSeller(item.getUser());
				sale.setGameInventory(item);
				sale = saleDao.processPurchase(sale);
//				itemsInCart.remove(item);
				listofSales.add(sale);
			}
			model.addAttribute("listofSales", listofSales);
			return "confirmpurchase";
		} else {
			return "cart";
		}
//		
	}

}
