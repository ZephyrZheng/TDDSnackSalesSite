package com.tdd.service;

import org.springframework.transaction.annotation.Transactional;

import com.tdd.dao.CategoryDao;
import com.tdd.domain.Category;

@Transactional
public class CategoryServiceImpl implements CategoryService {

	private CategoryDao categoryDao;
	public void setCategoryDao(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	public Category findById(Long cat_id) {
		return categoryDao.findById(cat_id);
	}
	
	
}
