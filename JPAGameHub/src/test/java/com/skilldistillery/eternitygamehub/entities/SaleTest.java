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

//	select * from sale; 
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	| id | buyer_id | seller_id | game_inventory_id | sale_date           | rating_by_buyer | comment_by_buyer | rating_by_seller | comment_by_seller     | return_by_date | date_returned |
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	|  1 |        1 |         2 |                 1 | 2021-12-11 03:33:30 |               5 | Fast shipping!   |                5 | Payment went through! | 2021-12-22     | 2021-12-21  
//	
	
	@Test
	void test_user_mapping() {
		assertNotNull(sale);
		assertEquals(1, sale.getId()); 
		assertEquals(2021, sale.getSaleDate().getYear()); 
		assertEquals(12, sale.getSaleDate().getMonthValue()); 
	}
}
