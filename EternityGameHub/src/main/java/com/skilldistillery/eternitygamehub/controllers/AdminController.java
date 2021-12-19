package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.*;
import com.skilldistillery.eternitygamehub.entities.*;

@Controller
public class AdminController {
	
	@Autowired 
	private AdminDAO adminDao;
	
	@Autowired 
	private UserDAO userDao;
	
	@Autowired 
	private GameDAO gameDao;
	
	@RequestMapping(path = "displayAllActiveGameListings.do", method = RequestMethod.GET)
	public String displayAllGameListings(Model model) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGameInventoryItems();
		model.addAttribute("allGames", allGames);
		return "adminhome";
	}
	
	@RequestMapping(path = "displayAllUsers.do", method = RequestMethod.GET)
	public String displayAllUsers(Model model) {
		List<User> allUsers = new ArrayList<>();
		allUsers = adminDao.findAndPopulateAllActiveUsers();
		model.addAttribute("allUsers", allUsers);
		return "adminhome";
	}

	@RequestMapping(path = "removeGameInventoryItem.do", method = RequestMethod.GET)
	public String removeGameInventoryItem(Model model, Integer id) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGameInventoryItems();
		adminDao.removeAvailableStatusOfGame(id);
		model.addAttribute("allGames", allGames);		
		return "adminremovelisting";
	}
	
	@RequestMapping(path = "passToRemoveListingPage.do", method = RequestMethod.GET)
	public String passToRemoveListingPage(Model model, Integer id) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGameInventoryItems();
		model.addAttribute("allGames", allGames);		
		return "adminremovelisting";
	}
	
	@RequestMapping(path = "disableUser.do", method = RequestMethod.GET)
	public String disableUser(Model model, Integer id) {
		List<User> activeUsers = new ArrayList<>();
		activeUsers = adminDao.findAndPopulateAllActiveUsers();
		adminDao.changeEnabledStatusOfUser(id);
		model.addAttribute("activeUsers", activeUsers);		
		return "admindisableuser";
	}
	
	@RequestMapping(path = "passToChangeUserEnableStatusListingPage.do", method = RequestMethod.GET)
	public String passToChangeUserEnableStatusListingPage(Model model, Integer id) {
		List<User> activeUsers = new ArrayList<>();
		activeUsers = adminDao.findAndPopulateAllActiveUsers();
		model.addAttribute("activeUsers", activeUsers);		
		return "admindisableuser";
	}
	
//	@RequestMapping(path = "changeEnabledStatusOfUser.do", method = RequestMethod.GET)
//	public String changeEnabledStatusOfUser(Model model, User user) {
////		User user = userDao.findUserById(userId);
////		User user = adminDao.changeEnabledStatusOfUser(user.getId());
//		model.addAttribute("allUsers", user);
//		return "adminhome";
//	}
	
//	List<GameInventory> itemsInCart = (List<GameInventory>) session.getAttribute("gamesInCart");
//	session.setAttribute("gamesInCart", itemsInCart);
//	GameInventory itemToRemove = gameDao.findGameInventoryById(removeItemId);
//	itemsInCart.remove(itemToRemove);
//	return "cart"; 
	
	
	@RequestMapping(path = "historyOfTransactions.do", method = RequestMethod.GET)
	public String historyOfTransactions(Integer itemId, HttpSession session) {
		List<GameInventory>allGames = (List<GameInventory>) session.getAttribute("allGames");
		GameInventory itemToRemoveFromListing = gameDao.findGameInventoryById(itemId);
		allGames.remove(itemToRemoveFromListing);
		session.setAttribute("removeGames", allGames);
		return "adminhome";
	}
}