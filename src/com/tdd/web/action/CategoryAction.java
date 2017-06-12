package com.tdd.web.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.Category;
import com.tdd.service.CategoryService;
import com.tdd.utils.FastJsonUtil;

public class CategoryAction extends ActionSupport implements ModelDriven<Category>{

	private static final long serialVersionUID = -1073083992249221891L;
	
	private Long cat_id;
	public void setCat_id(Long cat_id) {
		this.cat_id = cat_id;
	}
	public Long getCat_id() {
		return cat_id;
	}
	
	private Category category = new Category();
	public Category getModel() {
		return category;
	}

	CategoryService categoryService;
	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
	public String findById() {
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map
		System.out.println("传入分类id___:"+category.getCat_id());
		cat_id = category.getCat_id();
		category = categoryService.findById(cat_id);
		System.out.println("分类名称_________"+category.getCat_name());
		if (category.getCat_parent()!=null) {
			//查询父类
			Category par = new Category();
			par = categoryService.findById(category.getCat_parent());
			System.out.println("父类名称_________"+par.getCat_name());
			
			jsonMap.put("Cat_parent", par.getCat_name());
		}
		
		jsonMap.put("Cat_name", category.getCat_name());

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}

}
