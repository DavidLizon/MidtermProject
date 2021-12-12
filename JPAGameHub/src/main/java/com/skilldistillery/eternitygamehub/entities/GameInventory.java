package com.skilldistillery.eternitygamehub.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "game_inventory")
public class GameInventory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String description;
	
	@Column(name = "sale_price")
	private double salePrice;
	
	private boolean available;
	
	@Column(name = "rent_price")
	private double rentPrice;
	
	@ManyToOne
	@JoinColumn(name = "platform_id")
	private Platform platform;
	
	@ManyToOne
	@JoinColumn(name = "game_id")
	private Game game;
	
	public GameInventory() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(double salePrice) {
		this.salePrice = salePrice;
	}

	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}

	public double getRentPrice() {
		return rentPrice;
	}

	public void setRentPrice(double rentPrice) {
		this.rentPrice = rentPrice;
	}

	public Platform getPlatform() {
		return platform;
	}

	public void setPlatform(Platform platform) {
		this.platform = platform;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
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
		GameInventory other = (GameInventory) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "GameInventory [id=" + id + ", description=" + description + ", salePrice=" + salePrice + ", available="
				+ available + ", rentPrice=" + rentPrice + "]";
	}
	
	
}
