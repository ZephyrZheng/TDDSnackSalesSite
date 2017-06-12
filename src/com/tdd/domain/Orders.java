package com.tdd.domain;

import java.util.HashSet;
import java.util.Set;

import com.alibaba.fastjson.annotation.JSONField;

public class Orders {
	//订单主键
	private Long ord_id;
/*	外键，下单用户id
	private Long user_id;*/
	//订单号(标识)
	private String ord_number;
	//创建时间
	private String ord_createtime;
	//订单状态
	private String ord_state;
	//支付状态 
	private String pay_state;
	//备注
	private String ord_note;
	//订单地址
	private String ord_address;
	
	//多方商品项(自己new)
	@JSONField(serialize=false)
	private Set<OrderItems> orderItems = new HashSet<OrderItems>();
	public Set<OrderItems> getOrderItems() {
		return orderItems;
	}
	public void setOrderItems(Set<OrderItems> orderItems) {
		this.orderItems = orderItems;
	}

	//编写对象，订单对应用户（一方）[不要自己new]
	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Long getOrd_id() {
		return ord_id;
	}

	public void setOrd_id(Long ord_id) {
		this.ord_id = ord_id;
	}

	public String getOrd_number() {
		return ord_number;
	}

	public void setOrd_number(String ord_number) {
		this.ord_number = ord_number;
	}

	public String getOrd_createtime() {
		return ord_createtime;
	}

	public void setOrd_createtime(String ord_createtime) {
		this.ord_createtime = ord_createtime;
	}

	public String getOrd_state() {
		return ord_state;
	}

	public void setOrd_state(String ord_state) {
		this.ord_state = ord_state;
	}

	public String getPay_state() {
		return pay_state;
	}
	
	public void setPay_state(String pay_state) {
		this.pay_state = pay_state;
	}
	public String getOrd_note() {
		return ord_note;
	}

	public void setOrd_note(String ord_note) {
		this.ord_note = ord_note;
	}
	
	public String getOrd_address() {
		return ord_address;
	}
	public void setOrd_address(String ord_address) {
		this.ord_address = ord_address;
	}

	public String toString() {
		return "Orders [ord_id=" + ord_id + ", ord_number=" + ord_number + ", ord_createtime=" + ord_createtime + ", ord_state=" + ord_state + ", pay_state=" + pay_state + ", ord_note=" + ord_note + ", ord_address=" + ord_address + ", orderItems=" + orderItems + ", user=" + user + "]";
	}

	

	
	
}
