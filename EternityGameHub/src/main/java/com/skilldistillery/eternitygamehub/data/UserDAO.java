package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.Game;
import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.User;

public interface UserDAO {

	User getUserByUserNameAndPassword(String userName, String password); 
	//login specific 
	User findUserById(int userId);
	
	User findAndPopulateUser(int userId, User user);

	User createNewUser(String firstName, String lastName, String username, String password, String email);
//	User findByUsername(String username);
	User updateUserInfo(int id, String firstName, String lastName, String username, String biography, String email,
			String profilePictureUrl);
}
