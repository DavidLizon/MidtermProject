package com.skilldistillery.eternitygamehub.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	
	@Column(name = "first_name")
	private String firstName;
	
	@Column(name = "last_name")
	private String lastName;
	
	private String password;
	
	private String email;
	
	@Column(name = "account_created")
	@CreationTimestamp
	private LocalDateTime accountCreated;
	
	private String biography;
	
	private boolean enabled;
	
	private String role;
	
	@Column(name = "profile_picture_url")
	private String profilePictureUrl;
	
	@OneToMany(mappedBy = "user")
	private List<Game> games;
	
	@OneToMany(mappedBy = "user")
	private List<GameInventory> gameInventory;
	
	@OneToMany(mappedBy = "buyer")
	private List<Sale> buyers;
	
	@OneToMany(mappedBy = "seller")
	private List<Sale> sellers;

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDateTime getAccountCreated() {
		return accountCreated;
	}

	public void setAccountCreated(LocalDateTime accountCreated) {
		this.accountCreated = accountCreated;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getProfilePictureUrl() {
		return profilePictureUrl;
	}

	public void setProfilePictureUrl(String profilePictureUrl) {
		this.profilePictureUrl = profilePictureUrl;
	}

	public List<Game> getGames() {
		return games;
	}

	public void setGames(List<Game> games) {
		this.games = games;
	}

	public List<GameInventory> getGameInventory() {
		return gameInventory;
	}

	public void setGameInventory(List<GameInventory> gameInventory) {
		this.gameInventory = gameInventory;
	}

	public List<Sale> getBuyers() {
		return buyers;
	}

	public void setBuyers(List<Sale> buyers) {
		this.buyers = buyers;
	}

	public List<Sale> getSellers() {
		return sellers;
	}

	public void setSellers(List<Sale> sellers) {
		this.sellers = sellers;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", password=" + password + ", email=" + email + ", accountCreated=" + accountCreated + ", biography="
				+ biography + ", enabled=" + enabled + ", role=" + role + "]";
	}

}
