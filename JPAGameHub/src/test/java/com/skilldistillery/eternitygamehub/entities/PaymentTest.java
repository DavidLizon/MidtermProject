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

class PaymentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Payment payment;

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
		payment = em.find(Payment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		payment = null;
	}
	
//	 select * from payment;
//	 +----+---------------------+--------+---------+
//	 | id | payment_date        | amount | sale_id |
//	 +----+---------------------+--------+---------+
//	 |  1 | 2021-12-11 03:33:30 |  12.99 |       1 |
//	 +----+---------------------+--------+---------+
	
	@Test
	void test_payment_mapping() {
		assertNotNull(payment);
		assertEquals(2021, payment.getPaymentDate().getYear()); 
		assertEquals(12, payment.getPaymentDate().getMonthValue()); 
		assertEquals(12.99, payment.getAmount()); 
	}
}
