package com.dao;

import com.entity.Order_;
import com.entity.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import java.sql.Date;
import java.util.List;


@Repository
public class OrderDao extends GenericDao<Order_> {
    @Autowired
    private RoomDao roomDao;

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

	public List<Order_> queryOrders(String sfzh, String name, String phone) {
		String jpql = "FROM Order_ u WHERE u.sfzh=:sfzh AND u.name=:name AND u.phone=:phone";
		Query query = getEntityManager().createQuery(jpql);
		query.setParameter("sfzh", sfzh);
		query.setParameter("name", name);
		query.setParameter("phone", phone);
		List<Order_> list = query.getResultList();
		System.out.println(list.toString());
		return list;
	}

	public boolean getCanOrder(Date inDate,String roomType) {
	    Room room = roomDao.find(roomType);
        String jpql = "FROM Order_ u WHERE u.inDate=:inDate AND u.room=:room";
        Query query = getEntityManager().createQuery(jpql);
        query.setParameter("inDate", inDate);
        query.setParameter("room", room);
        int count = query.getResultList().size();
        return count < room.getCount();
    }

    @Transactional
    public void cancelOrder(int id) {
        String jpql = "DELETE from Order_ u where u.id = :id";
        Query query = getEntityManager().createQuery(jpql);
        query.setParameter("id", id);
        query.executeUpdate();
    }
}
