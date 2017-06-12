package com.tdd.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.Orders;
import com.tdd.domain.User;
import com.tdd.service.OrdersService;
import com.tdd.service.UserService;
import com.tdd.utils.FastJsonUtil;
import com.tdd.utils.Gen_Time;

public class OrdersAction extends ActionSupport implements ModelDriven<Orders>{

	private static final long serialVersionUID = -8545679493651069656L;

	//传入一方User
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	private Long u_id;
	public Long getU_id() {
		return u_id;
	}
	public void setU_id(Long u_id) {
		this.u_id = u_id;
	}

	//订单主键
	private Long ordid;
	public Long getOrdid() {
		return ordid;
	}
	public void setOrdid(Long ordid) {
		this.ordid = ordid;
	}
	private Orders orders = new Orders();
	
	public Orders getModel() {
		return orders;
	}
	
	private OrdersService ordersService;
	public void setOrdersService(OrdersService ordersService) {
		this.ordersService = ordersService;
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
		int allcount = ordersService.findAll().size();
		
		DetachedCriteria criteria = DetachedCriteria.forClass(Orders.class,"o");
		criteria.createAlias("o.user", "u");
		criteria.addOrder(Order.asc("u.user_name")).addOrder(Order.asc("o.ord_createtime"));
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<Orders> rows = ordersService.findByPage(intPage,number,criteria);
		
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
	
//	public String findById(Long id){
//		ordersService.findById(id);
//		return NONE;
//	}
	
	//添加订单
	public String save(){
		User ord_user = userService.findById(u_id);
		orders.setUser(ord_user);
		//订单号
		String paymentID = Gen_Time.getOrdId();
		orders.setOrd_number(paymentID);
		//订单创建时间
		String add_time = Gen_Time.getFormattime();
        System.out.println("创建订单时间__________：" + add_time);
		orders.setOrd_createtime(add_time);
		//订单状态:未支付default
		orders.setOrd_state("0");
		orders.setPay_state("0");
		//默认收货地址(Useraddress)
		orders.setOrd_address(ord_user.getUser_address());
		
		
		//保存订单
		System.out.println("保存订单______"+orders);
		ordersService.save(orders);
		//生成订单主键,订单号 返回给前台方便插入订单项
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("OrdNum", orders.getOrd_number());
		if (ordersService.findByOrd_Num(paymentID)!=null) {
			Long return_ordId = ordersService.findByOrd_Num(paymentID).getOrd_id();
			jsonMap.put("Ord_id", return_ordId);
		}
		
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		//System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		
		return NONE;
	}
	
	public Orders findByOrd_Num(String paymentID){
		Orders return_jsp = new Orders();
		return_jsp = ordersService.findByOrd_Num(paymentID);
		return return_jsp;
	}
	
	public String update(){
		System.out.println("OrderAction/update_orders'user_____"+u_id);//+userService.findById(u_id));
		orders.setUser(userService.findById(u_id));		
		ordersService.update(orders);
		return "update";
	}
	
	//订单地址
	private String ord_add;
	public String getOrd_add() {
		return ord_add;
	}
	public void setOrd_add(String ord_add) {
		this.ord_add = ord_add;
	}
	public String confirmOrder(){		
		//更新地址
		System.out.println("OrderAction/confirmOrder/更新id_________" + ordid + "地址__________" + ord_add);
		//orders.setUser(userService.findById(u_id));
		orders = ordersService.findById(ordid);
		orders.setOrd_address(ord_add);
		//确认订单
		orders.setOrd_state("1");
		ordersService.update(orders);
		return NONE;
	}
	
	//支付
	public String pay(){
		System.out.println("pay_________id:" + ordid);
		orders = ordersService.findById(ordid);
		orders.setPay_state("1");
		ordersService.save(orders);
		return NONE;
	}
	
	//删除订单
	public String delete(){
		//获取jsp传递删除id
		System.out.println("delete_________id:" + ordid);
		orders = ordersService.findById(ordid);
		//System.out.println("删除order"+orders);
		ordersService.delete(orders);
		return NONE;
	}
}
