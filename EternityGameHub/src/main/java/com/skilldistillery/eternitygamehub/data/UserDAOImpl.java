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

	@Override
	public User getUserByUserNameAndPassword(String username, String password) {
		String jpql = "SELECT u FROM User u WHERE u.username = :n AND u.password = :p";
		try {
			return em.createQuery(jpql, User.class).setParameter("n", username)
					.setParameter("p", password)
					.getSingleResult();
		} catch (Exception e) {
			System.err.println("Invalid user name: " + username);
			return null;
		}
	}

	@Override
	public User findUserById(int id) {
		return em.find(User.class, id);
	}

	@Override
	public User findAndPopulateUser(int id, User user) {
		user = em.find(User.class, id);
		return user;
	}

	@Override
	public User createNewUser(User user) {
		User newUser = user;
		em.persist(newUser);
		return newUser;
	}

	@Override
	public User updateUserInfo(User user, int id) {
		User updatedUser = em.find(User.class, id);
		
		updatedUser.setFirstName(user.getFirstName());
		updatedUser.setLastName(user.getLastName());
		updatedUser.setUsername(user.getUsername());
		updatedUser.setBiography(user.getBiography());
		updatedUser.setEmail(user.getEmail());
		updatedUser.setProfilePictureUrl(user.getProfilePictureUrl());
		return updatedUser;
	}

	@Override
	public User resetPassword(User user, int id, String password) {
		user = em.find(User.class, id);
		user = updateUserPasswordHelper(id, user, password);
		return user;
	}
	
//	public User resetPassword(User user, int id) {
//		User userToUpdatePassword = em.find(User.class, id);
//		userToUpdatePassword.setPassword(user.getPassword());
//		return userToUpdatePassword;
//	}
//	working on refactoring this right now! -allysa
	
	public User updateUserPasswordHelper(int id, User user, String password) {
		User userToUpdatePassword = user;
		userToUpdatePassword = em.find(User.class, 1);
		String oldPassword = userToUpdatePassword.getPassword();
		String newPassword = password;
		oldPassword = newPassword;
				userToUpdatePassword.setPassword(newPassword);
		em.persist(userToUpdatePassword);
		return userToUpdatePassword;
	}

	public List<Genre> listGenres() {
		List<Genre> genres = new ArrayList<>();
		String jpql = "Select g FROM Genre g";
		genres = em.createQuery(jpql, Genre.class).getResultList(); 
		return genres;
	}

	public List<Rating> listRatings() {
		List<Rating> ratings = new ArrayList<>();
		String jpql = "Select r FROM Rating r";
		ratings = em.createQuery(jpql, Rating.class).getResultList(); 
		return ratings;
	}

//	
//	String firstName, String lastName, String username, String biography, String email,
//	String profilePictureUrl

}
