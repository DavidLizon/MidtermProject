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

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_user_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
//	SELECT * FROM game_inventory JOIN user WHERE user.id = 1;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_user_to_gameInventory_OneToMany_mapping() {
		assertNotNull(user);
		assertNotNull(user.getGameInventory());
		assertTrue(user.getGameInventory().size() > 0);
	}
	
//	SELECT * FROM sale JOIN user WHERE user.id = 1;
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | buyer_id | seller_id | game_inventory_id | sale_date           | rating_by_buyer | comment_by_buyer | rating_by_seller | comment_by_seller     | return_by_date | date_returned | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 |        1 |         2 |                 1 | 2021-12-11 03:33:30 |               5 | Fast shipping!   |                5 | Payment went through! | 2021-12-22     | 2021-12-21    |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_user_to_sale_OneToMany_mapping() {
		assertNotNull(user);
		assertNotNull(user.getBuyers());
		assertNotNull(user.getSellers());
		assertTrue(user.getBuyers().size() > 0);
//		assertTrue(user.getSellers().size() > 0); will become valid test when more data is populated
	}
	
//	SELECT * FROM game JOIN user WHERE user.id = 1;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_user_to_games_OneToMany_mapping() {
		assertNotNull(user);
		assertNotNull(user.getGames());
		assertTrue(user.getGames().size() > 0);
	}
	
}
