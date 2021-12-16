package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Rating;
import com.skilldistillery.eternitygamehub.entities.User;

public interface UserDAO {

	User getUserByUserNameAndPassword(String userName, String password); 
	//login specific 
	User findUserById(int userId);
	
	User findAndPopulateUser(int userId, User user);

//	User createNewUser(String firstName, String lastName, String username, String password, String email);
	
	User updateUserInfo(User user, int id);
	
	User resetPassword(User user, int id, String password);
	
	public List<Genre> listGenres();
	
	public List<Rating> listRatings();
	
	
	User createNewUser(User user);
	
}
