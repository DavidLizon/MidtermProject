package com.skilldistillery.eternitygamehub.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Sale {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "sale_date")
	private LocalDateTime saleDate;
	
	@Column(name = "rating_by_buyer")
	private int ratingByBuyer;
	
	@Column(name = "comment_by_buyer")
	private String commentByBuyer;
	
	@Column(name = "rating_by_seller")
	private int ratingBySeller;
	
	@Column(name = "comment_by_seller")
	private String commentBySeller;
	
	@Column(name = "return_by_date")
	private LocalDateTime returnByDate;
	
	@Column(name = "date_returned")
	private LocalDateTime dateReturned;
	
	public Sale() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(LocalDateTime saleDate) {
		this.saleDate = saleDate;
	}

	public int getRatingByBuyer() {
		return ratingByBuyer;
	}

	public void setRatingByBuyer(int ratingByBuyer) {
		this.ratingByBuyer = ratingByBuyer;
	}

	public String getCommentByBuyer() {
		return commentByBuyer;
	}

	public void setCommentByBuyer(String commentByBuyer) {
		this.commentByBuyer = commentByBuyer;
	}

	public int getRatingBySeller() {
		return ratingBySeller;
	}

	public void setRatingBySeller(int ratingBySeller) {
		this.ratingBySeller = ratingBySeller;
	}

	public String getCommentBySeller() {
		return commentBySeller;
	}

	public void setCommentBySeller(String commentBySeller) {
		this.commentBySeller = commentBySeller;
	}

	public LocalDateTime getReturnByDate() {
		return returnByDate;
	}

	public void setReturnByDate(LocalDateTime returnByDate) {
		this.returnByDate = returnByDate;
	}

	public LocalDateTime getDateReturned() {
		return dateReturned;
	}

	public void setDateReturned(LocalDateTime dateReturned) {
		this.dateReturned = dateReturned;
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
		Sale other = (Sale) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Sale [id=" + id + ", saleDate=" + saleDate + ", ratingByBuyer=" + ratingByBuyer + ", commentByBuyer="
				+ commentByBuyer + ", ratingBySeller=" + ratingBySeller + ", commentBySeller=" + commentBySeller
				+ ", returnByDate=" + returnByDate + ", dateReturned=" + dateReturned + "]";
	}
	
	
	
}
