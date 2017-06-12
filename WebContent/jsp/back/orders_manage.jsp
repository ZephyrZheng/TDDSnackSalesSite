<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据管理</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/orders_manage.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/demo/demo.css">
</head>
<body>
	<!-- 管理表格 -->
	<div class="table-responsive">
		<table id="or_dg" class="easyui-datagrid" title="订单管理"
			style="width: 100%; height: auto" sortOrder="asc" remoteSort="false"
			data-options="
                          loadMsg: '正在加载，请稍候...',
                          rownumbers:true,
                          pagination:true,
                          pageList: [10, 50, 100],
                          striped: true, 
                          iconCls: 'icon-edit',
                          singleSelect: true,
                          toolbar: '#tb',
                          url: '${ pageContext.request.contextPath }/orders_findByPage.action',
                          method: 'get',
                          onClickRow: onClickRow">
			<thead>
				<tr>
					<!-- 各列 -->
					<!-- 自增主键隐藏 -->
					<th data-options="field:'ord_id',align:'center',hidden:'true'">订单ID</th>
					<th data-options="field:'user_id',align:'center', width:'10%',sortable:true,
						formatter:function(value,row){
							return row.user.user_id;
						}">用户id</th>
					<th data-options="field:'user_name',align:'center', width:'12%',
						formatter:function(value,row){
							return row.user.user_name;
						}">用户名</th>
					<th data-options="field:'ord_number',align:'center',width:'23%',sortable:true">订单号</th>
					<th data-options="field:'ord_createtime',align:'center',width:'18%'">创建时间</th>
					
					<th data-options="field:'ord_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='已确认'
								}else if(value=='0'){
									value='未确认';
								}
								return value;
							}">订单状态</th>
					<th data-options="field:'pay_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='已支付'
								}else if(value=='0'){
									value='未支付';
								}
								return value;
							}">支付状态</th>
					<th data-options="field:'ord_address',align:'left',width:'30%'">收货地址</th>							
					<th data-options="field:'ord_note',align:'left',width:'5%'">备注</th>
				</tr>
			</thead>
		</table>

		<!-- 工具栏 -->
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true" onclick="ord_removeit()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="ord_update()">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true" onclick="ord_refresh()">刷新</a>
		</div>

		<!-- 订单编辑框 -->
		<div id="ord_adddiv" class="easyui-window" minimizable="false" maximizable="false" 
				collapsible="false" title="修改订单" modal="true" closed="true" style="width:400px">
			<div style="padding:10px 60px 20px 60px">
			    <form id="ord_add_form" class="easyui-form" method="post" data-options="novalidate:true"
			    	action="${ pageContext.request.contextPath }/orders_update.action">
			    	<table cellpadding="5">
			    		<!-- 隐藏的主键,传给action执行CURD-->
			    		<tr hidden="true">
			    			<td>主键:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="ord_id" name="ord_id"></input></td>
			    		</tr>
			    		<tr>
			    			<td>用户id:</td> 
			    			<td><input id="ord_u_id" class="easyui-textbox" name="u_id" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>用户名:</td> <!-- 不加name属性，disable不提交  -->
			    			<td><input id="ord_u_name" class="easyui-textbox" disabled="disabled"></input></td>
			    		</tr>
			    		<tr>
			    			<td>订单编号:</td>
			    			<td><input class="easyui-textbox" id="ord_number" readonly="true" name="ord_number"></input></td>
			    		</tr>
			    		<tr>
			    			<td>创建时间:</td>
			    			<td><input class="easyui-textbox" type="text" readonly="true" 
			    				id="cretime" name="ord_createtime" >
								</input>
							</td>
			    		</tr>
			    		<tr>
			    			<td>订单状态:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					name="ord_state" id="ord_state" style="width:80px;">
									<option value="0">未确认</option>
									<option value="1">已确认</option>									
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td>订单支付状态:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					name="pay_state" id="pay_state" style="width:80px;">
									<option value="0">未支付</option>
									<option value="1">已支付</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td>收货地址:</td>
			    			<td><input class="easyui-textbox" type="text" id="ord_address" 
			    				name="ord_address" ></input></td>
			    		</tr>
			    		<tr>
			    			<td>备注:</td>
			    			<td><input class="easyui-textbox" type="text" id="note" 
			    				name="ord_note" ></input></td>
			    		</tr>
			    	</table>
			    </form>
			    <div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="ord_submitForm()">提交</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="ord_cancel()">取消</a>
			    </div>
		    </div>
		</div>

	</div>
	
	
	<!-- 确认删除框 -->
	<div id="ord_dlg" class="easyui-dialog" title="确认框" closed="true"
		style="width: 250px; height: 130px; padding: 10px"
		data-options="
	 					iconCls: 'icon-save',					
	 					buttons: [{
	 						text:'确认',
	 						iconCls:'icon-ok',
	 						handler:function(){							
	 							ord_deleteRow();
	 							$('#ord_dlg').dialog('close');
	 						} 
	 					},{
	 						text:'取消',
	 						handler:function(){
	 							$('#ord_dlg').dialog('close');
	 						}
	 					}]
	 				">
		是否删除该订单？
	</div>

</body>
</html>

