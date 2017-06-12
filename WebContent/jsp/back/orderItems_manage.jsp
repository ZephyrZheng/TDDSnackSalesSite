<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据管理</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/orderItems_manage.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="http://www.jeasyui.net/Public/js/easyui/demo/demo.css">
	
<!-- 设置只读文本框样式。已在DataManage设置 -->
<!-- <style type="text/css">
    .textbox-readonly .textbox-text{
        color:#7b7b7b;
        background: #e0e0e0;
    }
</style> -->
</head>
<body>
	<!-- 管理表格 -->
	<div class="table-responsive">
		<table id="ori_dg" class="easyui-datagrid" title="订单项管理"
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
                          url: '${ pageContext.request.contextPath }/orderItems_findByPage.action',
                          method: 'get',
                          onClickRow: onClickRow">
			<thead>
				<tr>
					<!-- 各列 -->
					<!-- 自增主键隐藏 -->
					<th data-options="field:'ori_id',align:'center',hidden:'true'">订单项ID</th>
					<!-- Todo .....$#%#$% 排序( sortable:true) -->
					<th data-options="field:'ord_username',align:'center', width:'12%', 
						formatter:function(value,row){
							value = row.orders.user.user_name; 
							return value; 
						}" >订单用户</th>
					<th data-options="field:'orders',align:'center', width:'13%', 
						formatter:function(value,row){
							value = row.orders.ord_number; 
							return value; 
						}">所属订单号</th>	
					<th data-options="field:'goods_id',align:'center',width:'4%',sortable:true">商品id</th>
					
					<%-- <th data-options="url: '${ pageContext.request.contextPath }/orders_findById.action',
						field:'goods_name',align:'center',width:'30%'">商品名称</th> --%>
					
					<th data-options="field:'goods_num',align:'center',width:'8%',sortable:true">商品项数量</th>
					<th data-options="field:'rec_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='已签收'
								}else if(value=='0'){
									value='未签收';
								}
								return value;
							}">签收状态</th>
					<!-- <th data-options="field:'ori_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='已确认'
								}else if(value=='0'){
									value='未确认';
								}else if(value=='N'){
									value='取消';
								}
								return value;
							}">订单项状态</th>
					<th data-options="field:'pay_state',align:'center',width:'8%',sortable:true,
						formatter:function(value,row){
								if(value=='1'){
									value='已支付'
								}else if(value=='0'){
									value='未支付';
								}
								return value;
							}">订单项状态</th> -->
					<th data-options="field:'ord_createtime',align:'center', width:'12%', 
						formatter:function(value,row){
							value = row.orders.ord_createtime; 
							return value; 
						}">创建时间</th>
					<th data-options="field:'ori_passway',align:'center',width:'10%',sortable:true">物流方式</th>	
				</tr>
			</thead>
		</table>

		<!-- 工具栏 -->
		<div id="tb" style="height:auto">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true" onclick="ori_removeit()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="ori_update()">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true" onclick="ori_refresh()">刷新</a>
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
							ori_search();
						}else{
							alert('请输入用户名');	
						}
						
					}
				}]
			">			
			<!-- <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true"
				 onclick="doSearch()">搜索</a> -->
		</div>

		<!-- 订单编辑框 -->
		<div id="ori_adddiv" class="easyui-window" minimizable="false" maximizable="false" 
				collapsible="false" title="修改订单" modal="true" closed="true" style="width:400px">
			<div style="padding:10px 60px 20px 60px">
			    <form id="ori_add_form" class="easyui-form" method="post" data-options="novalidate:true"
			    	action="${ pageContext.request.contextPath }/orderItems_update.action">
			    	<table cellpadding="5">
			    		<!-- 隐藏的主键,传给action执行CURD-->
			    		<tr hidden="true">
			    			<td>主键:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="ori_id" name="ori_id"></input></td>
			    		</tr>
			    		<tr hidden="true">
			    			<!-- 传给action更新对应订单 -->
			    			<td>订单外键:</td> 
			    			<td><input id="ori_ord_id" class="easyui-textbox" name="ord_id" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<!-- 不加name不提交 -->
			    			<td>所属订单号:</td> 
			    			<td><input id="ori_ord_num" class="easyui-textbox" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品id:</td> 
			    			<td><input id="ori_goods_id" class="easyui-textbox" name="goods_id" readonly="true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品数量:</td>
			    			<td><input class="easyui-textbox" id="ori_goods_num" name="goods_num"></input></td>
			    		</tr>
			    		<tr>
			    			<td>签收状态:</td>
			    			<td>
								<select class="easyui-combobox" panelHeight="auto" 
			    					id="ori_rec_state" name="rec_state" style="width:90px;">
									<option value="0">未签收</option>
									<option value="1">已签收</option>
								</select>
							</td>
			    		</tr>
			    		<!-- <tr>
			    			<td>订单项状态:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					id="ori_state" name="ori_state" style="width:80px;">
									<option value="0">未确认</option>
									<option value="1">已确认</option>
									<option value="N">取消</option>
								</select>
							</td>
			    		</tr> -->
			    		<!-- <tr>
			    			<td>支付状态:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					id="pay_state" name="pay_state" style="width:80px;">
									<option value="0">未支付</option>
									<option value="1">已支付</option>
								</select>
							</td>
			    		</tr> -->
			    		<tr>
			    			<td>物流方式:</td>
			    			<td><input class="easyui-textbox" type="text" id="ori_passway" 
			    				name="ori_passway" ></input></td>
			    		</tr>
			    	</table>
			    </form>
			    <div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="ori_submitForm()">提交</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="ori_cancel()">取消</a>
			    </div>
		    </div>
		</div>

	</div>
	
	
	<!-- 确认删除框 -->
	<div id="ori_dlg" class="easyui-dialog" title="确认框" closed="true"
		style="width: 250px; height: 130px; padding: 10px"
		data-options="
	 					iconCls: 'icon-save',					
	 					buttons: [{
	 						text:'确认',
	 						iconCls:'icon-ok',
	 						handler:function(){							
	 							ori_deleteRow();
	 							$('#ori_dlg').dialog('close');
	 						} 
	 					},{
	 						text:'取消',
	 						handler:function(){
	 							$('#ori_dlg').dialog('close');
	 						}
	 					}]
	 				">
		是否删除该订单项？
	</div>

</body>
</html>

