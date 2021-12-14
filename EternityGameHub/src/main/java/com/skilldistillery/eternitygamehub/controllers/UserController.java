package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.GameInventory;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path= {"/", "home.do"})
	public String home() {
		return "home";
	}
	
	
	
//	@RequestMapping(path= "addNewGame.do", method = RequestMethod.POST)
//	public String addNewGame(Game newGame) {
////		public String addNewGame(int id, String name, String description, int maxPlayers, List<Genre> genre, Platform platform, double rentalPrice, double salePrice ) {
//		// new gameInventory object
//		GameInventory newInventoryGame = null;
//		// add newGame
//		// add platform
//		// add rentalPrice
//		// add salePrice
//		newGame = userDao.addGame(newGame);
//		
//		return "accountCreationConfirmation";
//	}
}
