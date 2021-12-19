package com.skilldistillery.eternitygamehub.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.User;

@Repository
@Transactional
public class AdminDAOImpl implements AdminDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public User confirmAdminInSession (String admin, String adminpassword) {
		String jpql = "SELECT u FROM User u WHERE u.username = :n AND u.password = :p";
		try {
			return em.createQuery(jpql, User.class).setParameter("n", admin)
					.setParameter("p", adminpassword)
					.getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid user name: " + admin);
			return null;
		}
	}
	
	@Override
	public List<User> findAndPopulateAllActiveUsers() {
		String jpql = "SELECT u FROM User u";
		List<User> activeUsers = new ArrayList<>();
		activeUsers = em.createQuery(jpql, User.class)
				.getResultList();
		return activeUsers;
	}
	
//	add method to change enabled status for users 
	@Override 
	public User changeEnabledStatusOfUser(int userId) {
		User user = em.find(User.class, userId);
		if (user.isEnabled() == true) {
			user.setEnabled(false);
			return user;
		} else {
			user.setEnabled(true);
			return user;
		} 
	}
	
	@Override 
	public GameInventory removeAvailableStatusOfGame(int gameInventoryId) {
		GameInventory gameInventoryToRemove = em.find(GameInventory.class, gameInventoryId);
		gameInventoryToRemove.setAvailable(false);
		return gameInventoryToRemove; 
	}
}