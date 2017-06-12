<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<!-- Basic page needs基本页面需求
    ============================================ -->
	<title>用户注册</title>
	<meta charset="utf-8">
	<meta name="keywords" content="" />
	<meta name="author" content="Magentech">
	<meta name="robots" content="index, follow" />

	<!-- Mobile specific metas移动专用元
	============================================ -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

	<!-- Favicon网站图标
	============================================ -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed" href="ico/apple-touch-icon-57-precomposed.png">
	<link rel="shortcut icon" href="ico/favicon.png">

	<!-- Google web fontsGoogle网络字体
	============================================ -->
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>

	<!-- Libs CSS   CSS库
    ============================================ -->
	<link rel="stylesheet" href="css/bootstrap/css/bootstrap.min.css">
	<link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<link href="js/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
	<link href="js/owl-carousel/owl.carousel.css" rel="stylesheet">
	<link href="css/themecss/lib.css" rel="stylesheet">
	<link href="js/jquery-ui/jquery-ui.min.css" rel="stylesheet">

	<!-- Theme CSS  主题库
	============================================ -->
	<link href="css/themecss/so_megamenu.css" rel="stylesheet">
	<link href="css/themecss/so-categories.css" rel="stylesheet">
	<link href="css/themecss/so-listing-tabs.css" rel="stylesheet">
	<link id="color_scheme" href="css/theme.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet">


	<!-- jquery validate js
	============================================ -->
	<!-- <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
	<script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
	<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"></script>
	<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.js"></script>

	<script type="text/javascript">
        //自定义联系电话validate
        jQuery.validator.addMethod("mobile", function(value, element) {
            var length = value.length;
            var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
            return this.optional(element) || (length == 11 && mobile.test(value));
        }, "手机号码格式错误");

        //调用jQuery validate，监控registerDiv form 表单
        $().ready(function(){
            //设置加载页面时，错误提示框隐藏
            $(".error_alert").hide();

            //设置加载页面时，正确提示图标
            $(".true_remind").hide();

            //设置加载页面时，防止主内容容器mainer内容太少底部footer上浮
            $("#mainer").css({"min-height":$(window).height()-292+"px"});

            //点击错误提示框的关闭按钮时的动画
            $(".close_waring").click(function(){
                $(this).parent(".error_alert").fadeOut();
            });

            //定义表单的jquery validate
            $("#registerFrom").validate({
                onfocusout: function(element) {
                    var result = $(element).valid();
                    if (result) {
                        $(element).removeClass("danger_border");
                        $(element).siblings(".error_alert").fadeOut();
                        $(element).siblings(".true_remind").fadeIn();
                    }else {
                        $(element).addClass("danger_border");
                        $(element).siblings(".true_remind").fadeOut();
                        $(element).siblings(".error_alert").fadeIn();
                    }
                },
                onkeyup: function(element) {
                    var result = $(element).valid();
                    if (result) {
                        $(element).removeClass("danger_border");
                        $(element).siblings(".error_alert").fadeOut();
                        $(element).siblings(".true_remind").fadeIn();
                    }else {
                        $(element).addClass("danger_border");
                        $(element).siblings(".true_remind").fadeIn();
                        $(element).siblings(".error_alert").fadeOut();
                    }
                },
                rules:{
                    user_name:{
                        required:true,
                        maxlength:21
                    },
                    user_real_name:{
                        required:true,
                        maxlength:9
                    },
                    user_phone:{
                        required:true,
                        mobile:true,
                        maxlength:11
                    },
                    user_address:{
                        required:true,
                        maxlength:54
                    },
                    user_pwd:{
                        required:true,
                        maxlength:9
                    },
                    user_pwd_check:{
                        required:true,
                        maxlength:9,
                        equalTo:"#user_pwd"
                    }
                },
                messages:{
                    user_name:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;用户名不能为空！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;用户名长度不能超过21位！"
                    },
                    user_real_name:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;真实姓名不能为空！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;真实姓名长度不能超过9位！"
                    },
                    user_phone:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;联系电话不能为空！",
                        mobile:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;联系电话不符合规则！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;联系电话长度不能超过11位！"
                    },
                    user_address:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;地址不能为空！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;地址长度不能超过54位！"
                    },
                    user_pwd:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;密码不能为空！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;密码不能超过9位！"
                    },
                    user_pwd_check:{
                        required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;验证密码不能为空！",
                        maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;验证密码不能超过9位！",
                        equalTo:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;两次输入密码不同！"
                    }
                },
                errorPlacement: function(error, element) {
                    error.appendTo( element.siblings(".error_alert").find(".waring_word"));
                },
                success: function(label) {
                    label.parents(".error_alert"). siblings(".input_item").removeClass("danger_border");
                },
                debug:true
            });

            //register_button提交表单时的click方法
            $("#register_button").click(function(){
                if($('#registerFrom').valid()) {
                    regist();
                }else {
                    $(".input_item").blur();
                }
            });
        });

		$(window).resize(function(){
			//窗口变化时设置  防止主内容容器mainer内容太少底部footer上浮
            $("#mainer").css({"min-height":$(window).height()-292+"px"});
		});

        //注册方法，获取表单value，上交并接收返回值
        function regist(){
            var regist_url = '${ pageContext.request.contextPath }/user_regist.action';
            var regist_user_name = $('#user_name').val();
            var regist_user_real_name = $('#user_real_name').val();
            var regist_pwd = $('#user_pwd').val();
            var regist_user_sex=$('input:radio[name="user_sex"]:checked').val();
            var regist_user_phone = $('#user_phone').val();
            var regist_user_address = $('#user_address').val();
            var regist_pwd_check = $('pwd_check').val();

            var param = {
                user_name:regist_user_name,
                user_real_name:regist_user_real_name,
                user_pwd:regist_pwd,
                user_sex:regist_user_sex,
                user_phone:regist_user_phone,
                user_address:regist_user_address,
                pwd_check:regist_pwd_check
            };
            $.post(regist_url,param,function(regist_return){
                if(regist_return.RegisterState == "1"){
                    alert("注册成功，M_M");
                }else {
                    alert("注册失败，用户名冲突>.<");
                    $("#user_name").addClass("danger_border");
                    $("#user_name").siblings(".error_alert").find(".waring_word").text("出事啦&nbsp;&nbsp;&nbsp;…(⊙_⊙;)…&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户名已存在！");
                    $("#user_name").siblings(".error_alert").showw();
                }
            });
        }
	</script>
	<style>
		.danger_border{
			border:1px solid #ff8e8e;
		}
		.error_alert{
			margin-bottom: 1px;
			height: 30px;
			line-height:30px;
			padding:0px 13px;
		}
		.error_alert button{
			line-height: 30px;
			margin: 0px 20px;
		}
		.true_remind{
			color: #66c950;
		}
		.bg_body{
			background-image: url(image/bg/bg_body.jpg);
			background-repeat: repeat;
		}
		.bg_menu{
			background-image: url(image/bg/bg_menu.jpg);
			background-repeat: repeat;
		}
		.bg_bottom{
			background-image: url(image/bg/bg_bottom.jpg);
			background-repeat: repeat;
		}
		.breadcrumb li{
			background-color: #FFF;
		}
		.height_set{
			height: 30px;
			line-height: 30px;
			font-weight:10;
		}

		/*菜单栏菜单ul样式*/
		.mega_menu{

		}
		ul.megamenu > li > a{
			padding: 10px 0;
			animation:all 2s;
		}
		.mega_menu_item{
			width: 100px;
			text-align: center;
		}
		ul.megamenu > li > a{
			background-image:none;
			background-repeat: repeat;
			transition: background-image 12s;
			-moz-transition: background-image 12s;	/* Firefox 4 */
			-webkit-transition: background-image 12s;	/* Safari 和 Chrome */
			-o-transition: background-image 12s;	/* Opera */
		}
		ul.megamenu > li > a:hover{
			padding: 10px 0;
			background-image: url(image/bg/bg_button_2.jpg);
		}

		.line1{
			border-image: url(image/bg/bg_border_3.png) 7 repeat;
			border-bottom-width: 2px;
		}
		.navbar {
			min-height: 40px;
		}

		#register_button{
			outline:none !important;
			border: none;
			transition: background-color 1s;
		}
	</style>
</head>
<body class="res layout-subpage bg_body">
<div id="wrapper" class="wrapper-full ">
	<!-- Header Container 头部容器  -->
	<header id="header">
		<nav class="navbar navbar-default navbar-fixed-top" style="margin: 0;padding: 0;">
			<div class="container-fluid bg_menu">
				<div class="row">
					<!-- Main menu 主菜单-->
					<div class="responsive so-megamenu col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<nav class="navbar-default">
							<div class="navbar-header">
								<button type="button" id="show-megamenu" class="navbar-toggle">
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
									<span class="icon-bar"></span>
								</button>
								导航
							</div>
							<div class="megamenu-wrapper">
								<span id="remove-megamenu" class="fa fa-times"></span>
								<div class="container">
									<ul class="megamenu" data-transition="slide">
										<li class="mega_menu_item">
											<a href="#">
												主页
											</a>
										</li>
										<li class="mega_menu_item">
											<a href="#">
												<strong>关于我们</strong>
											</a>
										</li>
									</ul>
								</div>
							</div>
						</nav>
					</div>
					<!-- //End Main menu 结束主菜单-->
				</div>
			</div>
		</nav>
	</header>
	<!-- //End Header Container结束头部容器   -->

	<!-- Main Container 主容器 -->
	<div class="main-container container" id="mainer">
		<ul class="breadcrumb">
			<li><a href="#"><i class="fa fa-home"></i></a></li>
			<li><a href="#">账户</a></li>
			<li><a href="#">注册</a></li>
		</ul>
		<div class="row">
			<div id="content" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<h2 class="title">注册账户</h2>
				<p>如果您已经有了我们的帐户，请在<a href="#">主页</a>登录。</p>
				<form id="registerFrom" action="" method="post" enctype="multipart/form-data" class="form-horizontal account-register clearfix">
					<fieldset id="account">
						<legend class="line1">您的个人信息</legend>
						<div class="form-group required" style="display: none;">
							<label class="col-sm-2 control-label">Customer Group</label>
							<div class="col-sm-10">
								<div class="radio">
									<label>
										<input type="radio" name="customer_group_id" value="1" checked="checked"> Default
									</label>
								</div>
							</div>
						</div>

						<!-- 用户名栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_name">用户名</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="text" name="user_name" value="" placeholder="用户名" id="user_name" class="form-control input_item" aria-describedby="user_name_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_name_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>

						<!-- 真实姓名栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_real_name">真实姓名</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="text" name="user_real_name" value="" placeholder="真实姓名" id="user_real_name" class="form-control input_item" aria-describedby="user_real_name_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_real_name_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>

						<!-- 联系电话栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_phone">联系电话</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="tel" name="user_phone" value="" placeholder="联系电话" id="user_phone" class="form-control input_item" aria-describedby="user_phone_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_phone_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="user_sex" value="男" checked="checked"> 男
								</label>
								<label class="radio-inline">
									<input type="radio" name="user_sex" value="女"> 女
								</label>
							</div>
						</div>
					</fieldset>
					<fieldset id="address">
						<legend class="line1">您的地址</legend>

						<!-- 地址栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_address">地址</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="text" name="user_address" value="" placeholder="地址" id="user_address" class="form-control input_item" aria-describedby="user_address_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_address_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>
					</fieldset>
					<fieldset>
						<legend class="line1">您的密码</legend>

						<!-- 密码栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_pwd">密码</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="password" name="user_pwd" value="" placeholder="密码" id="user_pwd" class="form-control input_item" aria-describedby="user_pwd_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_pwd_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>

						<!-- 确认密码栏 -->
						<div class="form-group required">
							<!-- 输入提示栏 -->
							<label class="col-sm-2 control-label" for="user_pwd_check">确认密码</label>

							<!-- input输入栏 -->
							<div class="col-sm-10 has-feedback">
								<!-- 输入框 -->
								<input type="password" name="user_pwd_check" value="" placeholder="确认密码" id="user_pwd_check" class="form-control  input_item" aria-describedby="user_pwd_check_status">

								<!-- 正确提示图标 -->
								<span class="glyphicon glyphicon-ok form-control-feedback true_remind" aria-hidden="true"></span>
								<span id="user_pwd_check_status" class="sr-only">(success)</span>

								<!-- 错误提示框 -->
								<div class="alert alert-danger alert-dismissible error_alert" role="alert">
									<button type="button" class="close close_waring">
										<span aria-hidden="true">&times;</span>
									</button>
									<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
									<span class="waring_word"></span>
								</div>
							</div>
						</div>
					</fieldset>
					<div class="buttons">
						<div class="pull-right">我已经阅读并同意 <a href="#" class="agree"><b>《淘丁丁消费者须知》</b></a>
							<input class="box-checkbox" type="checkbox" name="agree" value="1" checked="checked"> &nbsp;
							<input id="register_button" type="button" value="Register" class="btn btn-primary">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- //End Main Container 结束主容器-->

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
</div>


<!-- Preloading Screen 预加载屏幕-->
<div id="loader-wrapper">
	<div id="loader"></div>
	<div class="loader-section section-left"></div>
	<div class="loader-section section-right"></div>
</div>
<!-- End Preloading Screen 结束预加载屏幕-->

<!-- Include Libs & Plugins  包括库和插件
============================================ -->
<!-- Placed at the end of the document so the pages load faster 放置在文档的末尾，以便页面加载更快-->

<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/owl-carousel/owl.carousel.js"></script>
<script type="text/javascript" src="js/themejs/libs.js"></script>
<script type="text/javascript" src="js/unveil/jquery.unveil.js"></script>
<script type="text/javascript" src="js/countdown/jquery.countdown.min.js"></script>
<script type="text/javascript" src="js/dcjqaccordion/jquery.dcjqaccordion.2.8.min.js"></script>
<script type="text/javascript" src="js/datetimepicker/moment.js"></script>
<script type="text/javascript" src="js/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/jquery-ui/jquery-ui.min.js"></script>


<!-- Theme files  主题文件
============================================ -->
<script type="text/javascript" src="js/themejs/so_megamenu.js"></script>
<script type="text/javascript" src="js/themejs/addtocart.js"></script>
<script type="text/javascript" src="js/themejs/application.js"></script>

</body>
</html>