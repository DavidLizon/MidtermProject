package com.skilldistillery.eternitygamehub.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Platform;
import com.skilldistillery.eternitygamehub.entities.Rating;

@Repository
@Transactional
public class GameDAOImple implements GameDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<GameInventory> findGameByKeywordSearch(String keyword, String[] filteredcondition, int genreId,
			int ratingId, int platformId) {
		List<GameInventory> gamesByKeyword = new ArrayList<>();
		String jpql = "SELECT gi FROM GameInventory gi LEFT JOIN gi.game.genres gg WHERE gi.available = true AND gi.game.title LIKE :searchkeyword";

		if (filteredcondition != null && filteredcondition.length > 0) {

			jpql += " and (";
			boolean addedOne = false;
			for (String filtered : filteredcondition) {
				switch (filtered) {
				case "new":
					if (addedOne) {
						jpql += " OR ";
					}
					jpql += " gi.conditionNew = 1 ";
//						jpql += " conditionNew = true "; 
					addedOne = true;
					break;
				case "used":
					if (addedOne) {
						jpql += " OR ";
					}
					jpql += " gi.conditionNew = 0 ";
//						jpql += " conditionNew = false "; 
					addedOne = true;
					break;
				}
			}
			jpql += ")";
		}

		if (genreId > 0) {
			jpql += " and gg.id = :genreId";
		}
		if (ratingId > 0) {
			jpql += " and gi.game.rating.id = :ratingId";
		}
		if (platformId > 0) {
			jpql += " and gi.platform.id = :platformId";
		}

		System.out.println("*******************");
		System.out.println(jpql);

		TypedQuery<GameInventory> query = em.createQuery(jpql, GameInventory.class);
		System.out.println("*******************");
		System.out.println(query);

		if (genreId > 0) {
			query.setParameter("genreId", genreId);
		}
		if (ratingId > 0) {
			query.setParameter("ratingId", ratingId);
		}
		if (platformId > 0) {
			query.setParameter("platformId", platformId);
		}

//		gamesByKeyword = em.createQuery(jpql, GameInventory.class)
		gamesByKeyword = query.setParameter("searchkeyword", "%" + keyword + "%").getResultList();

//		findGameByFilteredSearch(gamesByKeyword);

		return gamesByKeyword;
	}

	@Override
	public List<Game> findAllGames() {
		List<Game> allGames = new ArrayList<>();
		String jpql = "Select g FROM Game g";
		allGames = em.createQuery(jpql, Game.class).getResultList();
		return allGames;
	}

	@Override
	public List<GameInventory> findAllGameInventoryItems() {
		List<GameInventory> allGames = new ArrayList<>();
		String jpql = "Select gi FROM GameInventory gi";
		allGames = em.createQuery(jpql, GameInventory.class).getResultList();
		return allGames;
	}

	@Override
	public List<Game> findTitlesInGames(String title) {
		List<Game> gamesByTitleSearch = new ArrayList<>();
		String jpql = "SELECT g FROM Game g WHERE g.title LIKE :gametitle ORDER BY g.title ASC";
		gamesByTitleSearch = em.createQuery(jpql, Game.class).setParameter("gametitle", "%" + title + "%")
				.getResultList();
		return gamesByTitleSearch;
	}

	public GameInventory displaySelectedGameFromSearch(int inventoryItemId) {
		GameInventory selectedGame = em.find(GameInventory.class, inventoryItemId);
		return selectedGame;
	}

	@Override
	public Game addGame(Game game) {
		List<Game> allGames = findAllGames();
		for (Game game2 : allGames) {
			if (game2.getTitle().equalsIgnoreCase(game.getTitle())) {
				game = null;
				break;
			}
		}
		if (game != null) {
			em.persist(game);
		}
		return game;
	}
	
	@Override
	public Game addGame(Game game, int genreId) {
		List<Game> allGames = findAllGames();
		for (Game game2 : allGames) {
			if (game2.getTitle().equalsIgnoreCase(game.getTitle())) {
				game = null;
				break;
			}
		}
		if (game != null) {
			Genre genre = findGenreById(genreId);
			game.addGenre(genre);
			em.persist(game);
		}
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

	@Override
	public List<GameInventory> findGameByFilteredSearch(List<GameInventory> gamesByKeyword, Boolean conditionNew) {
		List<GameInventory> filteredGames = new ArrayList<>();
		String jpql = "SELECT gi FROM GameInventory gi WHERE gi.game.title LIKE :searchkeyword OR gi.game.description LIKE :searchkeyword";
		gamesByKeyword = em.createQuery(jpql, GameInventory.class)
				.setParameter("searchkeyword", "%" + conditionNew + "%").getResultList();
		return filteredGames;
	}

	@Override
	public List<Genre> listGenres() {
		List<Genre> genres = new ArrayList<>();
		String jpql = "Select g FROM Genre g ORDER BY g.name ASC";
		genres = em.createQuery(jpql, Genre.class).getResultList();
		return genres;
	}

	@Override
	public List<Rating> listRatings() {
		List<Rating> ratings = new ArrayList<>();
		String jpql = "Select r FROM Rating r";
		ratings = em.createQuery(jpql, Rating.class).getResultList();
		return ratings;
	}

	@Override
	public List<Platform> listPlatforms() {
		List<Platform> platforms = new ArrayList<>();
		String jpql = "Select p FROM Platform p ORDER BY p.name ASC";
		platforms = em.createQuery(jpql, Platform.class).getResultList();
		return platforms;
	}

	@Override
	public List<GameInventory> listGamesInCart(int inventoryItemId) {
		List<GameInventory> userCart = new ArrayList<>();
		String jpql = "Select gi from GameInventory gi where gi.id = :gameinventoryid";
		userCart = em.createQuery(jpql, GameInventory.class).setParameter("gameinventoryid", inventoryItemId)
				.getResultList();
		return userCart;
	}

//	@Override
	public List<GameInventory> displayGameInfoById(int id) {
		List<GameInventory> gameInventoryItemsToBuy = new ArrayList<>();
		String jpql = "Select gi from GameInventory gi where gi.id = :gameinventoryid";
		gameInventoryItemsToBuy = em.createQuery(jpql, GameInventory.class)
				.setParameter("gameinventoryid", gameInventoryItemsToBuy).getResultList();

		return gameInventoryItemsToBuy;
	}

	@Override
	public Game addGameInfoFromId(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Game findGameById(int id) {
		Game findGameToPassToSell = new Game();
		findGameToPassToSell = em.find(Game.class, id);
		return findGameToPassToSell;
	}

	public GameInventory findGameInventoryById(int id) {
		GameInventory findGameToAddToCart = new GameInventory();
		String jpql = "Select gi from GameInventory gi where gi.id = :findGameToAddToCart";
		findGameToAddToCart = em.createQuery(jpql, GameInventory.class).setParameter("findGameToAddToCart", id)
				.getSingleResult();
		return findGameToAddToCart;
	}

	public Genre findGenreById(int id) {
		Genre findGenreToAddToGame = new Genre();
		String jpql = "Select g from Genre g where g.id = :findGenreToAddToGame";
		findGenreToAddToGame = em.createQuery(jpql, Genre.class).setParameter("findGenreToAddToGame", id)
				.getSingleResult();
		return findGenreToAddToGame;
	}

//	@Override
//	public Game addGameInfoFromId(int id) {
//		Game game = new Game();
//		String jpql = "Select gi from GameInventory gi where gi.id = :gameinventoryid";
//		userCart = em.createQuery(jpql, GameInventory.class)
//				.setParameter("gameinventoryid", inventoryItemId)
//				.getResultList();
//		 
//		return userCart;
//	}

}
