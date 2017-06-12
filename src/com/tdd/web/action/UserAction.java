package com.tdd.web.action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.Orders;
import com.tdd.domain.ShopCar;
import com.tdd.domain.User;
import com.tdd.service.GoodsService;
import com.tdd.service.OrdersService;
import com.tdd.service.ShopCarService;
import com.tdd.service.UserService;
import com.tdd.utils.FastJsonUtil;
import com.tdd.utils.UploadUtils;

public class UserAction extends ActionSupport implements ModelDriven<User> {

	private static final long serialVersionUID = 6660889339451197917L;

	private User user = new User();
	
	public User getModel() {
		return user;
	}
	
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	//注入用户,购物车,订单Service
	private GoodsService goodsService;
	private ShopCarService shopCarService;
	public void setGoodsService(GoodsService goodsService) {
		this.goodsService = goodsService;
	}
	public void setShopCarService(ShopCarService shopCarService) {
		this.shopCarService = shopCarService;
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

	/*
	 *	文件上传：定义成员属性，命名要有特定规则
	 * 	File upload; 上传文件 
	 * 	String uploadFileName; 上传文件名 
	 * 	String uploadContentType;	上传文件类型
	 */
	private File upload;
	private String uploadFileName;
	
	public void setUpload(File upload) {
		this.upload = upload;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	//保存用户
	public String save(){
		//用户有文件上传
		if (uploadFileName != null) {
			System.out.println("文件名："+ uploadFileName);
			//更名
			String uuidname = UploadUtils.getUUIDName(uploadFileName);
			//上传
			String path = "E:\\Study\\tomcat\\apache-tomcat-9.0.0.M13\\webapps\\upload_test\\";
			
			//创建file对象
			File file = new File(path+uuidname);
			try {
				//保存文件
				FileUtils.copyFile(upload, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			//路径存入客户表
			user.setFilepath(path+uuidname);
		}
		
		userService.save(user);
		return "save";
	}
	
	//分页查找
	public String findByPage(){
		//统计所有数据行数
		int allcount = userService.findAll().size();
		
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<User> rows = userService.findByPage(intPage,number,criteria);
		
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
	
	//验证用户是否存在
	public String checkUser(String username){
		
		// 获取response对象
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		try {
			// 获取输出流
			PrintWriter writer = response.getWriter();
			// 进行判断
			if(username=="admin"){
				// 说明：登录名查询到用户了，说明登录已经存在了，不能注册
				writer.print("true");
			}else{
				// 说明，不存在登录名，可以注册
				writer.print("false");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return NONE;
	}
	
	//增加客户
	public String add(){
		
		userService.save(user);
		return "add";
	}
	
	//删除客户
	public String delete(){
		//获取jsp传递删除id
		System.out.println("delete_________id:" + user.getUser_id());
		user = userService.findById(user.getUser_id());
		userService.delete(user);
		return NONE;
	}
	
	//修改用户
	public String update(){
		//System.out.println(user);
		userService.update(user);
		return "update";
	}
	
	//前台提取订单条件
	public String Order_Q;
	public void setOrder_Q(String order_Q) {
		Order_Q = order_Q;
	}
	public String getOrder_Q() {
		return Order_Q;
	}
	//登录
	public String login(){
		ActionContext ac = ActionContext.getContext();
		User t_user = userService.login(user);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if (t_user!=null) {
			//写入session
		    ac.getSession().put("User_name",t_user.getUser_name());
		    ac.getSession().put("User_id",t_user.getUser_id());
			System.out.println("Sessionuser_name:"+t_user.getUser_name());
			
			//获取购物车数据
			List<ShopCar> list = userService.getShopCart(t_user.getUser_id());
			if (list!=null && !list.isEmpty()) {
				System.out.println("Return/Action_ShopcarList:"+list);
				//转成json （由于session存取json格式异常，曲线救国======》  页面登录之后延迟请求获取购物车）
//				Map<String, Object> shopcartmap = new HashMap<String, Object>();
//				//订单列表写入json给jsp
//				shopcartmap.put("ShopcarList", list);
//				String shopcarttoJson = FastJsonUtil.toJSONString(shopcartmap);
//				System.out.println("Action__Login__购物车列表listToJSON："+ shopcarttoJson);
				ac.getSession().put("ShopcarList","1");
			}
			List<Orders> orders_list = new ArrayList<>();
			//获取订单数据
			System.out.println("前台订单条件____："+Order_Q);
			if (Order_Q!=null) {
				orders_list = userService.getOrders(t_user.getUser_id(),Order_Q);
			}
			if (orders_list!=null && !orders_list.isEmpty()) {
				//System.out.println("Return/Action_OrderList:"+orders_list);
//				Map<String, Object> ordermap = new HashMap<String, Object>();
//				//订单列表写入json给jsp
//				ordermap.put("OrderList", orders_list);
//				String ordertoJson = FastJsonUtil.toJSONString(ordermap);
//				System.out.println("Action__Login__订单列表listToJSON："+ ordertoJson);
				ac.getSession().put("OrderList", "1");
			}
			
			
			//把查询用户信息返回前台请求
			jsonMap.put("User", t_user);
			jsonMap.put("LoginState", "1");
			String jsonString = FastJsonUtil.toJSONString(jsonMap);
			//System.out.println("UserJson__________:\n"+jsonString);
			HttpServletResponse response = ServletActionContext.getResponse();
			FastJsonUtil.write_json(response, jsonString);
	        
			return NONE;
		}else {
			ac.getSession().put("ShopcarList",null);
			ac.getSession().put("OrderList",null);
			jsonMap.put("LoginState", "-1");
			String jsonString = FastJsonUtil.toJSONString(jsonMap);
			System.out.println("登录失败_________jsonString__________:\n"+jsonString);
			HttpServletResponse response = ServletActionContext.getResponse();
			FastJsonUtil.write_json(response, jsonString);
			return NONE;
		}
	}
	
	//退出
	public String exit(){
		ActionContext ac = ActionContext.getContext();
	    ac.getSession().remove("User_name");
	    ac.getSession().remove("User_id");
	    ac.getSession().remove("ShopcarList");
	    ac.getSession().remove("OrderList");
	    System.out.println("Exit__Session_Removed.");
	    return NONE;
	}
	
	//注册(zzf,Todo...)
	public String regist(){
		System.out.println("注册：UserAction.java  的  regist()运行了！");
		System.out.println("注册：UserAction.java  的  regist()得到的user值："
				+user.getUser_name()
				+"   "+user.getUser_real_name()
				+"   "+user.getUser_pwd()
				+"   "+user.getUser_address()
				+"   "+user.getUser_phone()
				+"   "+user.getUser_sex()
		);

		Boolean result = userService.regist(user);

		System.out.println("注册：UserAction.java  userService.regist(user)注册用户到数据库结果："+result);

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(result){
			jsonMap.put("RegisterState", "1");
			String jsonString = FastJsonUtil.toJSONString(jsonMap);
			System.out.println("jsonString__________:\n"+jsonString);
			HttpServletResponse response = ServletActionContext.getResponse();
			FastJsonUtil.write_json(response, jsonString);
			System.out.println("注册：UserAction.java  已将注册成功的消息存入response");
		}else {
			jsonMap.put("RegisterState", "-1");
			String jsonString = FastJsonUtil.toJSONString(jsonMap);
			System.out.println("jsonString__________:\n"+jsonString);
			HttpServletResponse response = ServletActionContext.getResponse();
			FastJsonUtil.write_json(response, jsonString);
			System.out.println("注册：UserAction.java  已将注册失败的消息存入response");
		}
		return NONE;
	}
	
	//获取购物车
	public String getShopCart(){
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		System.out.println("传入用户ID______________:"+user.getUser_id());
		//System.out.println("传入商品ID______________:"+user.getUser_id());
		//后台用户表和购物车表连接查询返回
		List<ShopCar> shopcartlist = userService.getShopCart(user.getUser_id());
		//System.out.println("dao层list____"+shopcartlist);
		if(shopcartlist==null||shopcartlist.size()!=0){
			//System.out.println("List___"+shopcartlist);
			jsonMap.put("ShopCarList", shopcartlist);
		}else{
			jsonMap.put("ShopCarList", "0");
		}
		//写回前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		
		return NONE;
	}
	
	//获取订单
	public String getOrders(){
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		//System.out.println("传入用户ID______________:"+user.getUser_id());
		List<Orders> orderlist = userService.getOrders(user.getUser_id(),Order_Q);
		if (orderlist==null||orderlist.size()!=0) {
			jsonMap.put("OrderList", orderlist);
		}else {
			jsonMap.put("OrderList", "0");
		}
		
		//写回前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		System.out.println("JSP请求Order_list:__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		
		return NONE;
	}
	
}
