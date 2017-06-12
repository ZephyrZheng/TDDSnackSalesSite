package com.tdd.web.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;
import com.tdd.service.ShopCarService;
import com.tdd.service.UserService;
import com.tdd.utils.FastJsonUtil;

public class ShopCarAction extends ActionSupport implements ModelDriven<ShopCar>{

	private static final long serialVersionUID = -8364576748324502149L;
	
	private Long user_id;
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	private ShopCar ShopCar = new ShopCar();
	public ShopCar getModel() {
		return ShopCar;
	}
	
	private ShopCarService shopCarService;
	public void setShopCarService(ShopCarService shopCarService) {
		this.shopCarService = shopCarService;
	}
	
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	//分页
	private String rows;//传入每页显示的记录数  
    
    private String page;//传入当前第几页  
	
	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}
	
	//分页查找
	public String findByPage(){
		//统计所有数据行数
		int allcount = shopCarService.findAll().size();
		
		DetachedCriteria criteria = DetachedCriteria.forClass(ShopCar.class,"s");
		criteria.createAlias("s.user", "u");
//		criteria.createAlias("o.orders", "p");
//		criteria.createAlias("p.user", "u");
		//criteria.add(Restrictions.like("u.user_name", "%蜗牛%"));
		//按用户排序与时间排序
		criteria.addOrder(Order.asc("u.user_name")).addOrder(Order.asc("car_createtime"));
		
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<ShopCar> rows = shopCarService.findByPage(intPage,number,criteria);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("total", allcount);
		jsonMap.put("rows", rows);
		//System.out.println("jsonMap__________\n"+jsonMap);

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		//System.out.println("ShopCarAction/jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}
	
	//依据用户查询购物车
	public String findByUid(){
		DetachedCriteria criteria = DetachedCriteria.forClass(ShopCar.class);
		//criteria.add(Restrictions.eq("user_id", ShopCar.getUser_id()));
		//时间排序
		criteria.addOrder(Order.asc("car_createtime"));
		return null;
	}
	
	public String update(){
		System.out.println("ShopCarAction/Update/u_id___________"+user_id);
		ShopCar.setUser(userService.findById(user_id));
		shopCarService.update(ShopCar);
		return "update";
	}
	
	//删除购物车
	public String delete(){
		//获取jsp传递删除id
		System.out.println("delete_________id:" + ShopCar.getCar_id());
		ShopCar = shopCarService.findByID(ShopCar.getCar_id());
		shopCarService.delete(ShopCar);
		return "delete";
	}
	
	//添加购物车
	public String addShopcart(){
		//添加时间
		String add_time = null;  
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        Date date = new Date();  
        add_time = f.format(date);
        System.out.println("添加购物车时间__________："+add_time);
        ShopCar.setCar_createtime(add_time);
        ShopCar.setCar_state("1");
        System.out.println("用户id______"+user_id);
        User addCar_ofUser = userService.findById(user_id);
        ShopCar.setUser(addCar_ofUser);
        //System.out.println("传入购物车对象：_____" + ShopCar+",用户:____"+addCar_ofUser);
        //购物车相同累加
        ShopCar ifsame = shopCarService.getSameGood(ShopCar.getGoods_id(),addCar_ofUser);
        if (ifsame!=null) {
        	int old_n = ifsame.getGoods_num();
        	ifsame.setGoods_num(old_n+ShopCar.getGoods_num());
        	ifsame.setCar_createtime(add_time);
        	ifsame.setUser(addCar_ofUser);
        	System.out.println("存在相同，更新原购物车"+ifsame);
        	shopCarService.update(ifsame);
		}else{
			System.out.println("新增购物车项"+ShopCar);
			shopCarService.save(ShopCar);
		}
        
        return NONE;
	}
}
