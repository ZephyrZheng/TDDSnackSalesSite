package com.tdd.domain;

public class Goods {
	//商品主键
	private Long goods_id;
	//商品名称
	private String goods_name;
	//商品类型
	private Long cat_id;
	//商品价格
	private Float goods_price;
	//商品备注
	private String goods_detail;
	//商品库存
	private int goods_inventory;
	//商品图片
	private String goods_pic;
	//商品上架状态（1上架,0下架）
	private char goods_state;
	
	public Long getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(Long goods_id) {
		this.goods_id = goods_id;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public Long getCat_id() {
		return cat_id;
	}
	public void setCat_id(Long cat_id) {
		this.cat_id = cat_id;
	}
	public Float getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(Float goods_price) {
		this.goods_price = goods_price;
	}
	public String getGoods_detail() {
		return goods_detail;
	}
	public void setGoods_detail(String goods_detail) {
		this.goods_detail = goods_detail;
	}
	public int getGoods_inventory() {
		return goods_inventory;
	}
	public void setGoods_inventory(int goods_inventory) {
		this.goods_inventory = goods_inventory;
	}
	public String getGoods_pic() {
		return goods_pic;
	}
	public void setGoods_pic(String goods_pic) {
		this.goods_pic = goods_pic;
	}
	public char getGoods_state() {
		return goods_state;
	}
	public void setGoods_state(char goods_state) {
		this.goods_state = goods_state;
	}


}
