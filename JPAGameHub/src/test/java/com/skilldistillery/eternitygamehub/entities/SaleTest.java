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
	void test_sale_mapping() {
		assertEquals(1, sale.getId()); 
		assertEquals(2021, sale.getSaleDate().getYear()); 
		assertEquals(12, sale.getSaleDate().getMonthValue()); 
	}
	
//	SELECT * FROM game_inventory JOIN sale;
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	| id | game_id | user_id | description                             | sale_price | available | rent_price | platform_id | id | buyer_id | seller_id | game_inventory_id | sale_date           | rating_by_buyer | comment_by_buyer | rating_by_seller | comment_by_seller     | return_by_date | date_returned |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	|  1 |       1 |       1 | Sellers personal description goes here. |      25.99 |         1 |       2.99 |           1 |  1 |        1 |         2 |                 1 | 2021-12-11 03:33:30 |               5 | Fast shipping!   |                5 | Payment went through! | 2021-12-22     | 2021-12-21    |
//	+----+---------+---------+-----------------------------------------+------------+-----------+------------+-------------+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+
//	
	@Test
	void test_sale_to_gameInventory_ManyToOne_mapping() {
		assertNotNull(sale);
		assertEquals(1, sale.getGameInventory().getId());
		assertEquals(25.99, sale.getGameInventory().getSalePrice());	
	}
	
//	SELECT * FROM sale JOIN user WHERE user.id = 1;
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	| id | buyer_id | seller_id | game_inventory_id | sale_date           | rating_by_buyer | comment_by_buyer | rating_by_seller | comment_by_seller     | return_by_date | date_returned | id | username | first_name | last_name | password | email               | account_created     | biography                | enabled | role   | profile_picture_url            |
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	|  1 |        1 |         2 |                 1 | 2021-12-11 03:33:30 |               5 | Fast shipping!   |                5 | Payment went through! | 2021-12-22     | 2021-12-21    |  1 | admin    | admin      | admin     | admin    | admin@fakeemail.com | 2021-12-11 03:24:53 | The biography goes here. |       1 | seller | profile picture url goes here. |
//	+----+----------+-----------+-------------------+---------------------+-----------------+------------------+------------------+-----------------------+----------------+---------------+----+----------+------------+-----------+----------+---------------------+---------------------+--------------------------+---------+--------+--------------------------------+
//	
	@Test
	void test_sale_to_user_ManyToOne_mapping() {
		assertNotNull(sale);
		assertEquals(1, sale.getBuyer().getId());
		assertEquals(2, sale.getSeller().getId());
	}
	
}
