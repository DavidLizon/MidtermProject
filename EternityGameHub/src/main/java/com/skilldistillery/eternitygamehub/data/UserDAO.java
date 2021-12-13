package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.GameInventory;

public interface UserDAO {

//	User findByUsername(String username);
	
	public List<GameInventory> findGameByKeywordSearch(String keyword);
	
	public List<GameInventory> findAllGames();
		
}
