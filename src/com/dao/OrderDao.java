package com.dao;

import com.entity.Admin;
import com.entity.Order;
import com.entity.Room;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import javax.persistence.Query;
import java.sql.Date;


@Repository
public class OrderDao extends GenericDao<Order> {
	public void insert(Date inDate, Date outDate, String name, String sfzh, String phone, Room room) {
	    Order order = new Order();
	    order.setInDate(inDate);
	    order.setOutDate(outDate);
	    order.setName(name);
	    order.setSfzh(sfzh);
	    order.setPhone(phone);
	    order.setRoom(room);
        persist(order);
    }
}
