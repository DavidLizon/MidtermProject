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
	

}
