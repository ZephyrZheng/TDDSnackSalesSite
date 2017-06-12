<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Basic page needs
	============================================ -->
	<title>淘丁丁首页</title>
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
	
	<script type="text/javascript">
	/*全局数据变量*/
	var local_data = "";
	var local_cat = "";
	var local_pics = "";
	/* 获取index关键字 */
	//Session获取用户 / 购物车列表
	var u_name ="<%=session.getAttribute("User_name")%>";
	var u_id ="<%=session.getAttribute("User_id")%>"; 
	var shopCar = "<%=session.getAttribute("ShopcarList")%>";
	var orderlist = "<%=session.getAttribute("OrderList")%>";   
	//alert("当前session_购物车"+shopCar);
	function load()
	{//发送请求获取数据，填充页面
		//进入页面判断用户是否登录
		if(u_name!=null && u_name!="null"){
			//alert(u_name+u_id);
			document.getElementById("my_account").innerHTML = "欢迎你，"+u_name;
			//隐藏上方用户注册状态
			document.getElementById("login").style.display = "none";
			document.getElementById("regist").style.display = "none";
			document.getElementById("shopcarpage").style.display = "block";
			document.getElementById("exit").style.display = "block";
			
			//document.getElementById("login_hint").style.display = "none";
			//document.getElementById("jump_hint").style.display = "block";
			//购物车有数据
			// if(shopCar=="1"){
			// 	//alert("购物车有数据：Todo..填充列表");
			// 	//ShopCar_To_Goods
			// 	var allGoods = [];
			// 	var url = '${ pageContext.request.contextPath }/user_getShopCart.action?user_id='
			// 		+u_id;
			// 	var param = {};
			// 	$.post(url,param,function(data){
			// 		var shopcar_list = data.ShopCarList;
			// 		for (var i = 0; i < shopcar_list.length; i++) {
			// 			//逐条调用购物车项 填充
			// 			Get_Good(shopcar_list[i].goods_id,shopcar_list[i].goods_num);
			// 		}
					
			// 	});
				
			// }
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
				 + "  class=\"preview\"> </a>		</td>		<td class=\"text-left\"> <a target=\"_blank\" class=\"cart_product_name\" " 
				 + "  href=\"product.jsp?key_word=" + data.goods_name +"\"><span style=\"font-size: 10pt;\">"+ data.goods_name + "</span></a> </td>		<td class=\"text-center\"> " 
				 + "x"+ goods_num
				 + "</td>		<td class=\"text-center\"> "+ sum_of_one +"￥ </td>		<td class=\"text-right\">	" 
				 + "<a href=\"product.html\"  " 
				 + " class=\"fa fa-edit\"></a>		</td>			</tr> "; 
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
	
	
	</script>
	
</head>

<body onload="load()" class="common-home res layout-home1">

    <div id="wrapper" class="wrapper-full banners-effect-7">
	<!-- Header Container  -->
	<header id="header" class=" variantleft type_1">
<!-- Header Top -->
<div class="header-top compact-hidden">
	<div class="container">
		<div class="row">
			<div class="header-top-left form-inline col-sm-6 col-xs-12 compact-hidden">
				
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
						<li id="shopcarpage" class="login"><a target="_blank" href="shopcar.jsp" title="Shopping Cart"><span >购物车</span></a></li>
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
				<a href="index.html"><img src="image/demo/logos/theme_logo.png" title="Your Store" alt="Your Store" />淘丁丁零食</a>
			</div>
			<!-- //end Logo -->

			<!-- 搜索栏 -->
			<div id="sosearchpro" class="col-sm-7 search-pro">
				<form method="GET" action="product.jsp" target="_blank">
					<div id="search0" class="search input-group">
						<!-- <div class="select_category filter_type icon-select" name="category_id">
							<select class="no-border" >
								<option value="0">All Categories</option>
								<option value="78">Apparel</option>
								<option value="77">Cables &amp; Connectors</option>
								<option value="82">Cameras &amp; Photo</option>
								<option value="80">Flashlights &amp; Lamps</option>
								<option value="81">Mobile Accessories</option>
								<option value="79">Video Games</option>
								<option value="20">Jewelry &amp; Watches</option>
								<option value="76">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Earings</option>
								<option value="26">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Wedding Rings</option>
								<option value="27">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Men Watches</option>
							</select>
						</div> -->

						<input name="key_word" class="autosearch-input form-control" type="text" value="" size="50" autocomplete="off" placeholder="搜索">
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
				
				<!--//cart-->
			</div>
		</div>

	</div>
</div>
<!-- //Header center -->

<!-- Header Bottom -->
<!-- Header Bottom 头部底部-->
<div class="header-bottom">
	<div class="container">
		<div class="row">
			<div class="sidebar-menu col-md-3 col-sm-6 col-xs-12 ">
				<div class="responsive so-megamenu ">
					<div class="so-vertical-menu no-gutter compact-hidden">
						<nav class="navbar-default">
							<div class="container-megamenu vertical open">
								<div id="menuHeading">
									<div class="megamenuToogle-wrapper">
										<div class="megamenuToogle-pattern">
											<div class="container">
												<div>
													<span></span>
													<span></span>
													<span></span>
												</div>
												商品类别
												<i class="fa pull-right arrow-circle fa-chevron-circle-up"></i>
											</div>
										</div>
									</div>
								</div>
								<div class="navbar-header">
									<button type="button" id="show-verticalmenu" data-toggle="collapse" class="navbar-toggle fa fa-list-alt">

									</button>
									商品类别
								</div>
								<div class="vertical-wrapper" >
									<span id="remove-verticalmenu" class="fa fa-times"></span>
									<div class="megamenu-pattern">
										<div class="container">
											<ul class="megamenu">
												<!-- 菜单1 -->
												<li class="item-vertical style1 with-sub-menu hover">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<span>饼干</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="45" >
														<div class="content" >
															<div class="row">
																<div class="col-sm-12">
																	<div class="row">
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">传统饼干</a>
																						<ul>
																							<li><a href="#" >曲奇饼干</a></li>
																							<li><a href="#" >威化饼干</a></li>
																							<li><a  href="#" >薄脆饼干</a></li>
																							<li><a href="#" >夹心饼干</a></li>
																							<li><a href="#" >消化饼干</a></li>
																							<li><a href="#" >燕麦饼干</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">膨化食品</a>
																						<ul>
																							<li><a href="#" >薯片</a></li>
																							<li><a href="#" >锅巴</a></li>
																							<li><a href="#" >玉米豆</a></li>
																							<li><a href="#" >虾片</a></li>
																							<li><a href="#" >北田能量棒</a></li>
																							<li><a href="#" >米饼</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#"  class="main-menu">蛋黄派</a>
																						<ul>
																							<li><a href="#" >达利园</a></li>
																							<li><a href="#" >好丽友</a></li>
																							<li><a href="#" >乐天</a></li>
																							<li><a href="#" >盼盼</a></li>
																							<li><a href="#" >欧乐</a></li>
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
												<li class="item-vertical style1 with-sub-menu hover"">
												<p class="close-menu"></p>
												<a href="#" class="clearfix">
													<span>干货</span>
													<b class="caret"></b>
												</a>
												<div class="sub-menu" data-subwidth="75" >
													<div class="content" >
														<div class="row">
															<div class="col-sm-12">
																<div class="row">
																	<div class="col-md-2 static-menu" style="width: 20%;">
																		<div class="menu">
																			<ul>
																				<li>
																					<a href="#"  class="main-menu">坚果炒货</a>
																					<ul>
																						<li><a href="#" >夏威夷果</a></li>
																						<li><a href="#" >松子</a></li>
																						<li><a href="#" >开心果</a></li>
																						<li><a href="#" >瓜子</a></li>
																						<li><a href="#" >巴旦木</a></li>
																						<li><a href="#" >腰果</a></li>
																						<li><a href="#" >杏仁</a></li>
																						<li><a href="#" >花生</a></li>
																					</ul>
																				</li>
																			</ul>
																		</div>
																	</div>
																	<div class="col-md-2 static-menu" style="width: 20%;">
																		<div class="menu">
																			<ul>
																				<li>
																					<a href="#"  class="main-menu">核桃</a>
																					<ul>
																						<li><a href="#" >山核桃</a></li>
																						<li><a href="#" >纸皮核桃</a></li>
																						<li><a href="#" >核桃仁</a></li>
																						<li><a href="#" >长寿果</a></li>
																						<li><a href="#" >巴旦木</a></li>
																						<li><a href="#" >椒盐</a></li>
																						<li><a href="#" >奶油</a></li>
																						<li><a href="#" >原味</a></li>
																						<li><a href="#" >五香</a></li>
																					</ul>
																				</li>
																			</ul>
																		</div>
																	</div>
																	<div class="col-md-2 static-menu" style="width: 20%;">
																		<div class="menu">
																			<ul>
																				<li>
																					<a href="#"  class="main-menu">肉类即食</a>
																					<ul>
																						<li><a href="#" >牛肉干</a></li>
																						<li><a href="#" >牛板筋</a></li>
																						<li><a href="#" >猪肉脯</a></li>
																						<li><a href="#" >鸭脖</a></li>
																						<li><a href="#" >鸡肉</a></li>
																						<li><a href="#" >豆干</a></li>
																					</ul>
																				</li>
																			</ul>
																		</div>
																	</div>
																	<div class="col-md-2 static-menu" style="width: 20%;">
																		<div class="menu">
																			<ul>
																				<li>
																					<a href="#"  class="main-menu">梅/果干</a>
																					<ul>
																						<li><a href="#" >红枣</a></li>
																						<li><a href="#" >梅类</a></li>
																						<li><a href="#" >蜜饯</a></li>
																						<li><a href="#" >果脯</a></li>
																						<li><a href="#" >蔬果干</a></li>
																						<li><a href="#" >榴莲干</a></li>
																					</ul>
																				</li>
																			</ul>
																		</div>
																	</div>
																	<div class="col-md-2 static-menu" style="width: 20%;">
																		<div class="menu">
																			<ul>
																				<li>
																					<a href="#"  class="main-menu">海味即食</a>
																					<ul>
																						<li><a href="#" >鱿鱼丝</a></li>
																						<li><a href="#" >鱼干</a></li>
																						<li><a href="#" >海苔</a></li>
																						<li><a href="#" >章鱼足</a></li>
																						<li><a href="#" >鱼豆腐</a></li>
																						<li><a href="#" >裙带菜</a></li>
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
												<li class="item-vertical with-sub-menu hover">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<span class="label"></span>
														<span>面食</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="20" >
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-12 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">方便面</a>
																						<ul>
																							<li>
																								<a href="#" >面条</a>
																							</li>
																							<li>
																								<a href="#" >意大利面</a>
																							</li>
																							<li>
																								<a href="#" >冷面</a>
																							</li>
																							<li>
																								<a href="#" >煎饼</a>
																							</li>
																							<li>
																								<a href="#" >速食汤</a>
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
												<li class="item-vertical with-sub-menu hover">
													<p class="close-menu"></p>
													<a href="#" class="clearfix">
														<span>糕点</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="45" >
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">传统糕点</a>
																						<ul>
																							<li>
																								<a href="#" >麻薯</a>
																							</li>
																							<li>
																								<a href="#" >绿豆糕</a>
																							</li>
																							<li>
																								<a href="#" >鲜花饼</a>
																							</li>
																							<li>
																								<a href="#">凤梨酥</a>
																							</li>
																							<li>
																								<a href="#">黄山烧饼</a>
																							</li>
																							<li>
																								<a href="#">麻花</a>
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
																						<a href="" onClick="window.location = '24';" class="main-menu">西式糕点</a>
																						<ul>
																							<li><a href="#" >提拉米苏</a></li>
																							<li><a href="#" >榴莲酥</a></li>
																							<li><a href="#" >牛乳蛋糕</a></li>
																							<li><a href="#" >甜甜圈</a></li>
																							<li><a href="#" >铜锣烧</a></li>
																							<li><a href="#" >华夫饼</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-4 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">月饼</a>
																						<ul>
																							<li>
																								<a href="#" >广式月饼</a>
																							</li>
																							<li>
																								<a href="#" >苏式月饼</a>
																							</li>
																							<li>
																								<a href="#" >云腿月饼</a>
																							</li>
																							<li>
																								<a href="#" >莲蓉月饼</a>
																							</li>
																							<li>
																								<a href="#" >五仁月饼</a>
																							</li>
																							<li>
																								<a href="#" >香港美心</a>
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
														<span>糖果</span>
														<b class="caret"></b>
													</a>

													<div class="sub-menu" data-subwidth="20" style="margin-top: -165px;">
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-12 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">糖果巧克力</a>
																						<ul>
																							<li>
																								<a href="#" >松露巧克力</a>
																							</li>
																							<li>
																								<a href="#" >夹心巧克力</a>
																							</li>
																							<li>
																								<a href="#" >糖果</a>
																							</li>
																							<li>
																								<a href="#" >果冻</a>
																							</li>
																							<li>
																								<a href="#" >布丁</a>
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
														<span>饮料</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="45" style="margin-top: -237px;">
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-3 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">咖啡</a>
																						<ul>
																							<li>
																								<a href="#" >速溶咖啡</a>
																							</li>
																							<li>
																								<a href="#" >咖啡豆</a>
																							</li>
																							<li>
																								<a href="#" >咖啡粉</a>
																							</li>
																							<li>
																								<a href="#">奶精</a>
																							</li>
																							<li>
																								<a href="#">奶油球</a>
																							</li>
																							<li>
																								<a href="#">糖浆</a>
																							</li>
																							<li>
																								<a href="#">白沙糖包</a>
																							</li>
																							<li>
																								<a href="#">黄糖包</a>
																							</li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-3 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="" onClick="window.location = '24';" class="main-menu">冲饮</a>
																						<ul>
																							<li><a href="#" >藕粉</a></li>
																							<li><a href="#" >麦片</a></li>
																							<li><a href="#" >冲饮果汁</a></li>
																							<li><a href="#" >豆奶</a></li>
																							<li><a href="#" >豆浆</a></li>
																							<li><a href="#" >姜汤</a></li>
																							<li><a href="#" >奶茶</a></li>
																							<li><a href="#" >酸梅粉</a></li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-3 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">饮料</a>
																						<ul>
																							<li>
																								<a href="#" >果蔬汁</a>
																							</li>
																							<li>
																								<a href="#" >碳酸饮料</a>
																							</li>
																							<li>
																								<a href="#" >功能饮料</a>
																							</li>
																							<li>
																								<a href="#" >凉茶</a>
																							</li>
																							<li>
																								<a href="#" >矿泉水</a>
																							</li>
																							<li>
																								<a href="#" >果味饮料</a>
																							</li>
																							<li>
																								<a href="#" >含乳饮料</a>
																							</li>
																							<li>
																								<a href="#" >即饮咖啡</a>
																							</li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-3 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">乳制品</a>
																						<ul>
																							<li>
																								<a href="#" >纯牛奶</a>
																							</li>
																							<li>
																								<a href="#" >酸奶</a>
																							</li>
																							<li>
																								<a href="#" >酸奶粉</a>
																							</li>
																							<li>
																								<a href="#" >羊奶</a>
																							</li>
																							<li>
																								<a href="#" >德亚</a>
																							</li>
																							<li>
																								<a href="#" >蒙牛</a>
																							</li>
																							<li>
																								<a href="#" >光明</a>
																							</li>
																							<li>
																								<a href="#" >伊利</a>
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
														<span>酒水</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="30" style="margin-top: -190px;">
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-6 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">啤酒</a>
																						<ul>
																							<li>
																								<a href="#" >教士</a>
																							</li>
																							<li>
																								<a href="#" >奥丁格</a>
																							</li>
																							<li>
																								<a href="#" >瓦伦丁</a>
																							</li>
																							<li>
																								<a href="#">喜力</a>
																							</li>
																							<li>
																								<a href="#">1664</a>
																							</li>
																							<li>
																								<a href="#">智美</a>
																							</li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-6 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="" onClick="window.location = '24';" class="main-menu">调制酒</a>
																						<ul>
																							<li><a href="#" >杨梅酒</a></li>
																							<li><a href="#" >樱花酒</a></li>
																							<li><a href="#" >自制葡萄酒</a></li>
																							<li><a href="#" >梅子酒</a></li>
																							<li><a href="#" >桑葚酒</a></li>
																							<li><a href="#" >蓝莓酒</a></li>
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
														<span>进口</span>
														<b class="caret"></b>
													</a>
													<div class="sub-menu" data-subwidth="30" style="margin-top: -238px;">
														<div class="content" >
															<div class="row">
																<div class="col-md-12">
																	<div class="row">
																		<div class="col-md-6 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="#" class="main-menu">进口饼干</a>
																						<ul>
																							<li>
																								<a href="#" >日本</a>
																							</li>
																							<li>
																								<a href="#" >韩国</a>
																							</li>
																							<li>
																								<a href="#" >苏打</a>
																							</li>
																							<li>
																								<a href="#">曲奇</a>
																							</li>
																							<li>
																								<a href="#">夹心</a>
																							</li>
																							<li>
																								<a href="#">膨化</a>
																							</li>
																							<li>
																								<a href="#">蛋卷</a>
																							</li>
																						</ul>
																					</li>
																				</ul>
																			</div>
																		</div>
																		<div class="col-md-6 static-menu">
																			<div class="menu">
																				<ul>
																					<li>
																						<a href="" onClick="window.location = '24';" class="main-menu">进口零食</a>
																						<ul>
																							<li><a href="#" >巧克力</a></li>
																							<li><a href="#" >果冻</a></li>
																							<li><a href="#" >软糖</a></li>
																							<li><a href="#" >牛轧糖</a></li>
																							<li><a href="#" >咖啡糖</a></li>
																							<li><a href="#" >口香糖</a></li>
																							<li><a href="#" >海苔</a></li>
																							<li><a href="#" >奶片</a></li>
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
											</ul>
										</div>
									</div>
								</div>
							</div>
						</nav>
					</div>
				</div>
			</div>

			<!-- Main menu 主菜单-->
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
											<li class="hidden-md">
												<p class="close-menu"></p>
												<a href="orders.jsp" target="_blank" class="clearfix">
													<strong>订单</strong>
												</a>
											</li>
											<li class="hidden-md">
												<p class="close-menu"></p>
												<a href="shopcar.jsp" target="_blank" class="clearfix">
													<strong>购物车</strong>
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
			<!-- //End Main menu 结束主菜单-->

		</div>
	</div>
</div>
<!-- //End Header Bottom 结束头部底部 -->

<!-- Navbar switcher -->
<!-- //end Navbar switcher -->
	</header>
	<!-- //Header Container  -->
	<!-- Block Spotlight1  -->
	<section class="so-spotlight1 ">
		<div class="container">
			<div class="row">
				<div id="yt_header_right" class="col-lg-offset-3 col-lg-9 col-md-12">
					<div class="slider-container "> 
							
						<div class="module first-block">
							<div class="modcontent clearfix">
								<div id="custom_popular_search" class="clearfix">
									<h5 class="so-searchbox-popular-title pull-left">搜索热词:</h5>
									<div class="so-searchbox-keyword">
										<ul class="list-inline"><li>&nbsp;<a target="_blank" href="product.jsp?key_word=小熊饼干" target="_blank">小熊饼干、</a></li><li><a target="_blank" href="product.jsp?key_word=可口可乐" target="_blank">可口可乐、</a></li><li><a target="_blank" href="product.jsp?key_word=沙琪玛" target="_blank">沙琪玛、</a></li><li><a target="_blank" href="product.jsp?key_word=合味道" target="_blank">合味道、</a></li><li><a target="_blank" href="product.jsp?key_word=汤达人" target="_blank">汤达人、</a></li><li><a target="_blank" href="product.jsp?key_word=七喜" target="_blank">七喜</a></ul>
									</div>
								</div>
							</div>
						</div>
						<div id="so-slideshow" class="col-lg-8 col-md-8 col-sm-12 col-xs-12 two-block">
							<div class="module slideshow no-margin">
								<div class="item">
									<a target="_blank" href="product.jsp?key_word=沙琪玛" target="_blank"><img src="image/demo/slider/slider-1.jpg" alt="slider1" class="img-responsive"></a>
								</div>
								<div class="item">
									<a target="_blank" href="product.jsp?key_word=德芙" target="_blank"><img src="image/demo/slider/slider-2.jpg" alt="slider2" class="img-responsive"></a>
								</div>
								<div class="item">
									<a target="_blank" href="product.jsp?key_word=奥利奥" target="_blank"><img src="image/demo/slider/slider-3.png" alt="slider3" class="img-responsive"></a>
								</div>
							</div>
							<div class="loadeding"></div>
						</div>

						
						<div class="module col-md-4  hidden-sm hidden-xs three-block ">
							<div class="modcontent clearfix">
								<div class="htmlcontent-block">	
									<ul class="htmlcontent-home">		
										<li>
											<div class="banners">
												<div>
													<a href="#"><img src="image/demo/cms/banner1.jpg" alt="banner1"></a>
												</div>
											</div>
										</li>		
										<li>
											<div class="banners">
												<div>
													<a href="#"><img src="image/demo/cms/banner2.jpg" alt="banner1"></a>
												</div>
											</div>
										</li>		
										<li>
											<div class="banners">
												<div>
													<a href="#"><img src="image/demo/cms/banner3.jpg" alt="banner1"></a>
												</div>
											</div>
										</li>	
									</ul>
								</div>
							</div>
						</div>

						
					</div>
				</div>
			</div>
		</div>  
	</section>
	<!-- //Block Spotlight1  -->
	<!-- Main Container  -->
	<div class="main-container container">
		
		<div class="row">
			<div id="content" class="col-sm-12">
				
<div class="module tab-slider titleLine">
	<h3 class="modtitle">零食前线</h3>
	<div id="so_listing_tabs_1" class="so-listing-tabs first-load module">
		<div class="loadeding"></div>
		<div class="ltabs-wrap">
			<div class="ltabs-tabs-container" data-delay="300" data-duration="600" data-effect="starwars" data-ajaxurl="#" data-type_source="0">
				<!--Begin Tabs-->
				<div class="ltabs-tabs-wrap"> 
				<span class="ltabs-tab-selected">Jewelry &amp; Watches	</span> <span class="ltabs-tab-arrow">▼</span>
					<div class="item-sub-cat">
						<ul class="ltabs-tabs cf">
							<li class="ltabs-tab tab-sel" data-category-id="20" data-active-content=".items-category-20"> <span class="ltabs-tab-label">Jewelry &amp; Watches						</span> </li>
							<li class="ltabs-tab " data-category-id="18" data-active-content=".items-category-18"> <span class="ltabs-tab-label">Electronics		</span> </li>
							<li class="ltabs-tab " data-category-id="25" data-active-content=".items-category-25"> <span class="ltabs-tab-label">Sports &amp; Outdoors	</span> </li>
						</ul>
					</div>
				</div>
				<!-- End Tabs-->
			</div>
			<div class="ltabs-items-container">
				<!--Begin Items-->
				<div class="ltabs-items ltabs-items-selected items-category-20 grid" data-total="10">
					<div class="ltabs-items-inner ltabs-slider ">
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/J9.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/J5.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe" href="" target="_blank">前往购买</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" target="_blank" href="product.jsp?key_word=大白兔奶糖">大白兔奶糖</a></h4>		
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
											<span class="price-new">23.9￥</span> 
											<span class="price-old">25.9￥</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/m1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/m3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--New Label-->
									<span class="label label-new">New</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.jsp?key_word=巧克力派">巧克力派	</a></h4>		
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
											<span class="price-new">$59.00</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/B10.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/B9.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.jsp?key_word=koka">Koka方便面</a></h4>		
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
											<span class="price-new">6.1￥</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/11.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/141.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.jsp?key_word=核桃">核桃</a></h4>		
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
											<span class="price-new">37.0￥</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/B5.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/m2.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">达利园面包</a></h4>		
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
											<span class="price-new">$65.00</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>	
					</div>
					
				</div>
				<div class="ltabs-items items-category-18 grid" data-total="11">
					<div class="ltabs-items-inner ltabs-slider ">
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/e11.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/E3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">Apple Cinema 30"</a></h4>		
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
											<span class="price-new">$50.00</span> 
											<span class="price-old">$62.00</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/141.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/11.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html"> Canon EOS 5D</a></h4>		
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
											<span class="price-new">$60.00</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/35.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/34.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">Filet Mign</a></h4>		
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
											<span class="price-new">$97.00</span> 
											<span class="price-old">$122.00</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/E3_1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/E3_3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">HP LP3065</a></h4>		
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
											<span class="price-new">$60.00</span> 
											<span class="price-old">$100.00</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/e11.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/E3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">Apple Cinema 30"</a></h4>		
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
											<span class="price-new">$50.00</span> 
											<span class="price-old">$62.00</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
					</div>
					
				</div>
				<div class="ltabs-items  items-category-25 grid" data-total="11">
					<div class="ltabs-items-inner ltabs-slider ">
						
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/141.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/11.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html"> Dail Lulpa</a></h4>		
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
											<span class="price-new">$78.00</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/B10.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/B9.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">koko方便面</a></h4>		
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
											<span class="price-new">4.9￥</span> 
											<span class="price-old">7.9￥</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/w1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/w10.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									<!--Sale Label-->
									<span class="label label-sale">Sale</span>
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">Beef Bint</a></h4>		
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
											<span class="price-new">$90.00</span> 
											<span class="price-old">$100.00</span>		 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>
						<div class="ltabs-item product-layout">
							<div class="product-item-container">
								<div class="left-block">
									<div class="product-image-container second_img ">
										<img src="image/demo/shop/product/B5.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
										<img src="image/demo/shop/product/B10.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
									</div>
									
									<!--full quick view block-->
									<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
									<!--end full quick view block-->
								</div>
								<div class="right-block">
									<div class="caption">
										<h4><a target="_blank" href="product.html">Bint Beef</a></h4>		
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
											<span class="price-new">$97.00</span> 
										</div>
									</div>
									
									  <div class="button-group">
										<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
										<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
										<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
									  </div>
								</div><!-- right block -->
							</div>
						</div>	
					</div>
					
				</div>
			</div>
			<!--End Items-->
			
			
		</div>
		
	</div>
</div>
		<div class="module ">
			<div class="modcontent clearfix">
				<div class="banner-wraps ">
					<div class="m-banner row">
						<div class="banner htmlconten1 col-lg-4 col-md-4 col-sm-6 col-xs-12">
							<div class="banners">
								<div>
									<a href="#"><img src="image/demo/cms/banner2-1.png" alt="banner1"></a>
								</div>
							</div>
						</div>
						<div class="htmlconten2 col-lg-4 col-md-4 col-sm-6 col-xs-12">
							<div class="module banners">
									<div>
										<a href="#"><img src="image/demo/cms/banner2-2.png" alt="banner1"></a>
									</div>
							</div>
								
							<div class="banners">
								<div>
									<a href="#"><img src="image/demo/cms/banner2-3.png" alt="banner1"></a>
								</div>
							</div>
							
						</div>
						<div class="banner htmlconten3 hidden-sm col-lg-4 col-md-4 col-sm-6 col-xs-12">
							<div class="banners">
								<div>
									<a href="#"><img src="image/demo/cms/banner2-4.png" alt="banner1"></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="module tab-slider titleLine">
		<h3 class="modtitle">进口热销</h3>
		<div id="so_listing_tabs_2" class="so-listing-tabs first-load module">
			<div class="loadeding"></div>
			<div class="ltabs-wrap ">
				<div class="ltabs-tabs-container" data-delay="300" data-duration="600" data-effect="starwars" data-ajaxurl="#" data-type_source="0">
					<!--Begin Tabs-->
					<div class="ltabs-tabs-wrap"> 
					<span class="ltabs-tab-selected">Jewelry &amp; Watches	</span> <span class="ltabs-tab-arrow">▼</span>
						<div class="item-sub-cat">
							<ul class="ltabs-tabs cf">
								<li class="ltabs-tab tab-sel" data-category-id="1" data-active-content=".items-category-1"> <span class="ltabs-tab-label">Jewelry &amp; Watches						</span> </li>
								<li class="ltabs-tab " data-category-id="2" data-active-content=".items-category-2"> <span class="ltabs-tab-label">Electronics		</span> </li>
								<li class="ltabs-tab " data-category-id="3" data-active-content=".items-category-3"> <span class="ltabs-tab-label">Sports &amp; Outdoors	</span> </li>
							</ul>
						</div>
					</div>
					<!-- End Tabs-->
				</div>
				<div class="ltabs-items-container">
					<!--Begin Items-->
					<div class="ltabs-items  ltabs-items-selected items-category-1 grid" data-total="10">
						<div class="ltabs-items-inner ltabs-slider ">
							
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/Q1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/Q2.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">曲奇饼干</a></h4>		
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
												<span class="price-new">$97.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/W1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/L2.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">乐事</a></h4>		
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
												<span class="price-new">$97.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/B5.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/m2.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">回头客面包</a></h4>		
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
												<span class="price-new">$65.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>	
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/k1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/k2.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">雀巢咖啡</a></h4>		
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
												<span class="price-new">$50.00</span> 
												<span class="price-old">$62.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/m1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/m3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--New Label-->
										<span class="label label-new">New</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Cisi Chicken	</a></h4>		
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
												<span class="price-new">$59.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
						</div>
						
					</div>
					<div class="ltabs-items  items-category-2 grid" data-total="11">
						
						<div class="ltabs-items-inner ltabs-slider ">
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/e11.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/E3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Apple Cinema 30"</a></h4>		
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
												<span class="price-new">$50.00</span> 
												<span class="price-old">$62.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/141.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/11.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html"> Canon EOS 5D</a></h4>		
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
												<span class="price-new">$60.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/35.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/34.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Filet Mign</a></h4>		
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
												<span class="price-new">$97.00</span> 
												<span class="price-old">$122.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/E3_1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/E3_3.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">HP LP3065</a></h4>		
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
												<span class="price-new">$60.00</span> 
												<span class="price-old">$100.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							
						</div>
						
					</div>
					<div class="ltabs-items items-category-3 grid" data-total="11">
						<div class="ltabs-items-inner ltabs-slider ">
							
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/141.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/11.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html"> Dail Lulpa</a></h4>		
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
												<span class="price-new">$78.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/B10.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/B9.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Bint Beef</a></h4>		
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
												<span class="price-new">$97.00</span> 
												<span class="price-old">$122.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/w1.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/w10.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										<!--Sale Label-->
										<span class="label label-sale">Sale</span>
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Beef Bint</a></h4>		
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
												<span class="price-new">$90.00</span> 
												<span class="price-old">$100.00</span>		 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>
							<div class="ltabs-item product-layout">
								<div class="product-item-container">
									<div class="left-block">
										<div class="product-image-container second_img ">
											<img src="image/demo/shop/product/B5.jpg"  alt="Apple Cinema 30&quot;" class="img-responsive" />
											<img src="image/demo/shop/product/B10.jpg"  alt="Apple Cinema 30&quot;" class="img_0 img-responsive" />
										</div>
										
										<!--full quick view block-->
										<a class="quickview iframe-link visible-lg" data-fancybox-type="iframe"  href="#">  快速预览</a>
										<!--end full quick view block-->
									</div>
									<div class="right-block">
										<div class="caption">
											<h4><a target="_blank" href="product.html">Bint Beef</a></h4>		
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
												<span class="price-new">$97.00</span> 
											</div>
										</div>
										
										  <div class="button-group">
											<button class="addToCart" type="button" data-toggle="tooltip" title="Add to Cart" onClick="cart.add('42', '1');"><i class="fa fa-shopping-cart"></i> <span class="">Add to Cart</span></button>
											<button class="wishlist" type="button" data-toggle="tooltip" title="Add to Wish List" onClick="wishlist.add('42');"><i class="fa fa-heart"></i></button>
											<button class="compare" type="button" data-toggle="tooltip" title="Compare this Product" onClick="compare.add('42');"><i class="fa fa-exchange"></i></button>
										  </div>
									</div><!-- right block -->
								</div>
							</div>	
						</div>
						
					</div>
				</div>
				<!--End Items-->
				
				
			</div>
			
		</div>
	</div>
	
	<div class="module no-margin titleLine ">
		<h3 class="modtitle">COLLECTIONS</h3>
		<div class="modcontent clearfix">
			<div id="collections_block" class="clearfix  block">
				<ul class="width6">
					<li class="collect collection_0">
						<div class="color_co"><a href="#">Furniture</a> </div>
					</li>
					<li class="collect collection_1">
						<div class="color_co"><a href="#">Gift idea</a> </div>
					</li>
					<li class="collect collection_2">
						<div class="color_co"><a href="#">Cool gadgets</a> </div>
					</li>
					<li class="collect collection_3">
						<div class="color_co"><a href="#">Outdoor activities</a> </div>
					</li>
					<li class="collect collection_4">
						<div class="color_co"><a href="#">Accessories for</a> </div>
					</li>
					<li class="collect collection_5">
						<div class="color_co"><a href="#">Women world</a> </div>
					</li>
				</ul>
			</div>
		</div>
	</div>
		
	</div>
</div>
</div>
	<!-- //Main Container -->
	<!-- Block Spotlight3  -->
	<section class="so-spotlight3">
		<div class="container">
			<div class="row">
				
				<div id="so_categories_173761471880018" class="so-categories module titleLine preset01-4 preset02-3 preset03-3 preset04-1 preset05-1">
					<h3 class="modtitle">Hot Categories</h3>
					
					<div class="wrap-categories">
						<div class="cat-wrap theme3">
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/automotive-motocrycle.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 								
								</div>
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Automotive " target="_blank">Automotive</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">More Car Accessories		</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Car Alarms and Security		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Car Audio &amp; Speakers		</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Gadgets &amp; Auto Parts	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/health-beauty.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Health & Beauty</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Salon & Spa Equipment		</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Fragrances		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Shaving & Hair Removal..	</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Bath & Body	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr2"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/bags-holiday-supplies-gifts.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Bags, Holiday Supplies</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Gift & Lifestyle Gadgets..		</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Lighter & Cigar Supplies..		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Gift for Woman	</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Gift for Man	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr3"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/toys-hobbies.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Toys & Hobbies</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Helicopters & Parts		</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">RC Cars & Parts	</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">FPV System & Parts	</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Walkera	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr2 clr4"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/electronics.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Electronics</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Home Audio</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Mp3 Players & Accessories..	</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Headphones, Headsets</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Battereries & Chargers..	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr5"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/jewelry-watches.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Jewelry & Watches</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Men Watches	</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Wedding Rings		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Earings	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr2 clr3 clr6"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/sports-outdoors.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Sports & Outdoors</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Outdoor & Traveling	</a> </div>
										<div class="child-cat-title"> <a title="Car Alarms and Security" href="#" target="_blank">Camping & Hiking		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Golf Supplies	</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Fishing	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1"></div>
							<div class="content-box">
								<div class="image-cat">
									<a href="#" title="Automotive" target="_blank">
										<img  src="image/demo/shop/category/smartphone-tablets.jpg" title="Automotive" alt="Automotive"> 
									</a> 
									<a class="btn-viewmore hidden-xs" href="#" title="View more">View more</a> 		
								</div>	
									
								<div class="inner">
									<div class="title-cat"> <a href="#" title="Health & Beauty" target="_blank">Smartphone & Tablets</a> </div>
									<div class="child-cat">
										<div class="child-cat-title"> <a title="More Car Accessories" href="#" target="_blank">Accessories for iPhone		</a> </div>
										<div class="child-cat-title"> <a title="Car Audio &amp; Speakers" href="#" target="_blank">Accessories for i Pad	</a> </div>
										<div class="child-cat-title"> <a title="Gadgets &amp; Auto Parts" href="#" target="_blank">Accessories for Tablet PC	</a> </div>
									</div>
								</div>
							</div>
							<div class="clr1 clr2 clr4"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- //Block Spotlight3  -->
<script type="text/javascript"><!--
	var $typeheader = 'header-home1';
	//-->
</script>

	<!-- Footer Container 底部容器-->
		<footer class="footer-container bg_bottom" id="footer">
			<!-- Footer Top Container -->
			<section class="footer-top">
				<div class="container content">
					<div class="row">
						<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 box-information">
							<div class="module clearfix">
								<h3 class="modtitle">信息</h3>
								<div class="modcontent">
									<ul class="menu">
										<li><a href="#">关于我们</a></li>
										<li><a href="#">常问问题</a></li>
										<li><a href="#">订单历史</a></li>
										<li><a href="#">订单信息</a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 box-service">
							<div class="module clearfix">
								<h3 class="modtitle">客户服务</h3>
								<div class="modcontent">
									<ul class="menu">
										<li><a href="#">联系我们</a></li>
										<li><a href="#">反馈</a></li>
										<li><a href="#">网站导航</a></li>
										<li><a href="#">我的账户</a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 box-account">
							<div class="module clearfix">
								<h3 class="modtitle">网站介绍</h3>
								<div class="modcontent">
									<ul class="menu">
										<li><a href="#">品牌</a></li>
										<li><a href="#">礼券</a></li>
										<li><a href="#">关联公司</a></li>
										<li><a href="#">特价</a></li>
										<li><a href="#" target="_blank">我们的博客</a></li>
									</ul>
								</div>
							</div>
						</div>

						<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 collapsed-block ">
							<div class="module clearfix">
								<h3 class="modtitle">联系我们</h3>
								<div class="modcontent">
									<ul class="contact-address">
										<li><span class="fa fa-map-marker"></span> 团队, 北京理工大学珠海学院14软3淘丁丁小组</li>
										<li><span class="fa fa-envelope-o"></span> Email: <a href="#"> 2234583424@qq.com</a></li>
										<li><span class="fa fa-phone">&nbsp;</span> Phone 1: 13160675826 <br>Phone 2: 13160675826</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- /Footer Top Container -->

			<!-- Footer Bottom Container -->
			<div class="footer-bottom-block bg_menu">
				<div class=" container">
					<div class="row">
						<div class="col-sm-12 copyright-text" style="text-align: center;">版权 &copy; 2017.淘丁丁小组 版权所有者.</div>
						<!--Back To Top-->
						<div class="back-to-top">
							<i class="fa fa-angle-up"></i><span> Top </span>
						</div>

					</div>
				</div>
			</div>
			<!-- /Footer Bottom Container -->
		</footer>
		<!-- //End Footer Container结束底部容器 -->

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
<script type="text/javascript" src="js/themejs/application.js"></script>
<script type="text/javascript" src="js/themejs/toppanel.js"></script>
<script type="text/javascript" src="js/themejs/so_megamenu.js"></script>
<script type="text/javascript" src="js/themejs/addtocart.js"></script>	
<script type="text/javascript" src="js/themejs/cpanel.js"></script>
</body>
</html>