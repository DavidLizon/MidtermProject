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

class GameTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Game game;

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
		game = em.find(Game.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		game = null;
	}

	/*
	 * SELECT * FROM game WHERE id = 1;
	 * +----+------------------------+---------------------------------+------------
	 * -+---------+-----------+---------------------------+ | id | title |
	 * description | max_players | user_id | rating_id | image_url |
	 * +----+------------------------+---------------------------------+------------
	 * -+---------+-----------+---------------------------+ | 1 | Call of Duty:
	 * Vanguard | Description of game goes here. | 4 | 1 | 1 | game image url goes
	 * here. |
	 * +----+------------------------+---------------------------------+------------
	 * -+---------+-----------+---------------------------+
	 */

	@Test
	void test_game_mapping() {
		assertNotNull(game);
		assertNotNull(game.getMaxPlayers());
		assertEquals(1, game.getId());
		assertEquals(4, game.getMaxPlayers());
		assertEquals("Call of Duty: Vanguard", game.getTitle());
	}

//	SELECT * FROM game JOIN rating;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | name | description                 |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | E    | Game is rated for everyone. |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+

	@Test
	void test_game_to_rating_ManyToOne_mapping() {
		assertNotNull(game);
		assertEquals(1, game.getRating().getId());
		assertEquals("E", game.getRating().getName());
	}

//	SELECT * FROM game JOIN genre;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | name   | description                        |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | Action | Heavy action and constant gameplay |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+
//	

	@Test
	void test_game_to_genres_ManyToMany_mapping() {
		assertNotNull(game);
		assertNotNull(game.getGenres());
		assertTrue(game.getGenres().size() > 0);
	}

//	SELECT * FROM game JOIN game_inventory;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+
	@Test
	void test_game_to_gameInventory_OneToMany_mapping() {
		assertNotNull(game);
		assertNotNull(game.getGameInventory());
		assertTrue(game.getGameInventory().size() > 0);
	}
	
//	SELECT * FROM game JOIN user WHERE user.id = 1;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_game_to_user_ManyToOne_mapping() {
		assertNotNull(game);
		assertNotNull(game.getUser());
		assertEquals(1, game.getUser().getId());
	}
}
