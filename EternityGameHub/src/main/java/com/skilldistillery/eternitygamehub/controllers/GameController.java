package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;

public class GameController {
	
	@Autowired
	private GameDAO gameDao;

	@RequestMapping(path= "findByKeyword.do", method = RequestMethod.GET)
	public String findByKeyword(String keyword, Model model) {
		List<GameInventory> games = new ArrayList<>();
		games = gameDao.findGameByKeywordSearch(keyword);
		model.addAttribute("result", games);
		return "search";
		
	}
	
	@RequestMapping(path= "displayAllGames.do", method = RequestMethod.GET)
	public String displayAllGames(String keyword, Model model) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGames();
		model.addAttribute("allresults", allGames);
		return "search";
	}
	
	@RequestMapping(path= "searchByTitle.do", method = RequestMethod.GET)
	public String searchByTitle(String title, Model model) {
		List<Game> alreadyInGames = new ArrayList<>();
		alreadyInGames = gameDao.findTitlesInGames(title);
		model.addAttribute("searchedByTitles", alreadyInGames);
		return "sellSearchExistingGame";
	}
	
	@RequestMapping(path= "addGame.do", method = RequestMethod.POST)
	public String addGameToGames(Game game, Model model) {
		Game newGame = gameDao.addGame(game);
		model.addAttribute("newGameAdded", newGame);
		return "addGameInventoryItem";
	}
	
	@RequestMapping(path= "addGameInventoryItem.do", method = RequestMethod.POST)
	public String addGameInventoryItemToInventory(GameInventory GameInventoryItem, Model model) {
		GameInventory newGameInventoryItem = gameDao.addGameInventory(GameInventoryItem);
		model.addAttribute("newGameInventoryItem", newGameInventoryItem);
		return "sellAddListingSuccessful";
	}
	
	@RequestMapping(path= "displayNewlyAddedGameInventoryItem.do", method = RequestMethod.GET)
	public String displayGameInventoryItem(int id, Model model) {
		GameInventory newAddedGameInventoryItem = gameDao.displayCreatedGameInventoryItem(id);
		model.addAttribute("newGameInventoryItemDisplayed", newAddedGameInventoryItem);
		return "";
	}
	
}	