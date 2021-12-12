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

class PlatformTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Platform platform;

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
		platform = em.find(Platform.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		platform = null;
	}
	
//	select * from platform; 
//	+----+-------------+
//	| id | name        |
//	+----+-------------+
//	|  1 | Playstation |
//	+----+-------------+

	@Test
	void test_platform_mapping() {
		assertNotNull(platform);
		assertEquals("Playstation", platform.getName()); 
	}
	
//	SELECT * FROM game_inventory JOIN platform;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | name        |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 | Playstation |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+-------------+
//	
	@Test
	void test_platform_to_gameInventory_OneToMany_mapping() {
		assertNotNull(platform);
		assertNotNull(platform.getGameInventory());
		assertTrue(platform.getGameInventory().size() > 0);
	}
}
