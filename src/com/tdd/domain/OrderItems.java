package com.tdd.domain;

public class OrderItems {
	//自增主键
	private Long ori_id;
	//一方订单主键(转为私有一方对象,不要new)
	//private Long ord_id;
	//商品数量
	private int goods_num;
	//收货地址(每个订单项对应)
	private String rec_state;
	//物流方式
	private String ori_passway;
	//商品id外键
	private Long goods_id;
	
	//一方订单
	private Orders orders;

	public Long getOri_id() {
		return ori_id;
	}

	public void setOri_id(Long ori_id) {
		this.ori_id = ori_id;
	}

	public int getGoods_num() {
		return goods_num;
	}

	public void setGoods_num(int goods_num) {
		this.goods_num = goods_num;
	}

	public String getRec_state() {
		return rec_state;
	}

	public void setRec_state(String rec_state) {
		this.rec_state = rec_state;
	}

	public String getOri_passway() {
		return ori_passway;
	}

	public void setOri_passway(String ori_passway) {
		this.ori_passway = ori_passway;
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	public Long getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(Long goods_id) {
		this.goods_id = goods_id;
	}

	public String toString() {
		return "OrderItems [ori_id=" + ori_id + ", goods_num=" + goods_num + ", rec_state=" + rec_state + ", ori_passway=" + ori_passway + ", goods_id=" + goods_id + ", orders=" + orders.getOrd_id() + "]";
	}

	
}
