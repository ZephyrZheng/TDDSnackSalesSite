package com.tdd.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

/*
 * 通用接口，以后所有DAO接口都要继承BaseDao接口
 * 自定义泛型接口
 */
public interface BaseDao<T> {
	
	public void save(T t);
	
	public void delete(T t);
	
	public void update(T t);
	
	public T findById(Long id);
	
	public List<T> findAll();
	
	public List<T> findByPage(int intPage, int number, DetachedCriteria criteria);
	
	public List<T> findByName(DetachedCriteria criteria);
}
