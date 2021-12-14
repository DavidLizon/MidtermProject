package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;

public interface GameDAO {

	public List<GameInventory> findGameByKeywordSearch(String keyword);

	public List<GameInventory> findAllGames();

	public List<Game> findTitlesInGames(String title);
	
	public Game addGame(Game game);
	
	public GameInventory addGameInventory(GameInventory newGameInventoryItem);
	
	public GameInventory displayCreatedGameInventoryItem(int id);
}