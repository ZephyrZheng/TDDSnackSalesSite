<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据管理</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/shopCar_manage.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/icon.css">
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
<body>
	<!-- 管理表格 -->
	<div class="table-responsive">
		<table id="sh_dg" class="easyui-datagrid" title="购物车管理"
			style="width: 100%; height: auto" remoteSort="false"
			data-options="
                          loadMsg: '正在加载，请稍候...',
                          rownumbers:true,
                          pagination:true,
                          pageList: [5, 10, 50],
                          striped: true,
                          iconCls: 'icon-edit',
                          singleSelect: true,
                          toolbar: '#tb',
                          url: '${ pageContext.request.contextPath }/ShopCar_findByPage.action',
                          method: 'get',
                          onClickRow: onClickRow">
			<thead>
				<tr>
					<!-- 各列 -->
					<th data-options="field:'user_id',align:'center', width:'12%',sortable:true,
						formatter:function(value,row){
								return row.user.user_id;
							}" >用户id</th>
					<th data-options="field:'user_name',align:'center', width:'12%',sortable:true,
						formatter:function(value,row){
								return row.user.user_name;
							}" >所属用户</th>
					<th data-options="field:'goods_id',align:'center',width:'4%',sortable:true">商品ID</th>
					
					<%-- <th data-options="url: '${ pageContext.request.contextPath }/orders_findById.action',
						field:'goods_name',align:'center',width:'30%'">商品名称</th> --%>
					
					<th data-options="field:'goods_num',align:'center',width:'8%',sortable:true">商品项数量</th>
					<th data-options="field:'car_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='有效'
								}else if(value=='0'){
									value='失效';
								}
								return value;
							}">购物车商品状态</th>
					<th data-options="field:'car_createtime',align:'center', width:'15%',sortable:true">添加时间</th>
					<th data-options="field:'car_id',align:'center'">购物车ID</th>
					<th data-options="field:'car_note',align:'center',width:'20%',sortable:true">备注</th>	
				</tr>
			</thead>
		</table>

		<!-- 工具栏 -->
		<div id="tb" style="height:auto">
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true" onclick="append()">添加</a> -->
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="sh_update()">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true" onclick="sh_refresh()">刷新</a>
			<!-- 搜索框 -->
			<!-- <span style="color:#484891;font-weight:bold">用户名:</span>
			<input id="itemid" style="line-height:26px;border:1px solid #ccc"> -->
			<input id="Search_user" class="easyui-textbox" style="left:20px;width:200px" data-options="
				prompt: '请输入用户名',
				iconWidth: 15,
				icons: [{
					iconCls:'icon-search',
					handler: function(e){
						//Todo..执行搜索
						var v = $(e.data.target).textbox('getValue');
						if(v){
							//alert('你输入：'+v);
							Search();
						}else{
							alert('请输入用户名');	
						}
						
					}
				}]
			">			
		</div>

		<!-- 编辑框 -->
		<div id="sh_adddiv" class="easyui-window" minimizable="false" maximizable="false" 
				collapsible="false" title="修改购物车项" modal="true" closed="true" style="width:400px">
			<div style="padding:10px 60px 20px 60px">
			    <form id="sh_add_form" class="easyui-form" method="post" data-options="novalidate:true"
			    	action="${ pageContext.request.contextPath }/ShopCar_update.action">
			    	<table cellpadding="5">
			    		<!-- 隐藏的主键,传给action执行CURD-->
			    		<tr hidden="true">
			    			<td>主键:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="car_id" name="car_id"></input></td>
			    		</tr>
			    		<tr hidden="true">
			    			<!-- 传给action更新对应订单 -->
			    			<td>用户外键:</td> 
			    			<td><input id="car_u_id" class="easyui-textbox" name="user_id" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品id:</td> 
			    			<td><input id="car_goods_id" class="easyui-textbox" name="goods_id" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品数量:</td>
			    			<td><input class="easyui-textbox" id="car_goods_num" name="goods_num"></input></td>
			    		</tr>
			    		<tr>
			    			<td>加入购物车时间:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="car_createtime" name="car_createtime" >
								</input>
							</td>
			    		</tr>
			    		<tr>
			    			<td>买家收货状态:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					name="car_state" id="car_state" style="width:80px;">
									<option value="0">失效</option>
									<option value="1">有效</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td>备注:</td>
			    			<td><input class="easyui-textbox" type="text" id="car_note" 
			    				name="car_note" ></input></td>
			    		</tr>
			    	</table>
			    </form>
			    <div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="sh_submitForm()">提交</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="sh_cancel()">取消</a>
			    </div>
		    </div>
		</div>

	</div>
	
	
	<!-- 确认删除框 -->
	<div id="sc_dlg" class="easyui-dialog" title="确认框" closed="true"
		style="width: 250px; height: 130px; padding: 10px"
		data-options="
	 					iconCls: 'icon-save',					
	 					buttons: [{
	 						text:'确认',
	 						iconCls:'icon-ok',
	 						handler:function(){							
	 							sh_deleteRow();
	 							$('#sc_dlg').dialog('close');
	 						} 
	 					},{
	 						text:'取消',
	 						handler:function(){
	 							$('#sc_dlg').dialog('close');
	 						}
	 					}]
	 				">
		是否删除该购物车项？
	</div>

</body>
</html>

