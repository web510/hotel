package com.dao;

import com.entity.Order_;
import com.entity.Room;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;


@Repository
public class OrderDao extends GenericDao<Order_> {
	@Transactional
	public Order_ insert(Date inDate, String name, String sfzh, String phone, Room room) {
	    Order_ order = new Order_();
	    order.setInDate(inDate);
	    order.setName(name);
	    order.setSfzh(sfzh);
	    order.setPhone(phone);
	    order.setRoom(room);
        persist(order);
        refresh(order);
        return order;
    }
}
