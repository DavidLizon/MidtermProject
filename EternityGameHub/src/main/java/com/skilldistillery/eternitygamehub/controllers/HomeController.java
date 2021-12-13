package com.skilldistillery.eternitygamehub.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.GameInventory;

@Controller
public class HomeController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path= {"/", "home.do"})
	public String home() {
		return "home";
	}
	
	@RequestMapping(path= "findByKeyword.do", method = RequestMethod.GET)
	public String findByKeyword(String keyword, Model model) {
		List<GameInventory> games = new ArrayList<>();
		games = userDao.findGameByKeywordSearch(keyword);
		model.addAttribute("result", games);
		return "search";
		
	}
	
	
}
