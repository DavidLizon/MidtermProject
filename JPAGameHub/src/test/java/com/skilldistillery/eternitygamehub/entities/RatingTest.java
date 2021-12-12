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

class RatingTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Rating rating;

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
		rating = em.find(Rating.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		rating = null;
	}
	
//	select * from rating; 
//	| id | name | description                 |
//	+----+------+-----------------------------+
//	|  1 | E    | Game is rated for everyone. |

	@Test
	void test_rating_mapping() {
		assertNotNull(rating);
		assertEquals("E", rating.getName()); 
		assertEquals(1, rating.getId()); 
	}
	
//	SELECT * FROM game JOIN rating;
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+
//	| id | title                  | description                     | max_players | user_id | rating_id | image_url                 | id | name | description                 |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+
//	|  1 | Call of Duty: Vanguard | Description of game goes here.  |           4 |       1 |         1 | game image url goes here. |  1 | E    | Game is rated for everyone. |
//	+----+------------------------+---------------------------------+-------------+---------+-----------+---------------------------+----+------+-----------------------------+

	
	@Test
	void test_rating_to_games_OneToMany_mapping() {
		assertNotNull(rating);
		assertTrue(rating.getGames().size() > 0);
	}
}
