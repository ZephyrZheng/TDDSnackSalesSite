<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<!-- Basic page needs基本页面需求
	   ============================================ -->
	<title>购物车界面</title>
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

	<!-- =======================================购物车页面======================================== -->
	<link href="css/shopcar.css" rel="stylesheet">
	<script src="js/shopcar.js"></script>
	<script type="text/javascript">
		//Session获取用户 / 购物车列表
		var u_name ="<%=session.getAttribute("User_name")%>";
        var u_id ="<%=session.getAttribute("User_id")%>";
        var shopCar = "<%=session.getAttribute("ShopcarList")%>";


        $().ready(function(){
            //登陆框初始化
            login_dialog_init();

            //页面初始化基本设置
            page_setting_init();

			//状态判断并调用方法(包含页面列表加载)
            state_judge();

            //iCheck初始化
            iCheck_init();

            //加载分页，并显示
            loading_page();

            //页面加载动作初始化
            page_loading_animation_init();

            console.log("页面加载");

        });
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
				<li class="bg2 navbar_menu_item actions1"><a target="_blank" href="<%=basePath %>jsp/front/orders.jsp">我的订单 <span class="sr-only">(current)</span></a></li>
				<li class="bg2 navbar_menu_item actions1"><a target="_blank" href="<%=basePath %>jsp/front/shopcar.jsp">我的购物车 <span class="sr-only">(current)</span></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a id="account_button" href="#" class="dropdown-toggle bg3 account_button" data-toggle="dropdown"aria-haspopup="true" aria-expanded="false">我的账户</a>
				</li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</div><!-- /.container-fluid -->
</nav>

<!-- Main Container 主容器 -->
<div class="main-container container-fluid" id="mainer">
	<div class="row">
		<div id="content" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<table class="order_show" id="product_show">
				<!-- 列表头部菜单 -->
				<tr>
					<td class="order_show_check_all">
						<div class="order_show_check_all_left">
							<span>
								<input type="checkbox" name="checkall"
									   id="checkall">&nbsp;&nbsp;全选
							</span>
							<span>
								<button class="btn btn-danger btn-xs" id="batch_delete_button">批量删除</button>
							</span>
						</div>
						<div class="order_show_check_all_right">
							<div class="price_total_div">已选商品(不含运费)：&nbsp;&nbsp;&nbsp;&nbsp;<span class="price_total">0￥</span>
							</div>

							<button  class="btn btn-success btn-xs" id="create_order_button">￥ 生成订单</button>
							</span>
						</div>
					</td>
				</tr>
				<!-- 列表头部列名显示 -->
				<tr>
					<td>
						<table class="list_item_table list_item_table_heander bg5">
							<tr>
								<td class="product_item_show">商品</td>
								<td class="product_item_price">单价</td>
								<td class="product_item_quantity">数量</td>
								<td class="product_total_price">总额</td>
								<td class="product_transaction_operation">商品操作</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- 列表项 -->
				<tr id="remind_tr">
					<td>
						<div class="remind_div bg8">
							<h5>您未登录或登录失效&nbsp;&nbsp;o_O</h5>
						</div>
					</td>
				</tr>
				<tr id="loading_tr">
					<td>
						<img src="image/bg/loading.gif">
					</td>
				</tr>
<%--<tr>--%>
	<%--<td>--%>
		<%--<table class="list_item_table bg5 actions1">--%>
			<%--<tr>--%>
				<%--<td class="product_item_show">--%>
					<%--<div class="product_item_show_left">--%>
						<%--<input type="checkbox" name="check_item">--%>
						<%--<img src="image/bg/10.jpg" class="list_img">--%>
					<%--</div>--%>
					<%--<div class="product_item_show_right">--%>
						<%--<ul>--%>
							<%--<li>请登录</li>--%>
							<%--<li>商品状态：<span>未知</span></li>--%>
						<%--</ul>--%>
					<%--</div>--%>
				<%--</td>--%>
				<%--<td class="product_item_price"><span>0￥</span></td>--%>
				<%--<td class="product_item_quantity"><span>0</span></td>--%>
				<%--<td class="product_total_price"><span><b>0￥</b></span></td>--%>
				<%--<td class="product_transaction_operation">--%>
					<%--<button class="btn btn-danger btn-xs product_delete_button">删除</button>--%>
				<%--</td>--%>
			<%--</tr>--%>
		<%--</table>--%>
	<%--</td>--%>
<%--</tr>--%>
<%--<tr>--%>
	<%--<td>--%>
		<%--<table class="list_item_table bg5 actions1">--%>
			<%--<tr>--%>
				<%--<td class="product_item_show">--%>
					<%--<div>--%>
						<%--<span class="font_ban glyphicon glyphicon-ban-circle" aria-hidden="true"></span>--%>
						<%--<img src="image/bg/10.jpg" class="list_img">--%>
						<%--<div class="product_item_show_text">--%>
							<%--<span>请登录</span><br>--%>
							<%--<span>商品状态：</span>--%>
							<%--<span class="font_red2">无效</span>--%>
						<%--</div>--%>
					<%--</div>--%>
				<%--</td>--%>
				<%--<td class="product_item_price"><span>0￥</span></td>--%>
				<%--<td class="product_item_quantity"><span>0</span></td>--%>
				<%--<td class="product_total_price"><span><b>0￥</b></span></td>--%>
				<%--<td class="product_transaction_operation">--%>
					<%--<button class="btn btn-default btn-xs product_delete_button">删除</button>--%>
				<%--</td>--%>
			<%--</tr>--%>
		<%--</table>--%>
	<%--</td>--%>
<%--</tr>--%>
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
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" id="close_login">
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