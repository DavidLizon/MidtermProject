package com.skilldistillery.eternitygamehub.data;

import com.skilldistillery.eternitygamehub.entities.User;

public interface UserDAO {

	User findByUsername(String username);
		
}
