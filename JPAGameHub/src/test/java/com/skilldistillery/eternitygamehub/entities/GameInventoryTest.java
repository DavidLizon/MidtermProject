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
	
//	SELECT * FROM game JOIN game_inventory;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+

	@Test
	void test_gameInventory_to_game_ManyToOne_mapping() {
		assertNotNull(inventory);
		assertEquals(1, inventory.getGame().getId());
		assertEquals(4, inventory.getGame().getMaxPlayers());
	}
	
//	SELECT * FROM game_inventory JOIN platform;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | name        |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 | Playstation |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	
	@Test
	void test_gameInventory_to_platform_ManyToOne_mapping() {
		assertNotNull(inventory);
		assertEquals(1, inventory.getPlatform().getId());
		assertEquals("Playstation", inventory.getPlatform().getName());
	}
	
//	SELECT * FROM game_inventory JOIN user WHERE user.id = 1;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_gameInventory_to_user_ManyToOne_mapping() {
		assertNotNull(inventory);
		assertEquals(1, inventory.getUser().getId());
		assertEquals("admin@fakeemail.com", inventory.getUser().getEmail());
	}
	
//	SELECT * FROM game_inventory JOIN sale;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | buyer_id | seller_id | game_inventory_id | sale_date           | rating_by_buyer | comment_by_buyer | rating_by_seller | comment_by_seller     | return_by_date | date_returned |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 |        1 |         2 |                 1 | 2021-12-11 03:33:30 |               5 | Fast shipping!   |                5 | Payment went through! | 2021-12-22     | 2021-12-21    |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	
	@Test
	void test_gameInventory_to_sales_OneToMany_mapping() {
		assertNotNull(inventory);
		assertNotNull(inventory.getSales());
		assertTrue(inventory.getSales().size() > 0);
	}
	
}
