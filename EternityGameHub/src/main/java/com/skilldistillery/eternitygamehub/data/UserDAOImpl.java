package com.skilldistillery.eternitygamehub.data;

import java.util.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.*;

@Repository
@Transactional
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	private Map<Integer, User> users;
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
	  public User getUserByUserNameAndPassword(String userName, String password) {
	    User u = null;
	    Set<Integer> keys = users.keySet();
	    for (Integer key : keys) {
	      User user = users.get(key);
	      if(user.getUsername().equals(userName) && user.getPassword().equals(password)) {
	        u = user;
	        break;
	      }
	    }
	    return u;
	  }

	  @Override
	  public User findUserById(int userId) {
	    User u = users.get(userId);
	    
	    return u;
	  }

	  @Override
	  public User updateUser(int userId, User user) {
	    // not necessary
	    return null;
	  }

	@Override
	public User createNewUser(String firstName, String lastName, String username, String password, String email) {
		User newUser = null;
		newUser.setFirstName(firstName);
		newUser.setLastName(lastName);
		newUser.setUsername(username);
		newUser.setPassword(password);
		newUser.setEmail(email);
		users.put(newUser.getId(), newUser);
		em.persist(newUser);
		return newUser;
	}
	

}
