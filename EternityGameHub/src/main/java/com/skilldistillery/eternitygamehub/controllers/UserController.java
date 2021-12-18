package com.skilldistillery.eternitygamehub.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.eternitygamehub.data.AdminDAO;
import com.skilldistillery.eternitygamehub.data.UserDAO;
import com.skilldistillery.eternitygamehub.entities.User;

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

	// what is this method doing??????
	@RequestMapping(path = {"login.do"}, method = RequestMethod.GET)
	public String getLogin(HttpSession session, User user, Model model) {
		if (session.getAttribute("user") != null) {
			model.addAttribute("user", user);
			return "home";
		}
		return "redirect:home.do";
	}

	@RequestMapping(path = {"login.do"}, method = RequestMethod.POST)
	public String postLogin(User user, HttpSession session, Model model) {
		User u = userDao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		if (u != null) {
			if (u.getId() == 1) {
				session.setAttribute("admin", u);
				model.addAttribute("admin", u);
				return "adminhome";
			} session.setAttribute("user", u);
			model.addAttribute("user", u);
			return "home";
		} String incorrectLogin = "Please check your username and password and try again.";
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
		}
		User sessionUser = (User) session.getAttribute("user");
		System.out.println("**************" + user.getEmail() + "*****************" );
		if(userDao.checkIfEmailIsInUseAlready(user) && !sessionUser.getEmail().equals(user.getEmail())) {
			String emailInUse = "There is already an account with that email, please use a different email";
			model.addAttribute("emailInUseAlready", emailInUse);
			return "accountInfo";
		}
		else {
			user = userDao.updateUserInfo(user, user.getId());
			session.setAttribute("user", user);
			String updated = "Account information has been updated!";
			model.addAttribute("updatedAccount", updated);
			return "accountInfo";
		}	
	}

	@RequestMapping(path = "createUserAccount.do", method = RequestMethod.POST)
	public String createNewUserAccount(User user, HttpSession session, Model model) throws Exception {
		model.addAttribute("newUser", new User()); // what is this doing?
		if (userDao.checkIfEmailIsInUseAlready(user)) {
			String emailInUse = "Sorry, an account using this email has already been made";
			model.addAttribute("emailInUse", emailInUse);
			return "loginOrCreateAccount";
		} else if (userDao.checkIfUsernameIsInUseAlready(user)) {
			String usernameInUse = "Sorry, an account using this username has already been made";
			model.addAttribute("usernameInUse", usernameInUse);
			return "loginOrCreateAccount";
		} else {
			userDao.createNewUser(user);
			session.setAttribute("user", user);
			return "home";
		}
	}

	@RequestMapping(path = "resetPassword.do", method = RequestMethod.GET)
	public String getUserPasswordForReset(User user, HttpSession session) {
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} return "resetpassword";
	}

	@RequestMapping(path = "resetUserPassword.do", method = RequestMethod.POST)
	public String resetUserPassword(String newPassword, String oldPassword, HttpSession session, Model model) {
		User userInSession;
		if (session.getAttribute("user") == null) {
			return "loginOrCreateAccount";
		} else {
			userInSession = (User) session.getAttribute("user");
		}
		User user = userDao.findUserById(userInSession.getId());
		String destination;
		if (user.getPassword().equals(oldPassword)) {
			user = userDao.resetPassword(user, user.getId(), newPassword);
			destination = "accountInfo";
		} else {
			String incorrectOldPassword = "The password you entered doesn't match your current password.";
			model.addAttribute("oldPasswordIsIncorrect", incorrectOldPassword);
			destination = "resetpassword";
		}
		session.setAttribute("user", user);
		return destination;
	}
}
