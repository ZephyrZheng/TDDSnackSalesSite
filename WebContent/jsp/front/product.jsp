<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <!-- Basic page needs
	============================================ -->
	<title>商品详情</title>
	<meta charset="utf-8">
    <meta name="keywords" content="" />
    <meta name="author" content="Magentech">
    <meta name="robots" content="index, follow" />
   
	<!-- Mobile specific metas
	============================================ -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	
	<!-- Favicon
	============================================ -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="ico/favicon.png">
	
	<!-- Google web fonts
	============================================ -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
    <!-- Libs CSS
	============================================ -->
    <link rel="stylesheet" href="css/bootstrap/css/bootstrap.min.css">
	<link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="js/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="js/owl-carousel/owl.carousel.css" rel="stylesheet">
	<link href="css/themecss/lib.css" rel="stylesheet">
	<link href="js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
	
	<!-- Theme CSS
	============================================ -->
   	<link href="css/themecss/so_megamenu.css" rel="stylesheet">
    <link href="css/themecss/so-categories.css" rel="stylesheet">
	<link href="css/themecss/so-listing-tabs.css" rel="stylesheet">
 	<link id="color_scheme" href="css/theme.css" rel="stylesheet">
 	<link href="css/responsive.css" rel="stylesheet">	  
	
	<!-- 函数库 -->
	<!-- <script type="text/javascript" src="js/product.js"></script> -->
	<script type="text/javascript">
	
	/*全局数据变量*/
	var local_data = "";
	var local_cat = "";
	var local_pics = "";
	/* 获取index关键字 */
	var key_word='<%= request.getParameter("key_word") %>';
	//Session获取用户 / 购物车列表
	var u_name ="<%=session.getAttribute("User_name")%>";
	var u_id ="<%=session.getAttribute("User_id")%>"; 
	var shopCar = "<%=session.getAttribute("ShopcarList")%>";
	var orderlist = "<%=session.getAttribute("OrderList")%>";   
	//alert("当前session_购物车"+shopCar);
	function load()
	{//发送请求获取数据，填充页面
		//alert("#$@#$");
		//$('#Search_goods').val();
		//alert('搜索关键词'+key_word);
		//var key_word = "达利园蛋黄派";
		//alert(key_word);
		//alert(orderlist);
		if(key_word!=null&&key_word!=""){
			var url = '${ pageContext.request.contextPath }/goods_findByName.action?good_key_word='
				+key_word;
			var param = {};
			$.post(url,param,function(data){
				local_data = data;
				//alert("请求返回数据");
				//alert(data.rows[0].goods_name);
				//http://stackoverflow.com/questions/10084234/how-to-parse-multi-dimensional-json-data-through-javascript
				
				//商品无效
				if(data.rows[0].goods_state=="0"){
					//alert("商品无效");
					
					//禁用按钮
					document.getElementById("button-cart").disabled = true;
					
					document.getElementById("g_detail").innerHTML = "<span><font size=\"3\" color=\"#BEBEBE\">描述:</font><br></span>" + data.rows[0].goods_detail;
					document.getElementById("g_inventory").innerHTML = "<span><font size=\"3\" color=\"#BEBEBE\">库存：</font></span><font size=\"2\">" 
						+ data.rows[0].goods_inventory + "</font>";
					document.getElementById("h_name").innerHTML = "<font color=\"#BEBEBE\">" + data.rows[0].goods_name + " (商品失效)</font>";
					var old_p = data.rows[0].goods_price;
					var new_p = data.rows[0].goods_price + 3.0;
					document.getElementById("n_price").innerHTML = old_p + '￥';
					document.getElementById("o_price").innerHTML = new_p + '￥';
					//Todo..异步请求填充分类
					Get_category(data.rows[0].cat_id);
					
					var rel_path = data.rows[0].goods_pic;
					rel_path = rel_path.replace(/\\/g,"/");
					//alert(rel_path);
					var pics =  rel_path.split(",");
					local_pics = pics;
					//for(var i=0; i<pics.length; i++) alert(pics[i]);
					//图片更新
					$("#g_img_1").attr("src", pics[0]); 
					$("#g_img_1").attr('data-zoom-image', pics[0]);
					$("#good_a0").attr('data-image', pics[0]);
					document.getElementById("gth_0").src = pics[0];
					
					$("#good_a1").attr('data-image', pics[1]);
					document.getElementById("gth_1").src = pics[1];
					
					$("#good_a2").attr('data-image', pics[2]);
					document.getElementById("gth_2").src = pics[2];
					
					$("#good_a3").attr('data-image', pics[3]);
					document.getElementById("gth_3").src = pics[3];
					//alert("点击0img"); 回避不回显bug
					document.getElementById("good_a0").click();
				}else{
					document.getElementById("g_detail").innerHTML = "<span><font size=\"3\" color=\"#FF8000\">描述:</font><br></span>" + data.rows[0].goods_detail;
					document.getElementById("g_inventory").innerHTML = "<span><font size=\"3\" color=\"#FF8000\">库存：</font></span><font size=\"2\">" 
						+ data.rows[0].goods_inventory + "</font>";
					document.getElementById("h_name").innerHTML = data.rows[0].goods_name;
					var old_p = data.rows[0].goods_price;
					var new_p = data.rows[0].goods_price + 3.0;
					document.getElementById("n_price").innerHTML = old_p + '￥';
					document.getElementById("o_price").innerHTML = new_p + '￥';
					//Todo..异步请求填充分类
					Get_category(data.rows[0].cat_id);
					
					var rel_path = data.rows[0].goods_pic;
					rel_path = rel_path.replace(/\\/g,"/");
					//alert(rel_path);
					var pics =  rel_path.split(",");
					local_pics = pics;
					//for(var i=0; i<pics.length; i++) alert(pics[i]);
					//图片更新
					$("#g_img_1").attr("src", pics[0]); 
					$("#g_img_1").attr('data-zoom-image', pics[0]);
					$("#good_a0").attr('data-image', pics[0]);
					document.getElementById("gth_0").src = pics[0];
					
					$("#good_a1").attr('data-image', pics[1]);
					document.getElementById("gth_1").src = pics[1];
					
					$("#good_a2").attr('data-image', pics[2]);
					document.getElementById("gth_2").src = pics[2];
					
					$("#good_a3").attr('data-image', pics[3]);
					document.getElementById("gth_3").src = pics[3];
					//alert("点击0img"); 回避不回显bug
					document.getElementById("good_a0").click();
				}
				
				
			});
		}
		//进入页面判断用户是否登录
		if(u_name!=null && u_name!="null"){
			//alert(u_name+u_id);
			document.getElementById("my_account").innerHTML = "欢迎你，"+u_name;
			//隐藏上方用户注册状态
			document.getElementById("login").style.display = "none";
			document.getElementById("exit").style.display ="block";
			
			document.getElementById("login_hint").style.display = "none";
			document.getElementById("jump_hint").style.display = "block";
			//购物车有数据
			if(shopCar=="1"){
				//alert("购物车有数据：Todo..填充列表");
				//ShopCar_To_Goods
				var allGoods = [];
				var url = '${ pageContext.request.contextPath }/user_getShopCart.action?user_id='
					+u_id;
				var param = {};
				$.post(url,param,function(data){
					var shopcar_list = data.ShopCarList;
					for (var i = 0; i < shopcar_list.length; i++) {
						//逐条调用购物车项 填充
						Get_Good(shopcar_list[i].goods_id,shopcar_list[i].goods_num);
						//alert(shopcar_list[i].goods_id+"id,数组：___"+allGoods[i]);
					}
					/* for(var o in shopcar_list){
						//查询商品信息并且赋值给allGoods
						allGoods = Get_Good(shopcar_list[o].goods_id);
						//sum_up += shopcar_list[o].goods_id
				        //alert(o);  
				        alert(allGoods.goods_pic);  
				        //alert("allGoods"+allGoods[o]);//.goods_pic+" 数量:"+allGoods[o].goods_price );  
				      }   */
					
				});
				//填充
				//alert("goods数组初始化完成,length:"+allGoods.length);
			/* 	var j = JSON.parse(allGoods[0]);
				alert(allGoods[0]); */
				/* var index;
				for (index in allGoods)
				{
					alert("下标/"+index+"_____值/"+allGoods[index].goods_name);
				} */
				
			}
		}
		
	}
	//查询商品信息
	function Get_Good(goods_id,goods_num){
		//alert("请求id:___"+goods_id);
		
		var url = '${ pageContext.request.contextPath }/goods_findByID.action?goods_id='
			+goods_id;
		var param = {};
		$.post(url,param,function(data){
			//返回商品信息
			//alert("购买图片:"+data.goods_pic+"，购买数量："+goods_num);
			//单件总价
			var sum_of_one = goods_num*data.goods_price;
			sum_of_one = sum_of_one.toFixed(1);
			//图片提取
			var pic_path = data.goods_pic.replace(/\\/g,"/");
			var pics =  pic_path.split(",");
			//alert(pics[0]);
			//填充
			var t = document.getElementById("shopCartb").insertRow(1);
			t.innerHTML=" <tr> <td class=\"text-center\" style=\"width:70px\"> " 
				 + " <a target=\"_blank\" href="+"product.jsp?key_word="+ data.goods_name +">  " 
				 + "  <img src=\"" + pics[0] 
				 + "\"  style=\"width:70px\" alt=\"Filet Mign\"  " 
				 + " title=\"" + data.goods_name + "\"" 
				 + "  class=\"preview\"> </a>		</td>		<td class=\"text-center\"> <a target=\"_blank\" class=\"cart_product_name\" " 
				 + "  href=\"product.jsp?key_word=" + data.goods_name +"\"><span style=\"font-size: 10pt;\">"+ data.goods_name + "</span></a> </td>		<td class=\"text-center\"> " 
				 + "x"+ goods_num
				 + "</td>		<td class=\"text-center\"> "+ sum_of_one +"￥ </td>		<td class=\"text-right\">	" 
				 + "<a href=\"product.html\"  " 
				 + " class=\"fa fa-edit\">？？？</a>		</td>			</tr> "; 
		});
	}
	
	function Get_category(cat_id){
		//alert("分类id:___"+cat_id);
		var cat_url = '${ pageContext.request.contextPath }/Category_findById.action?cat_id='
			+cat_id;
		var param = {};
		$.post(cat_url,param,function(cat_data){
			local_cat = cat_data;
			document.getElementById("cat_par").innerHTML = cat_data.Cat_parent;
			document.getElementById("cat_name").innerHTML = cat_data.Cat_name;
		});
	}


	function g_search(){
		var good = document.getElementById("inputbox").value;
		alert(good);
		key_word = good;
		load();
		//location.reload();
		//load();
		//onload(good);
	}
	
	function addtoCart(){
		if(u_name!=null  && u_name!="null"){
			//alert("当前用户id："+u_id);
			var g_id = local_data.rows[0].goods_id;
			var g_name = local_data.rows[0].goods_name;
			var g_img = local_pics[0];
			var quantity = document.getElementById("g_quantity").value;
			//alert(g_id+g_img+quantity);
			//alert("当前商品id"+g_id);
			//Todo..异步请求添加购物车
			insert_cart(u_id,g_id,quantity);
			cart.add(g_id , g_name, g_img, quantity);
		}else{
			//alert(u);
			show_login();
			//add_beforelogin = "1";
		}
	}
	
	//发送请求添加购物车
	function insert_cart(u_id,g_id,quantity){
		
		var url = '${ pageContext.request.contextPath }/ShopCar_addShopcart.action?user_id='+u_id;
		var param = {goods_id:g_id, goods_num:quantity};
		$.post(url,param,function(){
			
		});
	}
	
	function login(){
		//alert("登录");
		var login_url = '${ pageContext.request.contextPath }/user_login.action';
		var login_user = document.getElementById('input-account').value;
		var login_pwd = document.getElementById('input-password').value;
		//alert(login_user+login_pwd);
		var Order_Q = "Unconfirmed";
		var param = {user_name :login_user,user_pwd:login_pwd,Order_Q:Order_Q};
		$.post(login_url,param,function(login_return){
			if(login_return.LoginState=="1"){
				//alert(login_return.User.user_name);				
				//alert("登录成功,正在跳转。。。");
				location.reload();
				
			}else{
				alert(">.<登录失败，请重试用户名或者密码。");
				show_login();
				//closeDiv();
			}
			
		}); 
		//关闭输入框
		closeDiv();
	}
	
	function exit(){
		//alert("exit");
		var param = {};
		var exit_url = '${ pageContext.request.contextPath }/user_exit.action';
		$.post(exit_url,param,function(data){
			location.reload();
		}); 
	}
	
	
	/*function view_car(){
		//是否添加新购物车
		var new_add = "<%=session.getAttribute("ShopcarList")%>";
		if(new_add==1){
			alert("购物车有新增项，刷新");	
			//location.reload();
		}
		alert("Check_car");
	}*/

	
	</script>
</head>
<body onload="load()" class="res layout-subpage">

    <div id="wrapper" class="wrapper-full ">
	<!-- Header Container  -->
	<header id="header" class=" variantleft type_1">
<!-- Header Top -->
<div class="header-top">
	<div class="container">
		<div class="row">
			<div class="header-top-left form-inline col-sm-6 col-xs-12 compact-hidden">
				<div class="form-group languages-block ">
					<form action="index.jsp" method="post" enctype="multipart/form-data" id="bt-language">
						<a class="btn btn-xs dropdown-toggle" data-toggle="dropdown">
							<img src="image/demo/flags/gb.png" alt="English" title="English">
							<span class="">English</span>
							<span class="fa fa-angle-down"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="index.jsp"><img class="image_flag" src="image/demo/flags/gb.png" alt="English" title="English" /> English </a></li>
							<li> <a href="index.jsp"> <img class="image_flag" src="image/demo/flags/lb.png" alt="Arabic" title="Arabic" /> Arabic </a> </li>
						</ul>
					</form>
				</div>

				<div class="form-group currencies-block">
					<form action="index.jsp" method="post" enctype="multipart/form-data" id="currency">
						<a class="btn btn-xs dropdown-toggle" data-toggle="dropdown">
							<span class="icon icon-credit "></span> US Dollar <span class="fa fa-angle-down"></span>
						</a>
						<ul class="dropdown-menu btn-xs">
							<li> <a href="javascript:void(0)" onclick="test()">(€)&nbsp;Euro</a></li>
							<li> <a href="#">(£)&nbsp;Pounds	</a></li>
							<li> <a href="#">($)&nbsp;US Dollar	</a></li>
						</ul>
					</form>
				</div>
			</div>
			<div class="header-top-right collapsed-block text-right  col-sm-6 col-xs-12 compact-hidden">
				<h5 class="tabBlockTitle visible-xs">More<a class="expander " href="#TabBlock-1"><i class="fa fa-angle-down"></i></a></h5>
				<div class="tabBlock" id="TabBlock-1">
					<ul class="top-link list-inline">
						<li class="account">
							<a href="#" title="我的账户" class="btn btn-xs dropdown-toggle" data-toggle="dropdown"> <span id="my_account">未登录</span> <span class="fa fa-angle-down"></span></a>
							<ul class="dropdown-menu ">								
								<li><a id="login" onclick="show_login()" ><i class="fa fa-pencil-square-o"></i> 登录</a></li>
								<li><a id="regist" target="_blank" href="regist.jsp"><i class="fa fa-user"></i> 注册</a></li>
								<li><a id="exit" style="display:none;" href="javascript:void(0);" onclick="exit()"><i class="fa fa-pencil-square-o"></i> 退出</a></li>
							</ul>
						</li>
						<!-- <li class="wishlist"><a href="#" id="wishlist-total" class="top-link-wishlist" title="心愿单 (2)"><span>心愿单 (2)</span></a></li>
						<li class="checkout"><a href="#" class="top-link-checkout" title="Checkout"><span >Checkout</span></a></li> -->
						<li class="login"><a href="#" title="Shopping Cart"><span >购物车</span></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //Header Top -->

<!-- Header center -->
<div class="header-center left">
	<div class="container">
		<div class="row">
			<!-- Logo -->
			<div class="navbar-logo col-md-3 col-sm-12 col-xs-12">
				<a href="index.jsp"><img src="image/demo/logos/theme_logo.png" title="Your Store" alt="Your Store" />淘丁丁零食</a>
			</div>
			<!-- //end Logo -->

			<!-- Search -->
			<div id="sosearchpro" class="col-sm-7 search-pro">
				<form method="GET" action="product.jsp" target="_blank">
					<div id="search0" class="search input-group">
						<!-- <div class="select_category filter_type icon-select">
							<select class="no-border" >
								<option value="0">所 有 分 类</option>
								<option value="1">饼  干</option>
								<option value="5">干  货</option>
								<option value="11">面   食</option>
								<option value="13">糕   点</option>
								<option value="17">糖   果</option>
								<option value="23">饮   料</option>
								<option value="30">进 口 食 品</option>
							</select>
						</div> -->

						<input id="inputbox" name="key_word" class="autosearch-input form-control" type="text" value="" size="50" autocomplete="off" placeholder="搜索">
						<span class="input-group-btn">
						<button type="submit" class="button-search btn btn-primary" ><i class="fa fa-search"></i></button>
						</span>
					</div>
					<!-- <input type="hidden" name="route" value="product/search" /> -->
				</form>
			</div>
			<!-- //end Search -->

			<!-- Secondary menu -->
			<div class="col-md-2 col-sm-5 col-xs-12 shopping_cart pull-right">
				<!--cart-->
				<div id="cart" class=" btn-group btn-shopping-cart">
					<a data-loading-text="Loading..." class="top_cart dropdown-toggle" data-toggle="dropdown">
						<div id="view_car" class="shopcart">
							<span class="handle pull-left"></span>
							<span class="title">我的购物车</span>
							<p class="text-shopping-cart cart-total-full">点击查看</p>
						</div>
					</a>

					<ul class="tab-content content dropdown-menu pull-right shoppingcart-box" role="menu">
						
						<li>
							<table class="table table-striped">
								<tbody id="shopCartb">
									<tr>
										<!-- <td class="text-center" style="width:70px">
											<a href="product.html"> <img src="image/demo/shop/product/35.jpg" style="width:70px" alt="Filet Mign" title="Filet Mign" class="preview"> </a>
										</td>
										<td class="text-left"> <a class="cart_product_name" href="product.html">Filet Mign</a> </td>
										<td class="text-center"> x1 </td>
										<td class="text-center"> $1,202.00 </td>
										<td class="text-right">
											<a href="product.html" class="fa fa-edit"></a>
										</td>
										<td class="text-right">
											<a onclick="cart.remove('2');" class="fa fa-times fa-delete"></a>
										</td> -->
									</tr>
									<!-- <tr>
										<td class="text-center" style="width:70px">
											<a href="product.html"> <img src="image/demo/shop/product/141.jpg" style="width:70px" alt="Canon EOS 5D" title="Canon EOS 5D" class="preview"> </a>
										</td>
										<td class="text-left"> <a class="cart_product_name" href="product.html">Canon EOS 5D</a> </td>
										<td class="text-center"> x1 </td>
										<td class="text-center"> $60.00 </td>
										<td class="text-right">
											<a href="product.html" class="fa fa-edit"></a>
										</td>
										<td class="text-right">
											<a onclick="cart.remove('1');" class="fa fa-times fa-delete"></a>
										</td>
									</tr> -->
								</tbody>
							</table>
						</li>
						<li>
							<div>
								<table class="table table-bordered">
									<tbody>
										<tr id="login_hint">
											<td class="text-center"><strong>您尚未登录，请先<a class="subcategory_item" onclick="show_login()">登录</a></strong>
											</td>
											<td class="text-left"><strong></strong>
											</td>
											<!-- <td class="text-right">$1,060.00</td> -->
										</tr>
										<!-- <tr>
											<td class="text-left"><strong>Eco Tax (-2.00)</strong>
											</td>
											<td class="text-right">$2.00</td>
										</tr>
										<tr>
											<td class="text-left"><strong>VAT (20%)</strong>
											</td>
											<td class="text-right">$200.00</td>
										</tr>-->
										<tr>
											<td class="text-left"><strong></strong>
											</td>
											<!-- <td class="text-right"></td> -->
										</tr> 
									</tbody>
								</table>
								<p id="jump_hint" style="display: none;"  class="text-right"> 
									<a class="btn view-cart" href="shopcar.jsp" target="_blank"><i class="fa fa-shopping-cart"></i>购物车详情</a>&nbsp;&nbsp;&nbsp; 
									<a class="btn btn-mega checkout-cart" target="_blank" href="orders.jsp"><i class="fa fa-share"></i>立即下单</a> 
								</p>
							</div>
						</li>
					</ul>
				</div>
				<!--//cart-->
			</div>
		</div>

	</div>
</div>
<!-- //Header center -->

<!-- Header Bottom -->
<div class="header-bottom">
	<div class="container">
		<div class="row">
			
			<div class="sidebar-menu col-md-3 col-sm-6 col-xs-12 ">
				<div class="responsive so-megamenu ">
					<div class="so-vertical-menu no-gutter compact-hidden">
						<nav class="navbar-default">	
							
							<div class="container-megamenu vertical  ">
								
								<div id="menuHeading">
									<div class="megamenuToogle-wrapper">
										<div class="megamenuToogle-pattern">
											<div class="container">
												<div>
													<span></span>
													<span></span>
													<span></span>
												</div>
												All Categories							
												<i class="fa pull-right arrow-circle fa-chevron-circle-up"></i>
											</div>
										</div>
									</div>
								</div>
								<div class="navbar-header">
									<button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle fa fa-list-alt">
										
									</button>
									All Categories		
								</div>
								<div class="vertical-wrapper" >
									<span id="remove-verticalmenu" class="fa fa-times"></span>
									<div class="megamenu-pattern">
										<div class="container">
											<ul class="megamenu">
												<li class="item-vertical style1 with-sub-menu hover">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<img src="image/theme/icons/9.png" alt="icon">
														<span>Automotive &amp; Motocrycle</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="100" >
														<div class="content" >
															<div class="row">
																<div class="col-sm-12">
																	<div class="row">
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">Apparel</a>
																						<ul>
																							<li><a href="#" >Accessories for Tablet PC</a></li>
																							<li><a href="#" >Accessories for i Pad</a></li>
																							<li><a  href="#" >Accessories for iPhone</a></li>
																							<li><a href="#" >Bags, Holiday Supplies</a></li>
																							<li><a href="#" >Car Alarms and Security</a></li>
																							<li><a href="#" >Car Audio &amp; Speakers</a></li>
																						</ul>
																					</li>
																					<li>
																						<a href="#"  class="main-menu">Cables &amp; Connectors</a>
																						<ul>
																							<li><a href="#" >Cameras &amp; Photo</a></li>
																							<li><a href="#" >Electronics</a></li>
																							<li><a href="#" >Outdoor &amp; Traveling</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">Camping &amp; Hiking</a>
																						<ul>
																							<li><a href="#" >Earings</a></li>
																							<li><a href="#" >Shaving &amp; Hair Removal</a></li>
																							<li><a href="#" >Salon &amp; Spa Equipment</a></li>
																						</ul>
																					</li>
																					<li>
																						<a href="#" class="main-menu">Smartphone &amp; Tablets</a>
																						<ul>
																							<li><a href="#" >Sports &amp; Outdoors</a></li>
																							<li><a href="#" >Bath &amp; Body</a></li>
																							<li><a href="#" >Gadgets &amp; Auto Parts</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">Bags, Holiday Supplies</a>
																						<ul>
																							<li><a href="#" onclick="window.location = '18_46';">Battereries &amp; Chargers</a></li>
																							<li><a href="#" onclick="window.location = '24_64';">Bath &amp; Body</a></li>
																							<li><a href="#" onclick="window.location = '18_45';">Headphones, Headsets</a></li>
																							<li><a href="#" onclick="window.location = '18_30';">Home Audio</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</li>
												<li class="item-vertical">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<img src="image/theme/icons/10.png" alt="icon">
														<span>Electronic</span>
														
													</a>
												</li>
												<li class="item-vertical with-sub-menu hover">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<span class="label"></span>
														<img src="image/theme/icons/3.png" alt="icon">
														<span>Sports &amp; Outdoors</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="60" >
														<div class="content">
															<div class="row">
																<div class="col-md-6">
																	<div class="row">
																		<div class="col-md-12 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" onclick="window.location = '81';" class="main-menu">Mobile Accessories</a>
																						<ul>
																							<li><a href="#" onclick="window.location = '33_63';">Gadgets &amp; Auto Parts</a></li>
																							<li><a href="#" onclick="window.location = '24_64';">Bath &amp; Body</a></li>
																							<li><a href="#" onclick="window.location = '17';">Bags, Holiday Supplies</a></li>
																						</ul>
																					</li>
																					<li>
																						<a href="#" onclick="window.location = '18_46';" class="main-menu">Battereries &amp; Chargers</a>
																						<ul>
																							<li><a href="#" onclick="window.location = '25_28';">Outdoor &amp; Traveling</a></li>
																							<li><a href="#" onclick="window.location = '80';">Flashlights &amp; Lamps</a></li>
																							<li><a href="#" onclick="window.location = '24_66';">Fragrances</a></li>
																						</ul>
																					</li>
																					<li>
																						<a href="#" onclick="window.location = '25_31';" class="main-menu">Fishing</a>
																						<ul>
																							<li><a href="#" onclick="window.location = '57_73';">FPV System &amp; Parts</a></li>
																							<li><a href="#" onclick="window.location = '18';">Electronics</a></li>
																							<li><a href="#" onclick="window.location = '20_76';">Earings</a></li>
																							<li><a href="#" onclick="window.location = '33_60';">More Car Accessories</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="row banner">
																		<a href="#">
																			<img src="image/demo/cms/menu_bg2.jpg" alt="banner1">
																			</a>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</li>
													<li class="item-vertical with-sub-menu hover">
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/2.png" alt="icon">
															<span>Health &amp; Beauty</span>
															<b class="caret"></b>
														</a>
														<div class="sub-menu" data-subwidth="100" >
															<div class="content" >
																<div class="row">
																	<div class="col-md-12">
																		<div class="row">
																			<div class="col-md-4 static-menu">
																				<div class="menu">
																					<ul>
																						<li>
																							<a href="#" class="main-menu">Car Alarms and Security</a>
																							<ul>
																								<li><a href="#" >Car Audio &amp; Speakers</a></li>
																								<li><a href="#" >Gadgets &amp; Auto Parts</a></li>
																								<li><a href="#" >Gadgets &amp; Auto Parts</a></li>
																								<li><a href="#" >Headphones, Headsets</a></li>
																							</ul>
																						</li>
																						<li>
																							<a href="" onclick="window.location = '24';" class="main-menu">Health &amp; Beauty</a>
																							<ul>
																								<li>
																									<a href="#" >Home Audio</a>
																								</li>
																								<li>
																									<a href="#" >Helicopters &amp; Parts</a>
																								</li>
																								<li>
																									<a href="#" >Outdoor &amp; Traveling</a>
																								</li>
																								<li>
																									<a href="#">Toys &amp; Hobbies</a>
																								</li>
																							</ul>
																						</li>
																					</ul>
																				</div>
																			</div>
																			<div class="col-md-4 static-menu">
																				<div class="menu">
																					<ul>
																						<li>
																							<a href="#"  class="main-menu">Electronics</a>
																							<ul>
																								<li>
																									<a href="#">Earings</a>
																								</li>
																								<li>
																									<a href="#" >Salon &amp; Spa Equipment</a>
																								</li>
																								<li>
																									<a href="#" >Shaving &amp; Hair Removal</a>
																								</li>
																								<li>
																									<a href="#">Smartphone &amp; Tablets</a>
																								</li>
																							</ul>
																						</li>
																						<li>
																							<a href="#"  class="main-menu">Sports &amp; Outdoors</a>
																							<ul>
																								<li>
																									<a href="#" >Flashlights &amp; Lamps</a>
																								</li>
																								<li>
																									<a href="#" >Fragrances</a>
																								</li>
																								<li>
																									<a href="#" >Fishing</a>
																								</li>
																								<li>
																									<a href="#" >FPV System &amp; Parts</a>
																								</li>
																							</ul>
																						</li>
																					</ul>
																				</div>
																			</div>
																			<div class="col-md-4 static-menu">
																				<div class="menu">
																					<ul>
																						<li>
																							<a href="#" class="main-menu">More Car Accessories</a>
																							<ul>
																								<li>
																									<a href="#" >Lighter &amp; Cigar Supplies</a>
																								</li>
																								<li>
																									<a href="#" >Mp3 Players &amp; Accessories</a>
																								</li>
																								<li>
																									<a href="#" >Men Watches</a>
																								</li>
																								<li>
																									<a href="#" >Mobile Accessories</a>
																								</li>
																							</ul>
																						</li>
																						<li>
																							<a href="#" class="main-menu">Gadgets &amp; Auto Parts</a>
																							<ul>
																								<li>
																									<a href="#" >pngt &amp; Lifestyle Gadgets</a>
																								</li>
																								<li>
																									<a href="#" >pngt for Man</a>
																								</li>
																								<li>
																									<a href="#" >pngt for Woman</a>
																								</li>
																								<li>
																									<a href="#" >pngt for Woman</a>
																								</li>
																							</ul>
																						</li>
																					</ul>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</li>
													<li class="item-vertical css-menu with-sub-menu hover">
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															
															<img src="image/theme/icons/2.png" alt="icon">
															<span>Smartphone &amp; Tablets</span>
															<b class="caret"></b>
														</a>
														<div class="sub-menu" data-subwidth="30" style="width: 270px; display: none; right: 0px;">
															<div class="content" style="display: none;">
																<div class="row">
																	<div class="col-sm-12">
																		<div class="row">
																			<div class="col-sm-12 hover-menu">
																				<div class="menu">
																					<ul>
																						<li>
																							<a href="#" class="main-menu">Headphones, Headsets</a>
																						</li>
																						<li>
																							<a href="#" class="main-menu">Home Audio</a>
																						</li>
																						<li>
																							<a href="#" class="main-menu">Health &amp; Beauty</a>
																						</li>
																						<li>
																							<a href="#" class="main-menu">Helicopters &amp; Parts</a>
																						</li>
																						<li>
																							<a href="#" class="main-menu">Helicopters &amp; Parts</a>
																						</li>
																					</ul>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</li>
													<li class="item-vertical">
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/11.png" alt="icon">
															<span>Flashlights &amp; Lamps</span>
															
														</a>
													</li>
													<li class="item-vertical">
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/4.png" alt="icon">
															<span>Camera &amp; Photo</span>
														</a>
													</li>
													<li class="item-vertical">
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/5.png" alt="icon">
															<span>Smartphone &amp; Tablets</span>
														</a>
													</li>
													<li class="item-vertical" >
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/7.png" alt="icon">
															<span>Outdoor &amp; Traveling Supplies</span>
														</a>
													</li>
													<li class="item-vertical" style="display: none;">
														<p class="close-menu"></p>
														
														<a href="#" class="clearfix">
															<img src="image/theme/icons/6.png" alt="icon">
															<span>Health &amp; Beauty</span>
														</a>
													</li>
													<li class="item-vertical" >
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/8.png" alt="icon">
															<span>Toys &amp; Hobbies </span>
														</a>
													</li>
													<li class="item-vertical" >
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/12.png" alt="icon">
															<span>Jewelry &amp; Watches</span>
														</a>
													</li>
													<li class="item-vertical" >
														<p class="close-menu"></p>
														<a href="#" class="clearfix">
															<img src="image/theme/icons/13.png" alt="icon">
															<span>Bags, Holiday Supplies</span>
														</a>
													</li>
													<li class="item-vertical" >
														<p class="close-menu"></p>
														
														<a href="#" class="clearfix">
															<img src="image/theme/icons/13.png" alt="icon">
															<span>More Car Accessories</span>
														</a>
													</li>
													<li class="loadmore">
														<i class="fa fa-plus-square-o"></i>
														<span class="more-view">More Categories</span>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</nav>
					</div>
				</div>

			</div>
			
			<!-- Main menu -->
			<div class="megamenu-hori header-bottom-right  col-md-9 col-sm-6 col-xs-12 ">
				<div class="responsive so-megamenu ">
	<nav class="navbar-default">
		<div class=" container-megamenu  horizontal">
			
			<div class="navbar-header">
				<button type="button" id="show-megamenu" data-toggle="collapse" class="navbar-toggle">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				Navigation		
			</div>
			
			<div class="megamenu-wrapper">
				<span id="remove-megamenu" class="fa fa-times"></span>
				<div class="megamenu-pattern">
					<div class="container">
						<ul class="megamenu " data-transition="slide" data-animationtime="250">
							<li class="home hover">
								
								<a href="index.jsp">Home <b class="caret"></b></a>
								<div class="sub-menu" style="width:100%;" >
									<div class="content" >
										<div class="row">
											<div class="col-md-3">
												<a href="index.jsp" class="image-link"> 
													<span class="thumbnail">
														<img class="img-responsive img-border" src="image/demo/feature/home-1.jpg" alt="">
														<span class="btn btn-default">Read More</span>
													</span> 
													<h3 class="figcaption">Home page - (Default)</h3> 
												</a> 
												
											</div>
											<div class="col-md-3">
												<a href="#" class="image-link"> 
													<span class="thumbnail">
														<img class="img-responsive img-border" src="image/demo/feature/home-2.jpg" alt="">
														<span class="btn btn-default">Read More</span>
													</span> 
													<h3 class="figcaption">Home page - Layout 2</h3> 
												</a> 
												
											</div>
											<div class="col-md-3">
												<a href="#" class="image-link"> 
													<span class="thumbnail">
														<img class="img-responsive img-border" src="image/demo/feature/home-3.jpg" alt="">
														<span class="btn btn-default">Read More</span>
													</span> 
													<h3 class="figcaption">Home page - Layout 3</h3> 
												</a> 
												
											</div>
											<div class="col-md-3">
												<a href="#" class="image-link"> 
													<span class="thumbnail">
														<img class="img-responsive img-border" src="image/demo/feature/home-4.jpg" alt="">
														<span class="btn btn-default">Read More</span>
													</span> 
													<h3 class="figcaption">Home page - Layout 4</h3> 
												</a> 
												
											</div>
										</div>
									</div>
								</div>
							</li>
							<li class="with-sub-menu hover">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Features</strong>
									<span class="label"> Hot</span>
									<b class="caret"></b>
								</a>
								<div class="sub-menu" style="width: 100%; right: auto;">
									<div class="content" >
										<div class="row">
											<div class="col-md-3">
												<div class="column">
													<a href="#" class="title-submenu">Listing pages</a>
													<div>
														<ul class="row-list">
															<li><a href="category.html">Category Page 1 </a></li>
															<li><a href="#">Category Page 2</a></li>
															<li><a href="#">Category Page 3</a></li>
														</ul>
														
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="column">
													<a href="#" class="title-submenu">Product pages</a>
													<div>
														<ul class="row-list">
															<li><a href="product.html">Image size - big</a></li>
															<li><a href="#">Image size - medium</a></li>
															<li><a href="#">Image size - small</a></li>
														</ul>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="column">
													<a href="#" class="title-submenu">Shopping pages</a>
													<div>
														<ul class="row-list">
															<li><a href="#">Shopping Cart Page</a></li>
															<li><a href="#">Checkout Page</a></li>
															<li><a href="#">Compare Page</a></li>
															<li><a href="#">Wishlist Page</a></li>
														
														</ul>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<div class="column">
													<a href="#" class="title-submenu">My Account pages</a>
													<div>
														<ul class="row-list">
															<li><a href="login.html">Login Page</a></li>
															<li><a href="register.html">Register Page</a></li>
															<li><a href="#">My Account</a></li>
															<li><a href="#">Order History</a></li>
															<li><a href="#">Order Information</a></li>
															<li><a href="#">Product Returns</a></li>
															<li><a href="#">pngt Voucher</a></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</li>
							<li class="with-sub-menu hover">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Pages</strong>
									<span class="label"> Hot</span>
									<b class="caret"></b>
								</a>
								<div class="sub-menu" style="width: 40%; ">
									<div class="content" >
										<div class="row">
											<div class="col-md-6">
												<ul class="row-list">
													<li><a class="subcategory_item" href="#">FAQ</a></li>
													<li><a class="subcategory_item" href="#">Typography</a></li>
													<li><a class="subcategory_item" href="#">Site Map</a></li>
													<li><a class="subcategory_item" href="#">Contact us</a></li>
													<li><a class="subcategory_item" href="#">Banner Effect</a></li>
												</ul>
											</div>
											<div class="col-md-6">
												<ul class="row-list">
													<li><a class="subcategory_item" href="#">About Us 1</a></li>
													<li><a class="subcategory_item" href="#">About Us 2</a></li>
													<li><a class="subcategory_item" href="#">About Us 3</a></li>
													<li><a class="subcategory_item" href="#">About Us 4</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</li>
							<li class="with-sub-menu hover">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Categories</strong>
									<span class="label"></span>
									<b class="caret"></b>
								</a>
								<div class="sub-menu" style="width: 100%; display: none;">
									<div class="content">
										<div class="row">
											<div class="col-sm-12">
												<div class="row">
													<div class="col-md-3 img img1">
														<a href="#"><img src="image/demo/cms/img1.jpg" alt="banner1"></a>
													</div>
													<div class="col-md-3 img img2">
														<a href="#"><img src="image/demo/cms/img2.jpg" alt="banner2"></a>
													</div>
													<div class="col-md-3 img img3">
														<a href="#"><img src="image/demo/cms/img3.jpg" alt="banner3"></a>
													</div>
													<div class="col-md-3 img img4">
														<a href="#"><img src="image/demo/cms/img4.jpg" alt="banner4"></a>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-3">
												<a href="#" class="title-submenu">Automotive</a>
												<div class="row">
													<div class="col-md-12 hover-menu">
														<div class="menu">
															<ul>
																<li><a href="#"  class="main-menu">Car Alarms and Security</a></li>
																<li><a href="#"  class="main-menu">Car Audio &amp; Speakers</a></li>
																<li><a href="#"  class="main-menu">Gadgets &amp; Auto Parts</a></li>
																<li><a href="#"  class="main-menu">More Car Accessories</a></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<a href="#" class="title-submenu">Electronics</a>
												<div class="row">
													<div class="col-md-12 hover-menu">
														<div class="menu">
															<ul>
																<li><a href="#"  class="main-menu">Battereries &amp; Chargers</a></li>
																<li><a href="#"  class="main-menu">Headphones, Headsets</a></li>
																<li><a href="#"  class="main-menu">Home Audio</a></li>
																<li><a href="#"  class="main-menu">Mp3 Players &amp; Accessories</a></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<a href="#" class="title-submenu">Jewelry &amp; Watches</a>
												<div class="row">
													<div class="col-md-12 hover-menu">
														<div class="menu">
															<ul>
																<li><a href="#"  class="main-menu">Earings</a></li>
																<li><a href="#"  class="main-menu">Wedding Rings</a></li>
																<li><a href="#"  class="main-menu">Men Watches</a></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-3">
												<a href="#" class="title-submenu">Bags, Holiday Supplies</a>
												<div class="row">
													<div class="col-md-12 hover-menu">
														<div class="menu">
															<ul>
																<li><a href="#"  class="main-menu">pngt &amp; Lifestyle Gadgets</a></li>
																<li><a href="#"  class="main-menu">pngt for Man</a></li>
																<li><a href="#"  class="main-menu">pngt for Woman</a></li>
																<li><a href="#"  class="main-menu">Lighter &amp; Cigar Supplies</a></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</li>
							
							<li class="with-sub-menu hover">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Accessories</strong>
									
									<b class="caret"></b>
								</a>
								<div class="sub-menu" style="width: 100%; display: none;">
									<div class="content" style="display: none;">
										<div class="row">
											<div class="col-md-8">
												<div class="row">
													<div class="col-md-6 static-menu">
														<div class="menu">
															<ul>
																<li>
																	<a href="#"  class="main-menu">Automotive</a>
																	<ul>
																		<li><a href="#">Car Alarms and Security</a></li>
																		<li><a href="#" >Car Audio &amp; Speakers</a></li>
																		<li><a href="#" >Gadgets &amp; Auto Parts</a></li>
																	</ul>
																</li>
																<li>
																	<a href="#"  class="main-menu">Smartphone &amp; Tablets</a>
																	<ul>
																		<li><a href="#" >Accessories for i Pad</a></li>
																		<li><a href="#" >Apparel</a></li>
																		<li><a href="#" >Accessories for iPhone</a></li>
																	</ul>
																</li>
															</ul>
														</div>
													</div>
													<div class="col-md-6 static-menu">
														<div class="menu">
															<ul>
																<li>
																	<a href="#" class="main-menu">Sports &amp; Outdoors</a>
																	<ul>
																		<li><a href="#" >Camping &amp; Hiking</a></li>
																		<li><a href="#" >Cameras &amp; Photo</a></li>
																		<li><a href="#" >Cables &amp; Connectors</a></li>
																	</ul>
																</li>
																<li>
																	<a href="#"  class="main-menu">Electronics</a>
																	<ul>
																		<li><a href="#" >Battereries &amp; Chargers</a></li>
																		<li><a href="#" >Bath &amp; Body</a></li>
																		<li><a href="#" >Outdoor &amp; Traveling</a></li>
																	</ul>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<span class="title-submenu">Bestseller</span>
												<div class="col-sm-12 list-product">
													<div class="product-thumb">
														<div class="image pull-left">
															<a href="#"><img src="image/demo/shop/product/35.jpg" width="80" alt="Filet Mign" title="Filet Mign" class="img-responsive"></a>
														</div>
														<div class="caption">
															<h4><a href="#">Filet Mign</a></h4>
															<div class="rating-box">
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															</div>
															<p class="price">$1,202.00</p>
														</div>
													</div>
												</div>
												<div class="col-sm-12 list-product">
													<div class="product-thumb">
														<div class="image pull-left">
															<a href="#"><img src="image/demo/shop/product/W1.jpg" width="80" alt="Dail Lulpa" title="Dail Lulpa" class="img-responsive"></a>
														</div>
														<div class="caption">
															<h4><a href="#">Dail Lulpa</a></h4>
															<div class="rating-box">
																<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
															   <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
															</div>
															<p class="price">$78.00</p>
														</div>
													</div>
												</div>
												<div class="col-sm-12 list-product">
													<div class="product-thumb">
														<div class="image pull-left">
															<a href="#"><img src="image/demo/shop/product/141.jpg" width="80" alt="Canon EOS 5D" title="Canon EOS 5D" class="img-responsive"></a>
														</div>
														<div class="caption">
															<h4><a href="#">Canon EOS 5D</a></h4>
															
															<div class="rating-box">
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
																<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
															</div>
															<p class="price">
																<span class="price-new">$60.00</span>
																<span class="price-old">$145.00</span>
																
															</p>
														</div>
													</div>
												</div>
												
											</div>
										</div>
									</div>
								</div>
							</li>
							<li class="">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Blog</strong>
									<span class="label"></span>
								</a>
							</li>
							
							<li class="hidden-md">
								<p class="close-menu"></p>
								<a href="#" class="clearfix">
									<strong>Buy Theme!</strong>
									
								</a>
							</li>
						</ul>
						
					</div>
				</div>
			</div>
		</div>
	</nav>
</div>
									</div>
			<!-- //end Main menu -->
			
		</div>
	</div>

</div>

<!-- Navbar switcher -->
<!-- //end Navbar switcher -->
	</header>
	<!-- //Header Container  -->
	<!-- Main Container  -->
	<div class="main-container container">
		<ul class="breadcrumb">
			<li><a href="#"><i class="fa fa-home"></i></a></li>
			<li><a id="cat_par" href="#">加载中</a></li>
			<li><a id="cat_name" href="#">加载中</a></li>
		</ul>
		
		<div class="row">
			<!--Middle Part Start-->
			<div id="content" class="col-md-12 col-sm-12">
				
				<div class="product-view row">
					<div class="left-content-product col-lg-10 col-xs-12">
						<div class="row">
							<div class="content-product-left class-honizol col-sm-6 col-xs-12 ">
								<!-- 大图 -->
								<div class="large-image  ">
									<img id="g_img_1" itemprop="image" class="product-image-zoom" src="image/product/0/loading.gif" data-zoom-image="image/product/0/loading.gif" title="" alt="">
								</div>
								<!-- <a class="thumb-video pull-left" href="https://www.youtube.com/watch?v=HhabgvIIXik"><i class="fa fa-youtube-play"></i></a> -->
								<!-- 选择相册 -->
								<div id="thumb-slider" class="owl-theme owl-loaded owl-drag full_slider">
									<a id="good_a0" data-index="0" class="img thumbnail " data-image="image/product/0/loading.gif" title="Bint Beef">
										<img id="gth_0" src="image/product/0/loading.gif" title="" alt="">
									</a>
									<a id="good_a1" data-index="1" class="img thumbnail " data-image="image/product/0/loading.gif" title="Bint Beef">
										<img id="gth_1" src="image/product/0/loading.gif" title="" alt="">
									</a>
									<a id="good_a2" data-index="2" class="img thumbnail " data-image="image/product/0/loading.gif" title="Bint Beef">
										<img id="gth_2" src="image/product/0/loading.gif" title="" alt="">
									</a>	
									<a id="good_a3" data-index="3" class="img thumbnail " data-image="image/product/0/loading.gif" title="Bint Beef">
										<img id="gth_3" src="image/product/0/loading.gif" title="" alt="">
									</a>								
								</div>
								
							</div>

							<div class="content-product-right col-sm-6 col-xs-12">
								<div class="title-product">
									<h1 id="h_name">加载中...</h1>
								</div>
								<!-- Review ---->
								<div class="box-review form-group">
									<div class="ratings">
										<div class="rating-box">
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
											<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
											<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
										</div>
									</div>

									<a class="reviews_button" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">338 查看</a>	| 
									<a class="write_review_button" href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;">编写评论</a>
								</div>

								<div class="product-label form-group">
									<div class="product_page_price price" itemprop="offerDetails" itemscope="" itemtype="http://data-vocabulary.org/Offer">
										<span id="n_price" class="price-new" itemprop="price">9.9￥</span>
										<span id="o_price" class="price-old">12.9￥</span>
									</div>
									<!-- <div class="stock"><span>Availability:</span> <span class="status-stock">In Stock</span></div> -->
								</div>

								<div class="product-box-desc">
									<div class="inner-box-desc">
										<div id="g_detail" class="price-tax"><span>描述:</span>正在加载...</div>
										<!-- <div class="reward"><span>Price in reward points:</span> 400</div> -->
										<!-- <div class="brand"><span>分类:</span><a href="#">零食</a></div> -->
										<!-- <div class="model"><span>商品号:</span> Product 15</div> -->
										<div id="g_inventory" class="reward"><span>商品库存:</span>0</div>
									</div>
								</div>


								<div id="product">
									<h4>选择</h4>
									<div class="image_option_type form-group required">
										<label class="control-label">口味</label>
										<ul class="product-options clearfix"id="input-option231">
											<li class="radio">
												<label>
													<input class="image_radio" type="radio" name="option[231]" value="33"> 
													<img src="image/demo/colors/blue.jpg" data-original-title="牛奶味" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
													<label> </label>
												</label>
											</li>
											<li class="radio">
												<label>
													<input class="image_radio" type="radio" name="option[231]" value="34"> 
													<img src="image/demo/colors/brown.jpg" data-original-title="巧克力味" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
													<label> </label>
												</label>
											</li>
											<li class="radio">
												<label>
													<input class="image_radio" type="radio" name="option[231]" value="35"> <img src="image/demo/colors/green.jpg"
													data-original-title="哈密瓜味" class="img-thumbnail icon icon-color">				<i class="fa fa-check"></i>
													<label> </label>
												</label>
											</li>
											<li class="selected-option">
											</li>
										</ul>
									</div>
									
									<div class="box-checkbox form-group required">
										<label class="control-label">可选套餐</label>
										<div id="input-option232">
											<div class="checkbox">
												<label for="checkbox_1"><input type="checkbox" name="option[232][]" value="36" id="checkbox_1"> 方案 1 (+12.00￥)</label>
											</div>
											<div class="checkbox">
												<label for="checkbox_2"><input type="checkbox" name="option[232][]" value="36" id="checkbox_2"> 方案 2 (+36.00￥)</label>
											</div>
											<div class="checkbox">
												<label for="checkbox_3"><input type="checkbox" name="option[232][]" value="36" id="checkbox_3"> 方案 3 (+24.00￥)</label>
											</div>
										</div>
									</div>

									<div class="form-group box-info-product">
										<div class="option quantity">
											<div class="input-group quantity-control" unselectable="on" style="-webkit-user-select: none;">
												<label>数量</label>
												<input id="g_quantity" class="form-control" type="text" name="quantity"
												value="1">
												<input type="hidden" name="product_id" value="50">
												<span class="input-group-addon product_quantity_down">−</span>
												<span class="input-group-addon product_quantity_up">+</span>
											</div>
										</div>
										<div class="cart">
											<input type="button" data-toggle="tooltip" title="" value="加入购物车" data-loading-text="Loading..." 
												id="button-cart" class="btn btn-mega btn-lg" onclick="addtoCart();" data-original-title="+购物车">
											<!-- add(商品id,数量) -->
										</div>
										<!-- <div class="add-to-links wish_comp">
											<ul class="blank list-inline">
												<li class="wishlist">
													<a class="icon" data-toggle="tooltip" title=""
													onclick="wishlist.add('50');" data-original-title="Add to Wish List"><i class="fa fa-heart"></i>
													</a>
												</li>
												<li class="compare">
													<a class="icon" data-toggle="tooltip" title=""
													onclick="compare.add('50');" data-original-title="Compare this Product"><i class="fa fa-exchange"></i>
													</a>
												</li>
											</ul>
										</div> -->

									</div>

								</div>
								<!-- end box info product -->

							</div>
						</div>
					</div>
					
					<!-- <section class="col-lg-2 hidden-sm hidden-md hidden-xs slider-products">
						<div class="module col-sm-12 four-block">
							<div class="modcontent clearfix">
								<div class="policy-detail">
									<div class="banner-policy">
										<div class="policy policy1">
											<a href="#"> <span class="ico-policy">&nbsp;</span>	90 day
											<br> money back </a>
										</div>
										<div class="policy policy2">
											<a href="#"> <span class="ico-policy">&nbsp;</span>	In-store exchange </a>
										</div>
										<div class="policy policy3">
											<a href="#"> <span class="ico-policy">&nbsp;</span>	lowest price guarantee </a>
										</div>
										<div class="policy policy4">
											<a href="#"> <span class="ico-policy">&nbsp;</span>	shopping guarantee </a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section> -->
				</div>
				
				<!-- Product Tabs -->
				<div class="producttab ">
	<div class="tabsslider  vertical-tabs col-xs-12">
		<ul class="nav nav-tabs col-lg-2 col-sm-3">
			<li class="active"><a data-toggle="tab" href="#tab-1">描述</a></li>
			<li class="item_nonactive"><a data-toggle="tab" href="#tab-review">Reviews (1)</a></li>
			<li class="item_nonactive"><a data-toggle="tab" href="#tab-4">Tags</a></li>
			<li class="item_nonactive"><a data-toggle="tab" href="#tab-5">Custom Tab</a></li>
		</ul>
		<div class="tab-content col-lg-10 col-sm-9 col-xs-12">
			<div id="tab-1" class="tab-pane fade active in">
				<p>Lorem ipsum dolor sit amet, consetetursadipscing elitr, sed diam nonumy eirmodtempor invidunt ut labore et doloremagna aliquyam erat, sed diam voluptua.</p>
				<p>At vero eos et accusam et justo duo dolores	et ea rebum. Stet clita kasd gubergren,no sea takimata sanctus est Lorem ipsumdolor sit amet. Lorem ipsum dolor sitamet, consetetur sadipscing elitr, seddiam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat,sed diam voluptua. </p>
				<p>At vero eos et accusam et justo duo dolores
					et ea rebum. Stet clita kasd gubergren,
					no sea takimata sanctus est Lorem ipsum
					dolor sit amet. Lorem ipsum dolor sit
					amet, consetetur sadipscing elitr, sed
					diam nonumy eirmod tempor invidunt ut
					labore et dolore magna aliquyam erat,
					sed diam voluptua. At vero eos et accusam
					et justo duo dolores et ea rebum. Stet
					clita kasd gubergren, no sea takimata
					sanctus est Lorem ipsum dolor sit amet.
					<br>
				</p>
				
			</div>
			<div id="tab-review" class="tab-pane fade">
				<form>
					<div id="review">
						<table class="table table-striped table-bordered">
							<tbody>
								<tr>
									<td style="width: 50%;"><strong>Super Administrator</strong></td>
									<td class="text-right">29/07/2015</td>
								</tr>
								<tr>
									<td colspan="2">
										<p>Best this product opencart</p>
										<div class="ratings">
											<div class="rating-box">
												<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
												<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
												<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
												<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
												<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="text-right"></div>
					</div>
					<h2 id="review-title">Write a review</h2>
					<div class="contacts-form">
						<div class="form-group"> <span class="icon icon-user"></span>
							<input type="text" name="name" class="form-control" value="Your Name" onblur="if (this.value == '') {this.value = 'Your Name';}" onfocus="if(this.value == 'Your Name') {this.value = '';}"> 
						</div>
						<div class="form-group"> <span class="icon icon-bubbles-2"></span>
							<textarea class="form-control" name="text" onblur="if (this.value == '') {this.value = 'Your Review';}" onfocus="if(this.value == 'Your Review') {this.value = '';}">Your Review</textarea>
						</div> 
						<span style="font-size: 11px;"><span class="text-danger">Note:</span>						HTML is not translated!</span>
						
						<div class="form-group">
						 <b>Rating</b> <span>Bad</span>&nbsp;
						<input type="radio" name="rating" value="1"> &nbsp;
						<input type="radio" name="rating"
						value="2"> &nbsp;
						<input type="radio" name="rating"
						value="3"> &nbsp;
						<input type="radio" name="rating"
						value="4"> &nbsp;
						<input type="radio" name="rating"
						value="5"> &nbsp;<span>Good</span>
						
						</div>
						<div class="buttons clearfix"><a id="button-review" class="btn buttonGray">Continue</a></div>
					</div>
				</form>
			</div>
			<div id="tab-4" class="tab-pane fade">
				<a href="#">Monitor</a>,
				<a href="#">Apple</a>				
			</div>
			<div id="tab-5" class="tab-pane fade">
				<p>Lorem ipsum dolor sit amet, consetetur
					sadipscing elitr, sed diam nonumy eirmod
					tempor invidunt ut labore et dolore
					magna aliquyam erat, sed diam voluptua.
					At vero eos et accusam et justo duo
					dolores et ea rebum. Stet clita kasd
					gubergren, no sea takimata sanctus est
					Lorem ipsum dolor sit amet. Lorem ipsum
					dolor sit amet, consetetur sadipscing
					elitr, sed diam nonumy eirmod tempor
					invidunt ut labore et dolore magna aliquyam
					erat, sed diam voluptua. </p>
				<p>At vero eos et accusam et justo duo dolores
					et ea rebum. Stet clita kasd gubergren,
					no sea takimata sanctus est Lorem ipsum
					dolor sit amet. Lorem ipsum dolor sit
					amet, consetetur sadipscing elitr.</p>
				<p>Sed diam nonumy eirmod tempor invidunt
					ut labore et dolore magna aliquyam erat,
					sed diam voluptua. At vero eos et accusam
					et justo duo dolores et ea rebum. Stet
					clita kasd gubergren, no sea takimata
					sanctus est Lorem ipsum dolor sit amet.</p>
			</div>
		</div>
	</div>
</div>
				<!-- //Product Tabs -->
				
				<!-- Related Products -->
				<div class="related titleLine products-list grid module ">
	<h3 class="modtitle">相似产品  </h3>
	<div class="releate-products ">
		<div class="product-layout">
			<div class="product-item-container">
				<div class="left-block">
					<div class="product-image-container second_img ">
						<img  src="image/demo/shop/product/e11.jpg"  title="Apple Cinema 30&quot;" class="img-responsive" />
						<img  src="image/demo/shop/product/e12.jpg"  title="Apple Cinema 30&quot;" class="img_0 img-responsive" />
					</div>
					<!--Sale Label-->
					<span class="label label-sale">热销</span>
					<!--full quick view block-->
					<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  Quickview</a>
					<!--end full quick view block-->
				</div>
				
				
				<div class="right-block">
					<div class="caption">
						<h4><a href="product.html">Apple Cinema 30&quot;</a></h4>		
						<div class="ratings">
							<div class="rating-box">
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							</div>
						</div>
											
						<div class="price">
							<span class="price-new">$74.00</span> 
							<span class="price-old">$122.00</span>		 
							<span class="label label-percent">-40%</span>    
						</div>
						<div class="description item-desc hidden">
							<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut l..</p>
						</div>
					</div>
					
					  <div class="button-group">
						<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onclick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">Add to Cart</span></button>
						<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onclick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
						<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onclick="compare.add('42');"><i class="fa fa-exchange"></i></button>
					  </div>
				</div><!-- right block -->

			</div>
		</div>
		<div class="product-layout ">
			<div class="product-item-container">
				<div class="left-block">
					<div class="product-image-container second_img ">
						<img  src="image/demo/shop/product/11.jpg"  title="Apple Cinema 30&quot;" class="img-responsive" />
						<img  src="image/demo/shop/product/10.jpg"  title="Apple Cinema 30&quot;" class="img_0 img-responsive" />
						
					</div>
					<!--Sale Label-->
					<span class="label label-sale">Sale</span>
					<!--full quick view block-->
					<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  Quickview</a>
					<!--end full quick view block-->
				</div>
				
				
				<div class="right-block">
					<div class="caption">
						<h4><a href="product.html">Apple Cinema 30&quot;</a></h4>		
						<div class="ratings">
							<div class="rating-box">
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							</div>
						</div>
											
						<div class="price">
							<span class="price-new">$74.00</span> 
							<span class="price-old">$122.00</span>		 
							<span class="label label-percent">-40%</span>    
						</div>
						<div class="description item-desc hidden">
							<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut l..</p>
						</div>
					</div>
					
					  <div class="button-group">
						<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onclick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">Add to Cart</span></button>
						<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onclick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
						<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onclick="compare.add('42');"><i class="fa fa-exchange"></i></button>
					  </div>
				</div><!-- right block -->

			</div>
		</div>
		<div class="product-layout ">
			<div class="product-item-container">
				<div class="left-block">
					<div class="product-image-container second_img ">
						<img  src="image/demo/shop/product/35.jpg"  title="Apple Cinema 30&quot;" class="img-responsive" />
						<img  src="image/demo/shop/product/34.jpg"  title="Apple Cinema 30&quot;" class="img_0 img-responsive" />
					</div>
					<!--Sale Label-->
					<span class="label label-sale">Sale</span>
					<!--full quick view block-->
					<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  Quickview</a>
					<!--end full quick view block-->
				</div>
				
				
				<div class="right-block">
					<div class="caption">
						<h4><a href="product.html">Apple Cinema 30&quot;</a></h4>		
						<div class="ratings">
							<div class="rating-box">
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							</div>
						</div>
											
						<div class="price">
							<span class="price-new">$74.00</span> 
							<span class="price-old">$122.00</span>		 
							<span class="label label-percent">-40%</span>    
						</div>
						<div class="description item-desc hidden">
							<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut l..</p>
						</div>
					</div>
					
					  <div class="button-group">
						<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onclick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">Add to Cart</span></button>
						<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onclick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
						<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onclick="compare.add('42');"><i class="fa fa-exchange"></i></button>
					  </div>
				</div><!-- right block -->

			</div>
		</div>
		<div class="product-layout ">
			<div class="product-item-container">
				<div class="left-block">
					<div class="product-image-container second_img ">
						<img  src="image/demo/shop/product/14.jpg"  title="Apple Cinema 30&quot;" class="img-responsive" />
						<img  src="image/demo/shop/product/15.jpg"  title="Apple Cinema 30&quot;" class="img_0 img-responsive" />
					</div>
					<!--Sale Label-->
					<span class="label label-sale">Sale</span>
					<!--full quick view block-->
					<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  Quickview</a>
					<!--end full quick view block-->
				</div>
				
				
				<div class="right-block">
					<div class="caption">
						<h4><a href="product.html">Apple Cinema 30&quot;</a></h4>		
						<div class="ratings">
							<div class="rating-box">
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
							</div>
						</div>
											
						<div class="price">
							<span class="price-new">$74.00</span> 
							<span class="price-old">$122.00</span>		 
							<span class="label label-percent">-40%</span>    
						</div>
						<div class="description item-desc hidden">
							<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut l..</p>
						</div>
					</div>
					
					  <div class="button-group">
						<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onclick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">Add to Cart</span></button>
						<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onclick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
						<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onclick="compare.add('42');"><i class="fa fa-exchange"></i></button>
					  </div>
				</div><!-- right block -->

			</div>
		</div>
	</div>
</div>

			<!-- end Related  Products-->
			
				
			</div>
			
			
		</div>
		<!--Middle Part End-->
	</div>
	<!-- //Main Container -->
	

	<!-- Footer Container -->
	<footer class="footer-container">
		<!-- Footer Top Container -->
		<section class="footer-top">
			<div class="container content">
				<div class="row">
					<div class="col-sm-6 col-md-3 box-information">
						<div class="module clearfix">
							<h3 class="modtitle">Information</h3>
							<div class="modcontent">
								<ul class="menu">
									<li><a href="#">About Us</a></li>
									<li><a href="#">FAQ</a></li>
									<li><a href="#">Order history</a></li>
									<li><a href="#">Order information</a></li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-sm-6 col-md-3 box-service">
						<div class="module clearfix">
							<h3 class="modtitle">Customer Service</h3>
							<div class="modcontent">
								<ul class="menu">
									<li><a href="#">Contact Us</a></li>
									<li><a href="#">Returns</a></li>
									<li><a href="#">Site Map</a></li>
									<li><a href="#">My Account</a></li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-sm-6 col-md-3 box-account">
						<div class="module clearfix">
							<h3 class="modtitle">My Account</h3>
							<div class="modcontent">
								<ul class="menu">
									<li><a href="#">Brands</a></li>
									<li><a href="#">pngt Vouchers</a></li>
									<li><a href="#">Affiliates</a></li>
									<li><a href="#">Specials</a></li>
									<li><a href="#" target="_blank">Our Blog</a></li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-sm-6 col-md-3 collapsed-block ">
						<div class="module clearfix">
							<h3 class="modtitle">Contact Us	</h3>
							<div class="modcontent">
								<ul class="contact-address">
									<li><span class="fa fa-map-marker"></span> My Company, 42 avenue des Champs Elysées 75000 Paris France</li>
									<li><span class="fa fa-envelope-o"></span> Email: <a href="#"> sales@yourcompany.com</a></li>
									<li><span class="fa fa-phone">&nbsp;</span> Phone 1: 0123456789 <br>Phone 2: (123) 4567890</li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-sm-12 collapsed-block footer-links">
						<div class="module clearfix">
							<div class="modcontent">
								<hr class="footer-lines">
								<div class="footer-directory-title">
									<h4 class="label-link">Top Stores : Brand Directory | Store Directory</h4>
									<ul class="footer-directory">
										<li>
											<h4>MOST SEARCHED KEYWORDS MARKET:</h4>
											<a href="#">Xiaomi Mi3</a> | <a href="#">Dipnglip Pro XT 712 Tablet</a> | <a href="#">Mi 3 Phones</a> | <a href="#">View all</a></li>
										<li>
											<h4>MOBILES:</h4>
											<a href="#">Moto E</a> | <a href="#">Samsung Mobile</a> | <a href="#">Micromax Mobile</a> | <a href="#">Nokia Mobile</a> | <a href="#">HTC Mobile</a> | <a href="#">Sony Mobile</a> | <a href="#">Apple Mobile</a> | <a href="#">LG Mobile</a> | <a href="#">Karbonn Mobile</a> | <a href="#">View all</a></li>
										<li>
											<h4>CAMERA:</h4>
											<a href="#">Nikon Camera</a> | <a href="#">Canon Camera</a> | <a href="#">Sony Camera</a> | <a href="#">Samsung Camera</a> | <a href="#">Point shoot camera</a> | <a href="#">Camera Lens</a> | <a href="#">Camera Tripod</a> | <a href="#">Camera Bag</a> | <a href="#">View all</a></li>
										<li>
											<h4>LAPTOPS:</h4>
											<a href="#">Apple Laptop</a> | <a href="#">Acer Laptop</a> | <a href="#">Sony Laptop</a> | <a href="#">Dell Laptop</a> | <a href="#">Asus Laptop</a> | <a href="#">Toshiba Laptop</a> | <a href="#">LG Laptop</a> | <a href="#">HP Laptop</a> | <a href="#">Notebook</a> | <a href="#">View all</a></li>
										<li>
											<h4>TVS:</h4>
											<a href="#">Sony TV</a> | <a href="#">Samsung TV</a> | <a href="#">LG TV</a> | <a href="#">Panasonic TV</a> | <a href="#">Onida TV</a> | <a href="#">Toshiba TV</a> | <a href="#">Philips TV</a> | <a href="#">Micromax TV</a> | <a href="#">LED TV</a> | <a href="#">LCD TV</a> | <a href="#">Plasma TV</a> | <a href="#">3D TV</a> | <a href="#">Smart TV</a> | <a href="#">View all</a></li>
										<li>
											<h4>TABLETS:</h4>
											<a href="#">Micromax Tablets</a> | <a href="#">HCL Tablets</a> | <a href="#">Samsung Tablets</a> | <a href="#">Lenovo Tablets</a> | <a href="#">Karbonn Tablets</a> | <a href="#">Asus Tablets</a> | <a href="#">Apple Tablets</a> | <a href="#">View all</a></li>
										<li>
											<h4>WATCHES:</h4>
											<a href="#">FCUK Watches</a> | <a href="#">Titan Watches</a> | <a href="#">Casio Watches</a> | <a href="#">Fastrack Watches</a> | <a href="#">Timex Watches</a> | <a href="#">Fossil Watches</a> | <a href="#">Diesel Watches</a> | <a href="#">Luxury Watches</a> | <a href="#">View all</a></li>
										<li>
											<h4>CLOTHING:</h4>
											<a href="#">Shirts</a> | <a href="#">Jeans</a> | <a href="#">T shirts</a> | <a href="#">Kurtis</a> | <a href="#">Sarees</a> | <a href="#">Levis Jeans</a> | <a href="#">Killer Jeans</a> | <a href="#">Pepe Jeans</a> | <a href="#">Arrow Shirts</a> | <a href="#">Ethnic Wear</a> | <a href="#">Formal Shirts</a> | <a href="#">Peter England Shirts</a> | <a href="#">View all</a></li>
										<li>
											<h4>FOOTWEAR:</h4>
											<a href="#">Shoes</a> | <a href="#">Casual Shoes</a> | <a href="#">Adidas Shoes</a> | <a href="#">Gas Shoes</a> | <a href="#">Puma Shoes</a> | <a href="#">Reebok Shoes</a> | <a href="#">Woodland Shoes</a> | <a href="#">Red tape Shoes</a> | <a href="#">Nike Shoes</a> | <a href="#">View all</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- /Footer Top Container -->
		
		<!-- Footer Bottom Container -->
		<div class="footer-bottom-block ">
			<div class=" container">
				<div class="row">
					<div class="col-sm-5 copyright-text">Copyright &copy; 2017.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a></div>
					<div class="col-sm-7">
						<div class="block-payment text-right"><img src="image/demo/content/payment.png" alt="payment" title="payment" ></div>
					</div>
					<!--Back To Top-->
					<div class="back-to-top"><i class="fa fa-angle-up"></i><span> Top </span></div>

				</div>
			</div>
		</div>
		<!-- /Footer Bottom Container -->
		
		
	</footer>
	<!-- //end Footer Container -->

    </div>
	
	
	<!-- Cpanel Block -->
	<div id="sp-cpanel_btn" class="isDown visible-lg">
	<i class="fa fa-cog"></i>
</div>		

<!-- 登录对话框 -->
		<style type="text/css">
			#overDiv {  
				background-color:#000;  
				width: 100%;  
				height: 100%;  
				left: 0;  
				top: 0; /*FF IE7*/  
				filter: alpha(opacity = 65); /*IE*/  
				opacity: 0.65; /*FF*/  
				z-index: 2147483646;  
				position: fixed !important; /*FF IE7*/  
				position: absolute; /*IE6*/  
				_top: expression(eval(document.compatMode &&   
				document.compatMode == 'CSS1Compat')?   
				documentElement.scrollTop+  (document.documentElement.clientHeight-this.offsetHeight)/2: /*IE6*/   
				document.body.scrollTop+  (document.body.clientHeight-  this.clientHeight)/2 ); /*IE5 IE5.5*/  
			}
			#hsDiv {  
				background:#fff; 
				display: none;
				border-radius: 7px;
				z-index: 2147483647;  
				width: 400px;  
				height: 300px;  
				left: 43%; /*FF IE7*/  
				top: 37%; /*FF IE7*/  
				margin-left: -150px !important; /*FF IE7 该值为本身宽的一半 */  
				margin-top: -60px !important; /*FF IE7 该值为本身高的一半*/  
				margin-top: 0px;  
				position: fixed !important; /*FF IE7*/  
				position: absolute; /*IE6*/  
				_top: expression(eval(document.compatMode &&   
				document.compatMode == 'CSS1Compat')?   
				documentElement.scrollTop+  (document.documentElement.clientHeight-this.offsetHeight)/2: /*IE6*/   
				document.body.scrollTop+  (document.body.clientHeight-  this.clientHeight)/2 ); /*IE5 IE5.5*/  
			}
			#closediv{  
				margin-left: 370px;
				margin-top: -30px;
				font-size: 25px;
			} 
		</style>
		<!-- 登录对话框javascript -->
		<script type="text/javascript">
			function show_login(){
				document.getElementById("overDiv").style.display = "block";
				document.getElementById("hsDiv").style.display = "block";
			}
			function closeDiv(){
				document.getElementById("overDiv").style.display = "none";
				document.getElementById("hsDiv").style.display = "none";
			}
		</script>
		<div class="page-login" id="hsDiv">
			<div class="account-border">
				<form action="${ pageContext.request.contextPath }/user_login.action" method="post" enctype="multipart/form-data">
					<div class="customer-login">
						<div class="well" style="border-radius: 7px;">
							<!-- 右上角关闭按钮 -->  
							<div id="closediv">  
								<a href="javascript:void(0);" onclick="closeDiv()">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
								</a>
							</div>
							<p><strong>请登录，</strong></p>
							<div class="form-group">
								<label class="control-label " for="input-account">账户</label>
								<input type="text" name="user_name" value="" id="input-account" class="form-control" />
							</div>
							<div class="form-group">
								<label class="control-label " for="input-password">密码</label>
								<input type="password" name="user_pwd" value="" id="input-password" class="form-control" />
							</div>
							<div>
								<a href="#" class="forgot">忘记密码</a>
							</div>
							<div class="bottom-form" style="text-align: center;">
								<input type="button"  onClick="window.open('http://localhost:8080/tdd/jsp/front/regist.jsp','_blank')" value="前往注册" class="btn btn-default pull-left" style="width: 48%;" />
								<input type="button" onclick="login();" value="立即登录" class="btn btn-default pull-right" style="width: 48%;" />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="overDiv" style="display:none;"></div>  
		<!-- 结束登录对话框 -->

<div id="sp-cpanel" class="sp-delay">
	<h2 class="sp-cpanel-title"> Demo Options <span class="sp-cpanel-close"> <i class="fa fa-times"> </i></span></h2>
	<div id="sp-cpanel_settings">
		<div class="panel-group">
			<label>Color Scheme</label>
			<div class="group-schemes" >
				<span data-scheme="default"  class="item_scheme selected"><span style="background: #e8622d;"></span></span>
				<span data-scheme="blue" class="item_scheme"><span style="background: #478bca;"></span></span>
				<span data-scheme="boocdo"  class="item_scheme"><span style="background: #e54e4e;"></span></span>
				<span data-scheme="cyan" class="item_scheme"><span style="background: #1ea181;"></span></span>
				<span data-scheme="green" class="item_scheme "><span style="background: #52a633;"></span></span>
				
			 </div>
		</div>
		
		<div class="panel-group ">
			<label>Header style</label>
			<div class="group-boxed">
				<select id="change_header_type" name="cpheaderstype" class="form-control" onchange="headerTypeChange(this.value);">
					<option value="header-home1" >Header 1</option>
					<option value="header-home2" >Header 2</option>
					<option value="header-home3" >Header 3</option>
					<option value="header-home4" >Header 4</option>
				</select>
			</div>
		</div>
		
		
		<div class="panel-group ">
			<label>Layout Box</label>
			<div class="group-boxed">
				<select id="cp-layoutbox" name="cplayoutbox" class="form-control" onchange="changeLayoutBox(this.value);">
					<option value="full">Wide</option>
					<option value="boxed">Boxed</option>
					<option value="iframed">Iframed</option>
					<option value="rounded">Rounded</option>
				</select>
			</div>
		</div>
		
        <div class="panel-group">
			<label>Body Image</label>
			
			<div class="group-pattern">
				<div data-pattern="28"  class="img-pattern"><img src="image/theme/patterns/28.png" alt="pattern 28"></div>
				<div data-pattern="29"  class="img-pattern"><img src="image/theme/patterns/29.png" alt="pattern 29"></div>
				<div data-pattern="30"  class="img-pattern"><img src="image/theme/patterns/30.png" alt="pattern 30"></div>
				<div data-pattern="31"  class="img-pattern"><img src="image/theme/patterns/31.png" alt="pattern 31"></div>
				<div data-pattern="32"  class="img-pattern"><img src="image/theme/patterns/32.png" alt="pattern 32"></div>
				<div data-pattern="33"  class="img-pattern"><img src="image/theme/patterns/33.png" alt="pattern 33"></div>
				<div data-pattern="34"  class="img-pattern"><img src="image/theme/patterns/34.png" alt="pattern 34"></div>
				<div data-pattern="35"  class="img-pattern"><img src="image/theme/patterns/35.png" alt="pattern 35"></div>
				<div data-pattern="36"  class="img-pattern"><img src="image/theme/patterns/36.png" alt="pattern 36"></div>
				<div data-pattern="37"  class="img-pattern"><img src="image/theme/patterns/37.png" alt="pattern 37"></div>
				<div data-pattern="38"  class="img-pattern"><img src="image/theme/patterns/38.png" alt="pattern 38"></div>
				<div data-pattern="39"  class="img-pattern"><img src="image/theme/patterns/39.png" alt="pattern 39"></div>
				<div data-pattern="40"  class="img-pattern"><img src="image/theme/patterns/40.png" alt="pattern 40"></div>
				<div data-pattern="41"  class="img-pattern"><img src="image/theme/patterns/41.png" alt="pattern 41"></div>
				<div data-pattern="42"  class="img-pattern"><img src="image/theme/patterns/42.png" alt="pattern 42"></div>
				<div data-pattern="43"  class="img-pattern"><img src="image/theme/patterns/43.png" alt="pattern 43"></div>
				<div data-pattern="44"  class="img-pattern"><img src="image/theme/patterns/44.png" alt="pattern 44"></div>
				<div data-pattern="45"  class="img-pattern"><img src="image/theme/patterns/45.png" alt="pattern 45"></div>
			</div>
			<p class="label-sm">Background only applies for Boxed,Framed, Rounded Layout</p>
		</div>
		
		<div class="reset-group">
		    <a href="index.jsp" class="btn btn-success " onclick="ResetAll()">Reset</a>
		</div>
		
	</div>

</div>

<link rel='stylesheet' property='stylesheet'  href='css/themecss/cpanel.css' type='text/css' media='all' />
	
	<!-- Preloading Screen -->
	<div id="loader-wrapper">
		<div id="loader"></div>
		<div class="loader-section section-left"></div>
		<div class="loader-section section-right"></div>
	 </div>
	<!-- End Preloading Screen -->
	
<!-- Include Libs & Plugins
	============================================ -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/owl-carousel/owl.carousel.js"></script>
	<script type="text/javascript" src="js/themejs/libs.js"></script>
	<script type="text/javascript" src="js/unveil/jquery.unveil.js"></script>
	<script type="text/javascript" src="js/countdown/jquery.countdown.min.js"></script>
	<script type="text/javascript" src="js/dcjqaccordion/jquery.dcjqaccordion.2.8.min.js"></script>
	<script type="text/javascript" src="js/datetimepicker/moment.js"></script>
	<script type="text/javascript" src="js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui/jquery-ui.min.js"></script>
 	<!-- Theme files
	============================================ -->
 	<script type="text/javascript" src="js/themejs/so_megamenu.js"></script>
	<script type="text/javascript" src="js/themejs/addtocart.js"></script>
	<script type="text/javascript" src="js/themejs/application.js"></script>
	<script type="text/javascript" src="js/themejs/cpanel.js"></script>
</body>
</html>