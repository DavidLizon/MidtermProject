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
	
	@RequestMapping(path = "addToCart.do", method = RequestMethod.GET)
	public String addItemToCart(User user, Model model, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} 
		
		List<GameInventory> gamesInCart = new ArrayList<>();
		gamesInCart = null;
//		User currentUser = (User) session.getAttribute("user");
//		gamesInCart = gameDao.listGamesInCart(currentUser);
		model.addAttribute("gamesInCart", gamesInCart);
		
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
