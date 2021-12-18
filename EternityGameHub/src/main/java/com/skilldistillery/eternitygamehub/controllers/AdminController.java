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
	
	@RequestMapping(path = "changeEnabledStatusOfUser.do", method = RequestMethod.GET)
	public String changeEnabledStatusOfUser(Model model, User user) {
//		User user = userDao.findUserById(userId);
//		User user = adminDao.changeEnabledStatusOfUser(user.getId());
		model.addAttribute("allUsers", user);
		return "adminhome";
	}
	
	@RequestMapping(path = "displayGameInventoryItem.do", method = RequestMethod.GET)
	public String displayGameDetails(int inventoryItemId, Model model) {
		GameInventory selectedGame = null;
		selectedGame = gameDao.displaySelectedGameFromSearch(inventoryItemId);
		model.addAttribute("gameItem",selectedGame);
		return "adminhome";
	}
	
	@RequestMapping(path = "removeGameInventoryItem.do", params="id", method = RequestMethod.GET)
	public String removeGameInventoryItem(HttpSession session, Integer id) {
		List<GameInventory>allGames = (List<GameInventory>) session.getAttribute("allGames");
		GameInventory itemToRemoveFromListing = gameDao.findGameInventoryById(id);
		allGames.remove(itemToRemoveFromListing);
		session.setAttribute("allGames", allGames);
		return "adminhome";
	}
	
	@RequestMapping(path = "historyOfTransactions.do", method = RequestMethod.GET)
	public String historyOfTransactions(Integer itemId, HttpSession session) {
		List<GameInventory>allGames = (List<GameInventory>) session.getAttribute("allGames");
		GameInventory itemToRemoveFromListing = gameDao.findGameInventoryById(itemId);
		allGames.remove(itemToRemoveFromListing);
		session.setAttribute("removeGames", allGames);
		return "adminhome";
	}
}
