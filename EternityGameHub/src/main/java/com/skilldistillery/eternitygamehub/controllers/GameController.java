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
	public String findByKeyword(String title, Model model, String[] filteredcondition, int genreId, int ratingId, int platformId) {
		List<GameInventory> games = new ArrayList<>();
		model.addAttribute("platforms",gameDao.listPlatforms());
		model.addAttribute("ratings", gameDao.listRatings());
		model.addAttribute("genres", gameDao.listGenres());
		games = gameDao.findGameByKeywordSearch(title, filteredcondition, genreId, ratingId, platformId);
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
	public String addGameToGames(Game game, Model model, int genreId) {
		Game newGame;
//		Genre genre1 = new Genre();
//		genre1.setName("TEST");
//		genre1.setId(genreId);
//		game.addGenre(genre1);
		newGame = gameDao.addGame(game, genreId);
		if (newGame == null) {
			String gameAlreadyExists = "Unable to add game. Game with same title already exists.";
			model.addAttribute("gameExists", gameAlreadyExists); 
			model.addAttribute("genres",  gameDao.listGenres());
			model.addAttribute("ratings", gameDao.listRatings());
			return "addGame";
		} else {
			int id = newGame.getId();
			return "redirect:populateItem.do?id="+id;			
		}
	}

	@RequestMapping(path = "populateItem.do", params="id", method = RequestMethod.GET)
	public String populateGameItemForGameInventoryItem(int id, Model model) {
		Game passGameToInventoryItem= gameDao.findGameById(id);
		model.addAttribute("platforms", gameDao.listPlatforms());
		model.addAttribute("newGame", passGameToInventoryItem);
		return "sellAddInventoryItem";
	}

	@RequestMapping(path = "displayNewlyAddedGameInventoryItem.do", method = RequestMethod.GET)
	public String displayGameInventoryItem(int id, Model model) {
		GameInventory newAddedGameInventoryItem = gameDao.displayCreatedGameInventoryItem(id);
		model.addAttribute("newGameInventoryItemDisplayed", newAddedGameInventoryItem);
		model.addAttribute("genres",  gameDao.listGenres());
		model.addAttribute("ratings", gameDao.listRatings());
		return "sellAddListingSuccessful";
	}
	
	
	@RequestMapping(path = "addGameInventoryItem.do", params={"genres","ratings"}, method = RequestMethod.POST)
	public String addGameInventoryItemToInventory(GameInventory gameInventoryItem, Integer gameID, Model model, Genre genres, Rating ratings) {
		Game gameToList = gameDao.findGameById(gameID);
		gameInventoryItem.setGame(gameToList);
		Game passGameToSuccessfulListingPage = gameDao.findGameById(gameID);
		
		System.out.println("gameInventoryItem: " + gameInventoryItem);
		System.out.println(gameID + "********************************** gameID");
		System.out.println("GAME: " + passGameToSuccessfulListingPage + "********************************");
		System.out.println("GAME INVENTORY: " + gameInventoryItem + "********************************");
		
		gameInventoryItem.setGame(passGameToSuccessfulListingPage);
		gameInventoryItem.setAvailable(true);
		GameInventory newGameInventoryItem = gameDao.addGameInventory(gameInventoryItem);
		
		System.out.println("*******************");
		System.out.println(gameInventoryItem);
		
		model.addAttribute("newGameInventoryItem", newGameInventoryItem);
		model.addAttribute("game", passGameToSuccessfulListingPage);
		model.addAttribute("genres", genres);
		model.addAttribute("ratings", ratings);
		return "sellAddInventoryItemSuccessful";
	}
	//working on this one to solve game inv not being added
//	@RequestMapping(path = "addGameInventoryItem.do", params={"genres","ratings"}, method = RequestMethod.POST)
//	public String addGameInventoryItemToInventory(Model model, Genre genres, Rating ratings, int id) {
//		GameInventory newAddedGameInventoryItem = new GameInventory();
//		newAddedGameInventoryItem.setAvailable(true);
//		model.addAttribute("newGameInventoryItemDisplayed", newAddedGameInventoryItem);
//		Game addingThisGame = gameDao.findGameById(id);
//		
//		
//		
//		model.addAttribute("newGameInventoryItem", newAddedGameInventoryItem);
//		model.addAttribute("game", addingThisGame);
//		model.addAttribute("genres", genres);
//		model.addAttribute("rating", ratings);
//		return "sellAddInventoryItemSuccessful";
//	}
	
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
