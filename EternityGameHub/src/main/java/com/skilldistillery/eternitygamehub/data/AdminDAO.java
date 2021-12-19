package com.skilldistillery.eternitygamehub.data;

import java.util.List;

import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.User;

public interface AdminDAO {

	User confirmAdminInSession(String username, String password);

	List<User> findAndPopulateAllActiveUsers();

	User changeEnabledStatusOfUser(int userId);

	GameInventory removeAvailableStatusOfGame(int gameInventoryId);

}