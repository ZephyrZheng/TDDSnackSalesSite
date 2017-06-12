package com.tdd.domain;

import java.util.HashSet;
import java.util.Set;

import com.alibaba.fastjson.annotation.JSONField;

//用户
public class User {

	// 主键
	private Long user_id;
	// 登录名称
	private String user_name;
	// 真实姓名
	private String user_real_name;
	// 密码（保存的时候，需要加密处理）
	private String user_pwd;

	// 性别
	private String user_sex;
	// 电话
	private String user_phone;
	// 地址
	private String user_address;
	
	//上传文件保存路径
	private String filepath;

	//订单（自己new）
	@JSONField(serialize=false)
	private Set<Orders> orders = new HashSet<Orders>();
	
	public Set<Orders> getOrders() {
		return orders;
	}
	public void setOrders(Set<Orders> orders) {
		this.orders = orders;
	}
	
	//多方购物车（自己new）
	@JSONField(serialize=false)
	private Set<ShopCar> shopcar = new HashSet<ShopCar>();
	public Set<ShopCar> getShopcar() {
		return shopcar;
	}
	public void setShopcar(Set<ShopCar> shopcar) {
		this.shopcar = shopcar;
	}
	
	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_real_name() {
		return user_real_name;
	}

	public void setUser_real_name(String user_real_name) {
		this.user_real_name = user_real_name;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}


}
