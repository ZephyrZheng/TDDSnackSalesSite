<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>订单页面</title>

<!-- 确保适当的绘制和触屏缩放，需要在 <head> 之中添加 viewport 元数据标签 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- ==========================jQuery （当前版本 3.2.1）========================== -->
<script src="https://cdn.bootcss.com/jquery/3.2.1/core.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

<!-- ==========================jqueryui （当前版本 1.12.1）========================== -->
<link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.structure.min.css" rel="stylesheet">
<link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.theme.min.css" rel="stylesheet">

<!-- ==========================Bootstrap （当前版本 v3.3.7）========================== -->
<!-- Bootstrap 核心 CSS 文件 -->
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- ==========================flat-ui （当前版本 2.3.0）========================== -->
<link href="https://cdn.bootcss.com/flat-ui/2.3.0/css/flat-ui.min.css" rel="stylesheet">

<!-- ==========================animate.css （当前版本 3.5.2）========================== -->
<link href="https://cdn.bootcss.com/animate.css/3.5.2/animate.min.css" rel="stylesheet">

<!-- ==========================Font Awesome （当前版本 4.7.0）========================== -->
<link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<!-- ==========================headroom （当前版本 0.9.3）========================== -->
<script src="https://cdn.bootcss.com/headroom/0.9.3/angular.headroom.js"></script>
<script src="https://cdn.bootcss.com/headroom/0.9.3/headroom.js"></script>
<script src="https://cdn.bootcss.com/headroom/0.9.3/jQuery.headroom.js"></script>

<!-- ==========================iCheck （当前版本 1.0.2）========================== -->
<link href="https://cdn.bootcss.com/iCheck/1.0.2/skins/flat/_all.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/iCheck/1.0.2/icheck.min.js"></script>


<!-- ==========================jQuery validation （当前版本 1.16.0）========================== -->
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.js"></script>

<!-- =======================================登录对话框======================================== -->
<link href="css/login_dialog.css" rel="stylesheet">
<script src="js/login_dialog.js"></script>	

<!-- =======================================订单页面======================================== -->
<link href="css/order.css" rel="stylesheet">
<script src="js/order.js"></script>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=RY5GGXORK1W2Kiro1p71IFNH7VrVtG9O"></script>

<script type="text/javascript">
var check = 0;

//Session获取用户 / 购物车列表
var u_name ="<%=session.getAttribute("User_name")%>";
var u_id ="<%=session.getAttribute("User_id")%>"; 
var orderlist = "<%=session.getAttribute("OrderList")%>";       	

$().ready(function(){

	//部件初始化
	// Order_init();

	//返回顶部小部件初始化方法
	back_to_top_init();	

	//订单菜单初始化
	order_menu_init();

	//登录对话框初始化
	login_dialog_init();
	

	//进入页面判断用户是否登录
	if(u_name!=null && u_name!="null"){
		document.getElementById("my_account").innerHTML = "欢迎你，"+u_name;
		//alert(u_name);
		$('#my_account').removeAttr('onclick');
		if (orderlist=="1") {
			//alert("订单有数据");
			//Todo..请求返回订单
			var Orders = [];
			var OrderItems = [];
			var url = '${ pageContext.request.contextPath }/user_getOrders.action?user_id='
				+u_id;
			//订单查询条件（默认未确认）
			Order_Q = "Unconfirmed";
			var param = { Order_Q : Order_Q };
			$.post(url,param,function(data){
				var order_list = data.OrderList;
				//排序
				order_list = order_list.sort(function(a,b){
					return a["ord_id"]>b["ord_id"]?1:-1
				});
				for (var i = 0; i < order_list.length; i++) {					
					//alert(order_list[i].ord_id);
					insert_ordRow(order_list[i].ord_id, order_list[i].ord_number, order_list[i].ord_createtime, order_list[i].user.user_address);
					//todo..获取订单项传入插入
					GetOrderItem(order_list[i].ord_id,order_list[i].ord_address);
				};
				//Order_init();
				window.setTimeout( 
					function(){
						Order_init();
					}, 
					3000
				);				
			});			

			$.ajax({
				type: "POST",
				url: url,
				data: { Order_Q : Order_Q },
				contentType: "application/x-www-form-urlencoded; charset=utf-8",
				success: function (REsult) {

				Order_init();

				}
			});

		}else{
			alert("没有订单...");			
			//初始化订单控件
			Order_init();
		}

	}else{
		show_login();
	}

	page_setting_iniit();

	//页面加载动作初始化
	page_loading_animation_init();
	//setTimeout("functionOrder_init()",5000);
});

function Order_init(){
	//alert("控件初始化");
	//iCheck初始化
	iCheck_init();

	//按钮事件初始化
	button_init();

	//地址修改初始化
	address_change_init();
}

</script>
</head>
<body class="bg4">
	<!-- 导航栏 -->
	<nav class="navbar navbar-inverse navbar-fixed-top bg1 top_navbar headroom" data-headroom id="header">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">切换导航</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bar_menu_list">
				<ul class="nav navbar-nav">
					<li class="bg2 navbar_menu_item actions1"><a href="#">主页</a></li>
					<li class="bg2 navbar_menu_item actions1"><a href="#">我的购物车</a></li>
					<li class="bg2 navbar_menu_item actions1"><a href="#">个人中心</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" id="my_account" class="dropdown-toggle account_button bg3" data-toggle="dropdown"aria-haspopup="true" aria-expanded="false" onclick="show_login()">我的账户</a>
					</li>
				</ul>
			</div><!-- /.navbar-collapse -->
		</div><!-- /.container-fluid -->
	</nav>

	<!-- 主容器 -->
	<div class="container-fluid" id="mainer">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<table class="order_show">
					<tbody id="ordertb">
						<tr>
							<td class="order_show_check_all">
								<div class="order_show_check_all_left">
									<input type="checkbox" name="checkall" id="checkall">&nbsp;&nbsp;全选

									<button class="btn btn-info btn-xs button2 actions1" id="batch_confirm">
										<span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
										&nbsp;批量确认
									</button>
									<button class="btn btn-danger btn-xs button2 actions1" id="batch_delete">
										<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>
										&nbsp;批量取消
									</button>
								</div>
								<div class="order_show_check_all_right">
									<div class="order_type_menu bg3">
										<button type="button" class="btn btn-info btn-xs button2" id="order_unconfirmed">未确认订单</button>
										<button class="btn btn-info btn-xs button2 active" id="order_confirmed">已确认订单</button>
										<button class="btn btn-info btn-xs button2 active" id="order_finish">已完成订单</button>
									</div>
								</div>
							</td>
						</tr>
						<!-- 列表项 -->
						
						
						


					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Footer Container 底部容器-->
	<footer class="bg7" id="footer"> <!-- Footer Top Container -->
		<section class="footer_top">
			<div class="container content">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
						<div class="module clearfix">
							<h6 class="modtitle">信息</h6>
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

					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
						<div class="module clearfix">
							<h6 class="modtitle">客户服务</h6>
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

					<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
						<div class="module clearfix">
							<h6 class="modtitle">网站介绍</h6>
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
							<h6 class="modtitle">联系我们</h6>
							<div class="modcontent">
								<ul class="contact-address">
									<li><span class="fa fa-map-marker"></span> 团队,
										北京理工大学珠海学院14软3淘丁丁小组</li>
									<li><span class="fa fa-envelope-o"></span> Email: <a
										href="#"> 2234583424@qq.com</a></li>
									<li><span class="fa fa-phone">&nbsp;</span> Phone 1:
										13160675826 <br>Phone 2: 13160675826</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section> <!-- /Footer Top Container --> <!-- Footer Bottom Container -->
		<div class="footer_bottom bg1">
			<div class=" container">
				<div class="row">
					<div class="col-sm-12 bottom_remind"
						style="text-align: center;">版权 &copy; 2017.淘丁丁小组 版权所有者.
					</div>
					<!--返回顶部小部件-->
					<div class="back_to_top">
						<i class="fa fa-angle-up"></i><span> Top </span>
					</div>
				</div>
			</div>
		</div>
	</footer>
	
	<!-- 登录框 -->
	<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="login_title" id="login_modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<span class="modal-title" id="login_title">请您先登录&nbsp;&nbsp;^.^</span> 
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<form id="login_form" action="" method="post" enctype="multipart/form-data" class="clearfix">
								<div class="form-group required">
									<label for="user_name" class="login_font_big">用户名</label>
									<input type="text" class="form-control" id="user_name" name="user_name" placeholder="输入用户名">
									<div class="alert alert-danger alert-dismissible waring_dialog fade in" role="alert">
										<button type="button" class="close" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<span></span>
									</div>
								</div>
								<div class="form-group required">
									<label for="user_pwd" class="login_font_big">密码</label>
									<input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="输入密码">
									<div class="alert alert-danger alert-dismissible waring_dialog fade in" role="alert">
										<button type="button" class="close" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<span></span>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row">
						<div class="col-md-12">
							<button type="button" class="btn btn-default animation_time" id="register_button">
								<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>
								&nbsp;&nbsp;注册
							</button>
							<button type="button" class="btn btn-default animation_time" id="login_button">
								<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
								&nbsp;&nbsp;登录
							</button>
						</div>
					</div>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
</body>
</html>