package com.skilldistillery.eternitygamehub.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.skilldistillery.eternitygamehub.entities.GameInventory;
import com.skilldistillery.eternitygamehub.entities.Sale;

@Repository 
@Transactional
public class SaleDAOImpl implements SaleDAO {

	@PersistenceContext
	private EntityManager em; 
	
	@Override
	public Sale processPurchase(Sale sale) {
		// TODO Auto- method persist sale + update gameinventory item (available to false) 
		GameInventory gi = em.find(GameInventory.class, sale.getGameInventory().getId());
		gi.setUser(sale.getBuyer());
		gi.setAvailable(false);
		em.persist(sale);
		return sale;
	}
}
