package com.tdd.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.OrderItems;
import com.tdd.domain.ShopCar;
import com.tdd.service.OrderItemsService;
import com.tdd.service.OrdersService;
import com.tdd.service.ShopCarService;
import com.tdd.utils.FastJsonUtil;

//订单项
public class OrderItemsAction extends ActionSupport implements ModelDriven<OrderItems>{

	private static final long serialVersionUID = 7293599550370532541L;

	private OrderItems orderItems = new OrderItems();
	public OrderItems getModel() {
		return orderItems;
	}
	
	private OrderItemsService orderItemsService;
	public void setOrderItemsService(OrderItemsService orderItemsService) {
		this.orderItemsService = orderItemsService;
	}
	
	//ordersService 查询所属订单信息Service
	private OrdersService ordersService;
	public void setOrdersService(OrdersService ordersService) {
		this.ordersService = ordersService;
	}
	
	//购物车service获取商品信息
	private ShopCarService shopCarService;
	public void setShopCarService(ShopCarService shopCarService) {
		this.shopCarService = shopCarService;
	}

	//search KeyWord
	private String key_word;
	public String getKey_word() {
		return key_word;
	}
	public void setKey_word(String key_word) {
		this.key_word = key_word;
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
		int allcount = orderItemsService.findAll().size();
		
		DetachedCriteria criteria = DetachedCriteria.forClass(OrderItems.class,"o");
		criteria.createAlias("o.orders", "p");
		criteria.createAlias("p.user", "u");
		//criteria.add(Restrictions.like("u.user_name", "%蜗牛%"));
		//按用户排序加时间排序
		criteria.addOrder(Order.asc("u.user_name")).addOrder(Order.asc("p.ord_createtime"));
		//DetachedCriteria criteria = DetachedCriteria.forClass(OrderItems.class);
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<OrderItems> rows = orderItemsService.findByPage(intPage,number,criteria);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("total", allcount);
		jsonMap.put("rows", rows);
		//System.out.println("jsonMap__________\n"+jsonMap);

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		//System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}

	//用户名查找
	public String findByName(){
		System.out.println("findByName"+key_word);
		DetachedCriteria criteria = DetachedCriteria.forClass(OrderItems.class,"o");
		criteria.createAlias("o.orders", "p");
		criteria.createAlias("p.user", "u");
		criteria.add(Restrictions.like("u.user_name", "%"+key_word+"%"));
		//按用户排序加时间排序
		criteria.addOrder(Order.asc("u.user_name")).addOrder(Order.asc("p.ord_createtime"));
		
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<OrderItems> rows = orderItemsService.findByPage(intPage,number,criteria);
        //统计所有数据行数
  		int allcount = rows.size();
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("total", allcount);
		jsonMap.put("rows", rows);
		//System.out.println("jsonMap__________\n"+jsonMap);

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}
	
	//订单号查找
	public String findByOrd_Id(){
		System.out.println("OrderItem/Action/查找订单id_____"+ord_id);
		DetachedCriteria criteria = DetachedCriteria.forClass(OrderItems.class);
		//根据订单号查找
		criteria.add(Restrictions.eq("orders", ordersService.findById(ord_id)));
		//按订单项排序
		criteria.addOrder(Order.asc("ori_id"));
        
        //获取当前页数据
        List<OrderItems> orderItems_list = orderItemsService.findByOrd_Id(criteria);
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("orderItems_list", orderItems_list);
		//System.out.println("jsonMap__________\n"+jsonMap);

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		System.out.println("OrderItemAction/订单项__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}
	
	//外键，jsp传入
	private Long ord_id;
	public Long getOrd_id() {
		return ord_id;
	}
	public void setOrd_id(Long ord_id) {
		this.ord_id = ord_id;
	}
	//jsp传入购物车外键
	private Long car_id;
	public Long getCar_id() {
		return car_id;
	}
	public void setCar_id(Long car_id) {
		this.car_id = car_id;
	}
	//添加订单项
	public String save(){
		orderItems.setOrders(ordersService.findById(ord_id));
		ShopCar shopCar_item = shopCarService.findByID(car_id);
		orderItems.setGoods_id(shopCar_item.getGoods_id());
		orderItems.setGoods_num(shopCar_item.getGoods_num());
		//默认未签收
		orderItems.setRec_state("0");
		//默认未确认
		//orderItems.setOri_state("0");
		//默认未支付
		//orderItems.setPay_state("0");
		System.out.println("保存订单项_________"+orderItems);
		orderItemsService.save(orderItems);
		//订单项保存状态写回前台
//		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
//		jsonMap.put("Ori_state", "1");
//		String jsonString = FastJsonUtil.toJSONString(jsonMap);
//		System.out.println("jsonString__________:\n"+jsonString);
//		HttpServletResponse response = ServletActionContext.getResponse();
//		FastJsonUtil.write_json(response, jsonString);
		
		return NONE;
	}
	
	
	//修改
	public String update(){
		System.out.println("update_orderItems'order ______"+ ord_id);
		orderItems.setOrders(ordersService.findById(ord_id));
		orderItemsService.update(orderItems);
		return "update";
	}
	
	public String delete(){
		System.out.println("delete_orderItems'_________id:"+ orderItems.getOri_id());
		orderItems = orderItemsService.findById(orderItems.getOri_id());
		orderItemsService.delete(orderItems);
		return "delete";
	}
	

}
