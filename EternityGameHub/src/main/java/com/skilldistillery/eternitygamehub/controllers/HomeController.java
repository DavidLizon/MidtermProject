package com.skilldistillery.eternitygamehub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.eternitygamehub.data.UserDAO;

@Controller
public class HomeController {

	@Autowired
	private UserDAO userDao;
}
