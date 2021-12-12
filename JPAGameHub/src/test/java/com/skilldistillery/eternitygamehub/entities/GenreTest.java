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

class GenreTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Genre genre;

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
		genre = em.find(Genre.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		genre = null;
	}
	
	/*
	 * SELECT * FROM genre WHERE id = 1;
+----+--------+------------------------------------+
| id | name   | description                        |
+----+--------+------------------------------------+
|  1 | Action | Heavy action and constant gameplay |
+----+--------+------------------------------------+
	 */

	@Test
	void test_genre_mapping() {
		assertNotNull(genre);
		assertNotNull(genre.getName()); 
		assertEquals(1, genre.getId());
		assertEquals("Action", genre.getName());
		assertEquals("Heavy action and constant gameplay", genre.getDescription());
	}
	
	
//	SELECT * FROM game JOIN genre;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | name   | description                        |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | Action | Heavy action and constant gameplay |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+--------+------------------------------------+

	
	@Test
	void test_genre_to_games_ManyToMany_mapping() {
		assertNotNull(genre);
		assertNotNull(genre.getGames());
		assertTrue(genre.getGames().size() > 0);
	}
	


	
}
