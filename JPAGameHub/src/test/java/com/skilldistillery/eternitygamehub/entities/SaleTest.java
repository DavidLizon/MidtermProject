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

class SaleTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Sale sale;

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
		sale = em.find(Sale.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		sale = null;
	}

	@Test
	void test_user_mapping() {
		assertNotNull(sale);
		assertEquals(1, sale.getId()); 
	}
}
