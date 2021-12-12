package com.skilldistillery.eternitygamehub.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class GameInventoryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private GameInventory inventory;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAGameHub");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		inventory = em.find(GameInventory.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		inventory = null;
	}

/*
 * SELECT * FROM game_inventory WHERE id = 1;
+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id |
+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |
+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
 */
	
	
	@Test
	void test_inventory_mapping() {
		assertNotNull(inventory);
		assertNotNull(inventory.getSalePrice()); 
		assertEquals(25.99, inventory.getSalePrice());
		assertEquals(2.99, inventory.getRentPrice());
	}
}
