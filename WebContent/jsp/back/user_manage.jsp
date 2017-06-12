<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/user_manage.js"></script>
<!-- 引入JQ -->
<%-- <script type="text/javascript" src="${ pageContext.request.contextPath }jsp/back/js/lib/jquery-1.11.3.min.js"></script> --%>
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
		<table id="u_dg" class="easyui-datagrid" title="用户管理"
			style="width: 100%; height: auto"
			data-options="
                          loadMsg: '正在加载，请稍候...',
                          rownumbers:true,
                          pagination:true,
                          pageList: [10, 50, 100],
                          striped: true, 
                          iconCls: 'icon-edit',
                          singleSelect: true,
                          toolbar: '#tb',
                          url: '${ pageContext.request.contextPath }/user_findByPage.action',
                          method: 'get',
                          onClickRow: onClickRow">
			<thead>
				<tr>
					<!-- 各列 -->
					<th data-options="field:'user_id',align:'center',hidden:'true'">用户ID</th>
					<th data-options="field:'user_name',align:'center', width:'15%'">用户名</th>
					<th data-options="field:'user_sex',align:'center',width:'5%'">性别</th>
					<th data-options="field:'user_pwd',align:'center',width:'18%'">密码</th>
					<th data-options="field:'user_real_name',align:'center', width:'12%'">真实姓名</th>
					<th data-options="field:'user_phone',align:'center',width:'15%'">联系方式</th>
					<th data-options="field:'user_address',align:'left',width:'32%'">地址</th>
				</tr>
			</thead>
		</table>

		<!-- 工具栏 -->
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true" onclick="u_append()">添加</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true" onclick="u_removeit()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="u_update()">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true" onclick="u_refresh()">刷新</a>
		</div>

		<!-- 添加用户框 -->
		<div id="u_add-div" class="easyui-window" minimizable="false" maximizable="false" 
				collapsible="false" title="添加用户" modal="true" closed="true" style="width:400px">
			<div style="padding:10px 60px 20px 60px">
			    <form id="u_add_form" class="easyui-form" method="post" data-options="novalidate:true"
			    	action="${ pageContext.request.contextPath }/user_update.action">
			    	<table cellpadding="5">
			    		<!-- 隐藏的主键,传给action执行CURD-->
			    		<tr hidden="true">
			    			<td>主键:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="u_id" name="user_id"></input></td>
			    		</tr>
			    		<tr>
			    			<td>用户名:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="u_name" name="user_name" missingMessage="用户名不能为空" invalidMessage="用户名已存在或无效"
			    				data-options="required:true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>密码:</td>
			    			<td><input class="easyui-textbox" id="pwd" name="user_pwd" data-options="required:true" 
			    				missingMessage="密码不能为空"	></input></td>
			    		</tr>
			    		<tr>
			    			<td>联系方式:</td>
			    			<td><input class="easyui-textbox" type="text" id="phone" 
			    				name="user_phone" ></input></td>
			    		</tr>
			    		<tr>
			    			<td>地址:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="address" data-options="multiline:true" style="height:60px" 
			    				name="user_address"></input></td>
			    		</tr>
			    		<tr>
			    			<td>真实姓名:</td>
			    			<td><input class="easyui-textbox" id="realname" name="user_real_name" ></input></td>
			    		</tr>
			    		<tr>
			    			<td>性别:</td>
			    			<td>
			    				<select class="easyui-combobox" panelHeight="auto" 
			    					name="user_sex" id="sex" style="width:60px;">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</td>
			    		</tr>
			    	</table>
			    </form>
			    <div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="u_submitForm()">提交</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="u_cancel()">取消</a>
			    </div>
		    </div>
		</div>

	</div>
	
	
	<!-- 确认删除框 -->
	<div id="u_dlg" class="easyui-dialog" title="确认框" closed="true"
		style="width: 250px; height: 130px; padding: 10px"
		data-options="
	 					iconCls: 'icon-save',					
	 					buttons: [{
	 						text:'确认',
	 						iconCls:'icon-ok',
	 						handler:function(){							
	 							u_deleteRow();
	 							$('#u_dlg').dialog('close');
	 						} 
	 					},{
	 						text:'取消',
	 						handler:function(){
	 							$('#u_dlg').dialog('close');
	 						}
	 					}]
	 				">
		是否删除该用户？
	</div>

</body>
</html>

