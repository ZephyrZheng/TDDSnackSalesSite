package com.tdd.domain;

public class Category {

	private Long cat_id;
	private String cat_name;
	private Long cat_parent;
	public Long getCat_id() {
		return cat_id;
	}
	public void setCat_id(Long cat_id) {
		this.cat_id = cat_id;
	}
	public String getCat_name() {
		return cat_name;
	}
	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}
	public Long getCat_parent() {
		return cat_parent;
	}
	public void setCat_parent(Long cat_parent) {
		this.cat_parent = cat_parent;
	}
	
}
