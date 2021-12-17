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
import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Platform;
import com.skilldistillery.eternitygamehub.entities.Rating;
import com.skilldistillery.eternitygamehub.entities.User;

@Controller
public class UserGameController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private GameDAO gameDao;
	
	
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
	
	@RequestMapping(path = "addToCart.do", params="addToCartByInventoryId", method = RequestMethod.GET)
	public String addItemToCart( Integer addToCartByInventoryId, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} 
		
		// looks at session to see if gamesInCart attribute is null, if null create new ArrayList
		// creates GameInventory object (from passed in Integer addToCartByInventoryId from the gameInfo.jsp
		// adds GameInventory object to the List<GameInventory> and adds the object id to the session
		if(session.getAttribute("gamesInCart") == null) {
			List<GameInventory> gamesInCart = new ArrayList<>();
			GameInventory game = gameDao.findGameInventoryById(addToCartByInventoryId);
			gamesInCart.add(game);
//			attribute name in "" is what matters in the JSP and can be named what ever you want CHANGED to lotsOgamesInCart and
//			still worked if <c:when test="${empty gamesInCart }" >  AND <c:forEach items="${gamesInCart}" var="cartItem"> are changed
//			to match the session attribute name.
			session.setAttribute("gamesInCart", gamesInCart);

			
			
//			used for testing
			System.out.println("Cart size: " + gamesInCart.size() + " ====================================");
			System.out.println("addToCartByInventoryId: " + addToCartByInventoryId + " =============================================\n");
			System.out.println("SESSION: " + session + "=============================================\n");
			
		} else {
//			if gamesInCart was found in session this should be second time page was visited. Problem may arise when 
//			link directly to cart is added instead of getting to page from adding game to cart.
			
//			gamesInCart is populated with previous list stored in the session variable, recently added game object
//			is created and added to the gamesInCart List, and is then added to the session
			List<GameInventory> gamesInCart = (List<GameInventory>) session.getAttribute("gamesInCart");
			GameInventory game = gameDao.findGameInventoryById(addToCartByInventoryId);
			gamesInCart.add(game);
			
//			used for testing
			System.out.println("addToCartByInventoryId: " + addToCartByInventoryId + " =============================================\n");

			System.out.println(session.getAttribute("gamesInCart"));
			System.out.println("Cart size: " + gamesInCart.size() + " ====================================");
			System.out.println("addToCartByInventoryId: " + addToCartByInventoryId + " =============================================\n");
			System.out.println("SESSION: " + session + "=============================================\n");
			for (GameInventory game1 : gamesInCart) {
				System.out.println(game1);
			}
//			above used for testing =============================================
			
			session.setAttribute("gamesInCart", gamesInCart);

		}
		return "cart";
	}
	
//	@RequestMapping(path = "addToCart.do", method = RequestMethod.GET)
//	public String checkUserIsInSession(HttpSession session) {
//		if (session.getAttribute("user") == null) {
//			return "loginOrCreateAccount";
//		} 
//		return "";
//	}
}
