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
+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+
| id | title                  | description                     | max_players | user_id | rating_id | image_url                 |
+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+
|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |
+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+
	 */
	
	@Test
	void test_game_mapping() {
		assertNotNull(game);
		assertNotNull(game.getMaxPlayers()); 
		assertEquals(1, game.getId());
		assertEquals(4, game.getMaxPlayers());
		assertEquals("Call of Duty: Vanguard", game.getTitle());
	}
}
