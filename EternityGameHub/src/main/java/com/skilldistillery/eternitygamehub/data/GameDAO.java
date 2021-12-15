package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Platform;
import com.skilldistillery.eternitygamehub.entities.Rating;

public interface GameDAO {

	public List<GameInventory> findGameByKeywordSearch(String keyword, String[] filteredcondition);

	public List<GameInventory> findAllGames();

	public List<Game> findTitlesInGames(String title);
	
	public Game addGame(Game game);
	
	public GameInventory addGameInventory(GameInventory newGameInventoryItem);
	
	public GameInventory displayCreatedGameInventoryItem(int id);
	
	List<GameInventory> findGameByFilteredSearch(List<GameInventory> gamesByKeyword, Boolean conditionNew);
	
	public GameInventory displaySelectedGameFromSearch(int inventoryItemId);

	public List<Genre> listGenres();
	
	public List<Rating> listRatings();
	
	public List<Platform> listPlatforms();
	
}
