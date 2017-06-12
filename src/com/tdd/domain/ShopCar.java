package com.tdd.domain;

public class ShopCar {
	
	//编写对象，购物车对应用户（一方）[不要自己new]
	private User user;

	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	private Long car_id;
	//用户外键
	//private Long user_id;
	//商品外键
	private Long goods_id;
	private int goods_num;
	private String car_createtime;
	private String car_state;
	private String car_note;
	
	public Long getCar_id() {
		return car_id;
	}
	public void setCar_id(Long car_id) {
		this.car_id = car_id;
	}
//	public Long getUser_id() {
//		return user_id;
//	}
//	public void setUser_id(Long user_id) {
//		this.user_id = user_id;
//	}
	public Long getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(Long goods_id) {
		this.goods_id = goods_id;
	}
	public int getGoods_num() {
		return goods_num;
	}
	public void setGoods_num(int goods_num) {
		this.goods_num = goods_num;
	}
	public String getCar_createtime() {
		return car_createtime;
	}
	public void setCar_createtime(String car_createtime) {
		this.car_createtime = car_createtime;
	}
	public String getCar_state() {
		return car_state;
	}
	public void setCar_state(String car_state) {
		this.car_state = car_state;
	}
	public String getCar_note() {
		return car_note;
	}
	public void setCar_note(String car_note) {
		this.car_note = car_note;
	}
	
	public String toString() {
		return "[car_id:" + car_id + ", goods_id:" + goods_id + ", goods_num:" + goods_num + ", car_createtime:" + car_createtime + ", car_state:" + car_state + ", car_note:" + car_note + "]";
	}
	
	
}
