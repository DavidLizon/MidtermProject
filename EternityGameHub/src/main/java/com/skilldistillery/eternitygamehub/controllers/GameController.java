package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Platform;
import com.skilldistillery.eternitygamehub.entities.Rating;

@Controller
public class GameController {

	@Autowired
	private GameDAO gameDao;

//	<input type = checkbox name = "filteredcondition" value ="new">
//	<input type = checkbox name = "filteredcondition" value ="rentable">

	@RequestMapping(path = "findByKeyword.do", method = RequestMethod.GET)
	public String findByKeyword(String keyword, Model model, String[] filteredcondition) {
		List<GameInventory> games = new ArrayList<>();
		List<Platform> platforms = gameDao.listPlatforms();
		model.addAttribute("platforms", platforms);
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		games = gameDao.findGameByKeywordSearch(keyword, filteredcondition);
		model.addAttribute("result", games);
		return "search";
	}

	@RequestMapping(path = "displayAllGames.do", method = RequestMethod.GET)
	public String displayAllGames(String keyword, Model model) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGames();
		model.addAttribute("allresults", allGames);
		return "search";
	}
	
	@RequestMapping(path = "goToItemListing.do", method = RequestMethod.GET)
	public String displayGameDetailsFromSearch(int inventoryItemId, Model model) {
		GameInventory selectedGame = null;
		selectedGame = gameDao.displaySelectedGameFromSearch(inventoryItemId);
		model.addAttribute(selectedGame);
		return "gameInfo";
	}

	@RequestMapping(path = "searchByTitle.do", method = RequestMethod.GET)
	public String searchByTitle(String title, Model model) {
		List<Game> alreadyInGames = new ArrayList<>();
		alreadyInGames = gameDao.findTitlesInGames(title);
		if (alreadyInGames.size() == 0) {
			String noneFound = "No games found with that search keyword, try again or add your game!";
			model.addAttribute("noGamesFound", noneFound);
			return "sellSearchExistingGame";
		}
		else {
			model.addAttribute("alreadyInGames", alreadyInGames);
			return "sellSearchExistingGame";
		}
		
	}

	@RequestMapping(path = "addGame.do", method = RequestMethod.POST) //
	public String addGameToGames(Game game, Model model) {
		Game newGame = gameDao.addGame(game);
		model.addAttribute("newGameAdded", newGame);
		return "sellAddInventoryItem";
	}

	@RequestMapping(path = "populateItem.do", method = RequestMethod.GET)
	public String populateGameItemForGameInventoryItem(int gameItemId, Model model) {
		Game passGameToInventoryItem= gameDao.findGameById(gameItemId);
		model.addAttribute("platforms", gameDao.listPlatforms());
		model.addAttribute("game", passGameToInventoryItem);
		return "sellAddInventoryItem";
	}

	@RequestMapping(path = "displayNewlyAddedGameInventoryItem.do", method = RequestMethod.GET)
	public String displayGameInventoryItem(int id, Model model) {
		GameInventory newAddedGameInventoryItem = gameDao.displayCreatedGameInventoryItem(id);
		model.addAttribute("newGameInventoryItemDisplayed", newAddedGameInventoryItem);
		return "sellAddListingSuccessful";
	}
	
	@RequestMapping(path = "addGameInventoryItem.do", method = RequestMethod.POST)
	public String addGameInventoryItemToInventory(GameInventory gameInventoryItem, Model model) {
		gameInventoryItem.setAvailable(true);
		GameInventory newGameInventoryItem = gameDao.addGameInventory(gameInventoryItem);
		model.addAttribute("newGameInventoryItem", newGameInventoryItem);
		return "sellAddInventoryItemSuccessful";
	}
	
//	@RequestMapping(path = "displayGameInfoFromSearch.do", method = RequestMethod.GET)
//	public String displayGameInfoFromSearch(int id, Model model) {
//		List <GameInventory> displayGameItemInGameInfo = gameDao.displayGameInfoById(id);
//		model.addAttribute("gameItemInGameInfo", displayGameItemInGameInfo);
//		return "gameInfo";
//	}
	
	@RequestMapping(path = "sellSearchGameToAddInventoryItem.do", method = RequestMethod.GET)
	public String passGameToSellAddInventoryItem(Integer id, Model model) {
		Game passingGameToSellInventory = gameDao.addGameInfoFromId(id);
		
		return "sellAddInventoryItem";
	}
}
