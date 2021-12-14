package com.skilldistillery.eternitygamehub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.data.UserDAO;

@Controller
public class UserGameController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private GameDAO gameDao;
	
	
	
}
