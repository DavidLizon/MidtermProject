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
	public String findByKeyword(String title, Model model, String[] filteredcondition) {
		List<GameInventory> games = new ArrayList<>();
		List<Platform> platforms = gameDao.listPlatforms();
		model.addAttribute("platforms", platforms);
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		games = gameDao.findGameByKeywordSearch(title, filteredcondition);
		model.addAttribute("result", games);
		
		return "search";
	}

	@RequestMapping(path = "displayAllGames.do", method = RequestMethod.GET)
	public String displayAllGames(String keyword, Model model) {
		List<GameInventory> allGames = new ArrayList<>();
		allGames = gameDao.findAllGameInventoryItems();
		model.addAttribute("allresults", allGames);
		return "search";
	}
	
	@RequestMapping(path = "goToItemListing.do", method = RequestMethod.GET)
	public String displayGameDetailsFromSearch(int inventoryItemId, Model model) {
		GameInventory selectedGame = null;
		selectedGame = gameDao.displaySelectedGameFromSearch(inventoryItemId);
		model.addAttribute("gameItem",selectedGame);
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
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		Game newGame = gameDao.addGame(game);
		if (newGame == null) {
			String gameAlreadyExists = "Unable to add game. Game with same title already exists.";
			model.addAttribute("gameExists", gameAlreadyExists); 
			return "addGame";
		} else {
			model.addAttribute("newGame", newGame);
			model.addAttribute("platforms", gameDao.listPlatforms());
			return "sellAddInventoryItem";			
		}
	}

	@RequestMapping(path = "populateItem.do", method = RequestMethod.GET)
	public String populateGameItemForGameInventoryItem(int gameItemId, Model model) {
		Game passGameToInventoryItem= gameDao.findGameById(gameItemId);
		model.addAttribute("platforms", gameDao.listPlatforms());
		model.addAttribute("game", passGameToInventoryItem);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		return "sellAddInventoryItem";
	}

	@RequestMapping(path = "displayNewlyAddedGameInventoryItem.do", method = RequestMethod.GET)
	public String displayGameInventoryItem(int id, Model model) {
		GameInventory newAddedGameInventoryItem = gameDao.displayCreatedGameInventoryItem(id);
		model.addAttribute("newGameInventoryItemDisplayed", newAddedGameInventoryItem);
		List<Genre> genres = gameDao.listGenres();
		model.addAttribute("genres", genres);
		List<Rating> ratings = gameDao.listRatings();
		model.addAttribute("ratings", ratings);
		return "sellAddListingSuccessful";
	}
	
	@RequestMapping(path = "addGameInventoryItem.do", params={"genres","ratings"}, method = RequestMethod.POST)
	public String addGameInventoryItemToInventory(GameInventory gameInventoryItem, Model model, Genre genres, Rating ratings) {
		gameInventoryItem.setAvailable(true);
//		Game passGameToSuccessfulListingPage = gameInventoryItem.getGame();	
		Game passGameToSuccessfulListingPage = gameDao.findGameById(gameInventoryItem.getGame().getId());	
		GameInventory newGameInventoryItem = gameDao.addGameInventory(gameInventoryItem);
		model.addAttribute("newGameInventoryItem", newGameInventoryItem);
		model.addAttribute("game", passGameToSuccessfulListingPage);
		model.addAttribute("genres", genres);
		model.addAttribute("ratings", ratings);
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
