package com.skilldistillery.eternitygamehub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.Genre;
import com.skilldistillery.eternitygamehub.entities.Rating;
import com.skilldistillery.eternitygamehub.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@RequestMapping(path = { "/", "home.do" })
	public String home() {
		return "home";
	}

	@RequestMapping(path = "goToSearchByTitle.do")
	public String sellButton() {
		return "sellSearchExistingGame";
	}

	@RequestMapping(path = "search.do") // testmapping
	public String buyButton() {
		return "search";
	}
	
//	@RequestMapping(path = "goToAddGame.do") // testmapping
//	public String addNewGameButton() {
//		return "addGame";
//	}
	
	@RequestMapping(path = "gameLinkToSAII.do") // testmapping
	public String gameLinkClicked() {
		return "sellAddInventoryItem";
	}

	@RequestMapping(path = "userAccount.do")
	public String userAccountPageButton(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		}
		return "accountinfo";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String getLogin(HttpSession session) {
		if (session.getAttribute("user") != null) {
			return "redirect:account.do";
		}
		return "login";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String postLogin(User user, HttpSession session) {

		User u = userDao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		if (u != null) {
			session.setAttribute("user", u);
			return "redirect:account.do";
		}
		return "login";
	}

	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:index.do";
	}

	@RequestMapping(path = "userAccount.do", method = RequestMethod.GET)
	public String getUserInfoForAccountInfoPage(int id, User user, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} userDao.findAndPopulateUser(id, user);
		return "accountinfo";
	}
	
	@RequestMapping(path = "updateUserAccount.do", method = RequestMethod.POST)
	public String updateUserInfoForAccountInfoPage(int id, User user, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} userDao.updateUserInfo(user, id);
		return "accountinfo";
	}
	
	@RequestMapping(path = "resetPassword.do", method = RequestMethod.GET)
	public String getUserPasswordForReset(int id, User user, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} userDao.findAndPopulateUser(id, user);
		return "resetpassword";
	}
	
	@RequestMapping(path = "resetUserPassword.do", method = RequestMethod.POST)
	public String resetUserPassword(int id, User user, String password, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} 
		userDao.resetPassword(user, id, password);
		return "accountinfo";
	}
	
	

//	@RequestMapping(path= "addNewGame.do", method = RequestMethod.POST)
//	public String addNewGame(Game newGame) {
////		public String addNewGame(int id, String name, String description, int maxPlayers, List<Genre> genre, Platform platform, double rentalPrice, double salePrice ) {
//		// new gameInventory object
//		GameInventory newInventoryGame = null;
//		// add newGame
//		// add platform
//		// add rentalPrice
//		// add salePrice
//		newGame = userDao.addGame(newGame);
//		
//		return "accountCreationConfirmation";
//	}
}
