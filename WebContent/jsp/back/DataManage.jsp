<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>淘丁丁后台数据管理</title>
<!-- 官方库过时，https://www.jeasyui.com/forum/index.php?topic=5920.0 修复折叠bug
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script> -->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>


<script type="text/javascript" src="https://cdn.insdep.com/themes/1.0.0/jquery.insdep-extend.min.js"></script>
<!-- 各表函数库 -->
<script type="text/javascript" src="js/goods_manage.js"></script>
<script type="text/javascript" src="js/user_manage.js"></script>
<script type="text/javascript" src="js/orders_manage.js"></script>
<script type="text/javascript" src="js/orderItems_manage.js"></script>
<script type="text/javascript" src="js/shopCar_manage.js"></script>
<!-- 文件上传 -->
<style type="text/css">@import url(/tdd/jsp/back/js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css);</style>
<script type="text/javascript" src="js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="js/plupload/i18n/zh_CN.js"></script>

	
<link href="https://cdn.insdep.com/themes/1.0.0/easyui.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/easyui_animation.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/easyui_plus.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/icon.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/demo/demo.css">
	
<!-- 设置只读文本框样式 -->
<style type="text/css">
    .textbox-readonly .textbox-text{
        color:#7b7b7b;
        background: #e0e0e0;
    }
</style>
</head>
<body id="bdy" class="easyui-layout">
	<!-- <div data-options="region:'north',border:false" style="height:60px;background:#B3DFDA;padding:10px">north region</div> 
	<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
	<div data-options="region:'south',border:false" style="height:50px;background:#A9FACD;padding:10px;">south region</div>-->
	<!-- 侧边栏  参考http://www.jianshu.com/p/2c1fb01583c7 -->
	<div data-options="region:'west',split:true,title:'菜单栏'" style="width:150px;padding:0px;">
		<a href="javascript:void(0)" onclick="loadCenter('goods_manage.jsp')">商品管理</a><br><br>
        <a href="javascript:void(0)" onclick="loadCenter('user_manage.jsp')">用户管理</a><br><br>
        <a href="javascript:void(0)" onclick="loadCenter('orders_manage.jsp')">订单管理</a><br><br>
        <a href="javascript:void(0)" onclick="loadCenter('orderItems_manage.jsp')">订单项管理</a><br><br>
        <a href="javascript:void(0)" onclick="loadCenter('shopCar_manage.jsp')">购物车管理</a><br><br>
     </div>
    <!-- 主显 -->
	<div id="main" data-options="region:'center',href:'t.jsp'">
	</div>
</body>
<script type="text/javascript">

function loadCenter(url){
	$('#bdy').layout('collapse','west');
    var center = $("body").layout('panel','center');//获取center的panel
    center.panel('refresh',url);//更新panel的href
}

function test(){
	alert("#$");
}
</script>

</html>