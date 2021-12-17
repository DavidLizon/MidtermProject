package com.skilldistillery.eternitygamehub.controllers;


import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.*;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		}
		return "home";
	}

	@RequestMapping(path = "goToSearchByTitle.do")
	public String sellButton() {
		return "sellSearchExistingGame";
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
	
	//what is this method doing??????
	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String getLogin(HttpSession session, User user, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", user);
			return "home";
		}
		return "redirect:home.do";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String postLogin(User user, HttpSession session, Model model) {

		User u = userDao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		if (u != null) {
			session.setAttribute("user", u);
			model.addAttribute("user", u);
			return "home";
		}
		String incorrectLogin = "Please check your username and password and try again.";
		model.addAttribute("tryAgain", incorrectLogin);
		return "loginOrCreateAccount";
	}

	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:home.do";
	}

	@RequestMapping(path = "userAccount.do", method = RequestMethod.GET)
	public String getUserInfoForAccountInfoPage(HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} 
		return "accountInfo";
	}
	
	@RequestMapping(path = "updateUserAccount.do", method = RequestMethod.GET)
	public String updateUserInfoForAccountInfoPage(User user, HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} user = userDao.updateUserInfo(user, user.getId());
		session.setAttribute("user", user);
		return "accountInfo";
	}
	
	@RequestMapping(path = "createUserAccount.do", method = RequestMethod.POST)
	public String createNewUserAccount(User user, HttpSession session, Model model) throws Exception {
			model.addAttribute("newUser", new User()); //what is this doing?
			if(userDao.checkIfEmailIsInUseAlready(user)){
				String emailInUse = "Sorry, an account using this email has already been made";
				model.addAttribute("emailInUse", emailInUse);
				return "loginOrCreateAccount";
			}
			else if(userDao.checkIfUsernameIsInUseAlready(user)) {
				String usernameInUse = "Sorry, an account using this username has already been made";
				model.addAttribute("usernameInUse", usernameInUse);
				return "loginOrCreateAccount";
			}
			else {
				userDao.createNewUser(user);
				session.setAttribute("user", user);
				return "home";
			}
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
