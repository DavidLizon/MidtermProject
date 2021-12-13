package com.skilldistillery.eternitygamehub.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.GameInventory;

@Repository
@Transactional
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

//	@Override
//	public User findByUsername(String username) {
//		String jpql = "SELECT u FROM User u WHERE u.username = :n";
//		try {
//			return em.createQuery(jpql, User.class).setParameter("n", username).getSingleResult();
//		} catch (Exception e) {
//			System.err.println("Invalid user name: " + username);
//			return null;
//		}
//	}
	@Override
	public List<GameInventory> findGameByKeywordSearch(String keyword) {
		List<GameInventory> gamesByKeyword = new ArrayList<>();
		String jpql = "SELECT gi FROM GameInventory gi WHERE gi.game.title LIKE :gametitle";
		gamesByKeyword = em.createQuery(jpql, GameInventory.class)
			.setParameter("gametitle", "%"+keyword+"%")
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

}
