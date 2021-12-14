package com.skilldistillery.eternitygamehub.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;

@Repository
@Transactional
public class GameDAOImple implements GameDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<GameInventory> findGameByKeywordSearch(String keyword) {
		List<GameInventory> gamesByKeyword = new ArrayList<>();
		String jpql = "SELECT gi FROM GameInventory gi WHERE gi.game.title LIKE :gametitle";
		gamesByKeyword = em.createQuery(jpql, GameInventory.class)
				.setParameter("gametitle", "%" + keyword + "%")
				.getResultList();
		em.close();
		return gamesByKeyword;
	}

	@Override
	public List<GameInventory> findAllGames() {
		List<GameInventory> allGames = new ArrayList<>();
		String jpql = "Select gi FROM GameInventory gi";
		allGames = em.createQuery(jpql, GameInventory.class)
				.getResultList();
		em.close();
		return allGames;
	}
	
	@Override
	public List<Game> findTitlesInGames(String title) {
		List<Game> gamesByTitleSearch = new ArrayList<>();
		String jpql = "SELECT g FROM Game g WHERE g.title LIKE :gametitle";
		gamesByTitleSearch = em.createQuery(jpql, Game.class)
				.setParameter("gametitle", "%" + title + "%")
				.getResultList();
		em.close();
		return gamesByTitleSearch;
	}

	@Override
	public Game addGame(Game game) {
		em.persist(game);
		return game;
	}

	@Override
	public GameInventory addGameInventory(GameInventory newGameInventoryItem) {
		em.persist(newGameInventoryItem);
		return newGameInventoryItem;
	}

	@Override
	public GameInventory displayCreatedGameInventoryItem(int id) {
		GameInventory recentlyAddedGameInventoryItem = new GameInventory();
		recentlyAddedGameInventoryItem = em.find(GameInventory.class, id);
		return recentlyAddedGameInventoryItem;
	}
	
	
	
	
	


}
