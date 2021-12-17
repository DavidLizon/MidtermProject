package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.*;

public interface UserDAO {

	User getUserByUserNameAndPassword(String userName, String password); 
	//login specific 
	User findUserById(int userId);
	
	User findAndPopulateUser(int userId, User user);
	
	User updateUserInfo(User user, int id);
	
	User resetPassword(User user, int id, String password);
	
	public List<Genre> listGenres();
	
	public List<Rating> listRatings();
	
	public List<Sale> listSales();
	
	User createNewUser(User user);
	
	boolean checkIfEmailIsInUseAlready(User user) throws Exception;
	
	boolean checkIfUsernameIsInUseAlready(User user) throws Exception;
	
}
