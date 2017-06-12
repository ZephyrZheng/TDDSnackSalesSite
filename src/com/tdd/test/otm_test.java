package com.tdd.test;

import org.junit.Test;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.tdd.domain.Orders;
import com.tdd.domain.User;


public class otm_test {

	// ctrl + shift + x
	private static final Configuration CONFIG;
	private static final SessionFactory FACTORY;
	
	// 编写静态代码块
		static{
			// 加载XML的配置文件
			CONFIG = new Configuration().configure();
			// 构造工厂
			FACTORY = CONFIG.buildSessionFactory();
		}
	
	@Test
	public void Test1() {
		Session session = FACTORY.getCurrentSession();
		Transaction tr = session.beginTransaction();
		// 保存客户和联系人的数据
		User u1 = new User();
		u1.setUser_name("美美");
		
		// 创建2个联系人
		Orders o1 = new Orders();
		o1.setOrd_note("熊大");
		Orders o2 = new Orders();
		o2.setOrd_note("熊二");
		
		o1.setUser(u1);
		u1.getOrders().add(o2);
		
		session.save(o1);
		tr.commit();
	}
	
}
