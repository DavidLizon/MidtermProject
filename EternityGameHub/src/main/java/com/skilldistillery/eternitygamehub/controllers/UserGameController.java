package com.skilldistillery.eternitygamehub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.GameDAO;
import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Rating;

@Controller
public class UserGameController {

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private GameDAO gameDao;
	
	@RequestMapping(path = "goToAddGame.do", method = RequestMethod.GET) // testmapping
	public String addNewGameButton(HttpSession session, Model model) {
	  
	  List<Genre> genres = userDao.listGenres();
	  model.addAttribute("genres", genres);

	  List<Rating> ratings = userDao.listRatings();
	  model.addAttribute("ratings", ratings);

	  return "addGame";
	}
	
}
