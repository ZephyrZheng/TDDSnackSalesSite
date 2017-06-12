<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script> -->
<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="https://cdn.insdep.com/themes/1.0.0/jquery.insdep-extend.min.js"></script>	
<script type="text/javascript" src="js/goods_manage.js"></script>

<style type="text/css">@import url(/tdd/jsp/back/js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css);</style>
<!-- <script type="text/javascript" src="/tdd/jsp/back/js/jquery-1.6.2.min.js"></script> -->
<script type="text/javascript" src="js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="js/plupload/i18n/zh_CN.js"></script>


<link href="https://cdn.insdep.com/themes/1.0.0/easyui.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/easyui_animation.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/easyui_plus.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="https://cdn.insdep.com/themes/1.0.0/icon.css" rel="stylesheet" type="text/css">

</head>

<body>
	<!-- 管理表格 -->
	<div class="table-responsive">
		<table id="g_dg" class="easyui-datagrid" title="商品管理" sortOrder="asc" remoteSort="false"
			style="width: 100%; height: 730px"
			data-options="
                          loadMsg: '正在加载，请稍候...',
                          rownumbers:true,
                          pagination:true,
                          pageList: [25, 50, 100],
                          striped: true, 
                          iconCls: 'icon-edit',
                          singleSelect: true,
                          toolbar: '#tb',
                          url: '${ pageContext.request.contextPath }/goods_findByPage.action',
                          method: 'get',
                          onClickRow: onClickRow">
			<thead>
				<tr>
					<!-- 各列 -->
					<th data-options="sortable:true,field:'goods_id',align:'center',hidden:'true'">商品ID</th>
					<th data-options="sortable:true,field:'goods_name',align:'center', width:'15%'">商品名称</th>
					<th data-options="sortable:true,field:'goods_state',align:'center',width:'8%',
					formatter:function(value,row){
							if(value=='1'){
								return '上架';
							}else return '下架';				
						}">商品状态</th>
					<th data-options="field:'goods_detail',align:'center',width:'18%'">商品备注</th>
					<th data-options="sortable:true,field:'cat_id',align:'center',width:'15%',
					formatter:function(value,row){
							switch(value)
							{
								case 2:
									return '传统饼干';
									break;
								case 3:
									return '膨化食品';
									break;
								case 4:
									return '蛋黄派';
									break;
								case 6:
									return '坚果炒货';
									break;
								case 7:
									return '肉类即食';
									break;
								case 8:
									return '果干';
									break;
								case 9:
									return '海味即食';
									break;
								case 10:
									return '核桃';
									break;
								case 12:
									return '方便面';
									break;
								case 14:
									return '传统糕点';
									break;
								case 15:
									return '西式糕点';
									break;
								case 16:
									return '月饼';
									break;
								case 18:
									return '巧克力';
									break;
								case 19:
									return '果冻';
									break;
								case 20:
									return '口香糖';
									break;
								case 21:
									return '泡泡糖';
									break;
								case 22:
									return '牛扎糖';
									break;
								case 24:
									return '咖啡';
									break;
								case 25:
									return '冲饮';
									break;
								case 26:
									return '乳制品';
									break;
								case 27:
									return '果汁';
									break;
								case 28:
									return '碳酸饮料';
									break;
								case 29:
									return '酒水';
									break;
								case 31:
									return '进口酒水';
									break;
								case 32:
									return '进口零食';
									break;
								case 33:
									return '进口饮料';
									break;
								default :
									return '？';
							}	
						}"
					">商品类型</th>
					<th formatter="formatinventory" data-options="sortable:true,field:'goods_inventory',align:'center', width:'12%'">商品库存</th>
					<th data-options="sortable:true,field:'goods_price',align:'center',width:'15%'">商品价格</th>
					<th data-options="field:'goods_pic',align:'left',width:'32%'">商品图片地址</th>
				</tr>
			</thead>
		</table>

		<!-- 工具栏 -->
		<div id="tb" style="height: auto">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true" onclick="g_append()">添加</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true" onclick="g_removeit()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="g_update()">修改</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true" onclick="g_refresh()">刷新</a>
			<input id="Search_goods" class="easyui-textbox" style="left:20px;width:200px" data-options="
				prompt: '请输入商品',
				iconWidth: 15,
				icons: [{
					iconCls:'icon-search',
					handler: function(e){
						//Todo..执行搜索
						var v = $(e.data.target).textbox('getValue');
						if(v){
							//alert('你输入：'+v);
							g_search();
						}else{
							alert('请输入商品');	
						}
						
					}
				}]
			">
		</div>

		<!-- 添加用户框 -->
		<div id="g_adddiv" class="easyui-window" shadow="false" minimizable="false" maximizable="false" 
				collapsible="false" title="添加商品" modal="true" closed="true" style="width:400px">
			<div style="padding:10px 60px 20px 60px">
			    <form id="g_add_form" class="easyui-form" method="post" data-options="novalidate:true"
			    	action="${ pageContext.request.contextPath }/goods_update.action">
			    	<table cellpadding="5">
			    		<!-- 隐藏的主键,传给action执行CURD-->
			    		<tr hidden="true">
			    			<td>主键:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="goods_id" name="goods_id"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品名称:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="goods_name" name="goods_name" missingMessage="请填入商品名称" 
			    				invalidMessage="商品名已存在或无效" onblur="check_vali()"
			    				data-options="required:true"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品库存:</td>
			    			<td><input class="easyui-textbox" id="inventory" name="goods_inventory"></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品价格:</td>
			    			<td><input class="easyui-textbox" type="text" id="price" 
			    				data-options="required:true" missingMessage="请填入价格"
			    				name="goods_price" ></input></td>
			    		</tr>
			    		<tr>
			    			<td>商品类型:</td>
			    			<!-- <td><input class="easyui-textbox" type="text" id="type" name="cat_id" ></input></td> -->
			    			<td>
			    				<select class="easyui-combobox" data-options="required:true" panelHeight="150px" 
			    					name="cat_id" id="type" style="width:100px;">
									<option value="2">传统饼干</option>
									<option value="3">膨化食品</option>
									<option value="4">蛋黄派</option>
									<option value="6">坚果炒货</option>
									<option value="7">肉类即食</option>
									<option value="8">果干</option>
									<option value="9">海味即食</option>
									<option value="10">核桃</option>
									<option value="12">方便面</option>
									<option value="14">传统糕点</option>
									<option value="15">西式糕点</option>
									<option value="16">月饼</option>
									<option value="18">巧克力</option>
									<option value="19">果冻</option>
									<option value="20">口香糖</option>
									<option value="21">泡泡糖</option>
									<option value="22">牛扎糖</option>
									<option value="24">咖啡</option>
									<option value="25">冲饮</option>
									<option value="26">乳制品</option>
									<option value="27">果汁</option>
									<option value="28">碳酸饮料</option>
									<option value="29">酒水</option>
									<option value="31">进口酒水</option>
									<option value="32">进口零食</option>
									<option value="33">进口饮料</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td>商品状态:</td>
			    			<td>
			    				<select class="easyui-combobox" data-options="required:true" panelHeight="auto" 
			    					name="goods_state" id="goods_state" style="width:80px;">
									<option value="1">上架</option>
									<option value="0">下架</option>
								</select>
							</td>
			    		</tr>
			    		<tr>
			    			<td>商品备注:</td>
			    			<td><input class="easyui-textbox" type="text" 
			    				id="detail" data-options="multiline:true" style="height:85px" 
			    				name="goods_detail"></input></td>
			    		</tr>
			    		<tr id="upload_row">
			    			<td>上传商品图片:</td>
			    			<td>
			    				<input class="easyui-textbox" type="text" id="pic" 
			    					 missingMessage="图片路径..." data-options="multiline:true" 
			    					 style="height:80px"	name="goods_pic" ></input>
			    				<!-- <input class="easyui-filebox" id="goods_pic" name="upload" 
			    					data-options="prompt:'请选择图片...',buttonText:'浏览'" 
			    					accept="image/gif,image/jpeg,image/png"></input> -->
	    					</td>
	    					<!-- 触发批量上传按钮 -->
	    					<td>
	    						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadPics()" 
	    							plain="true" iconCls="icon-filter"></a>
	    					</td>
			    		</tr>
			    		
			    	</table>
			    </form>
			    <div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="g_submitForm()">提交</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="g_cancel()">取消</a>
			    </div>
		    </div>
		</div><!-- 添加用户框/div -->

	</div><!-- 数据管理/div -->
	
	<!-- 批量上传图片工具 -->
	<div id="upload_tool" class="easyui-window" minimizable="false" maximizable="false" 
				collapsible="false" title="添加商品图片" modal="true" closed="true" 
				style="width: 750px;">
			<form id="formId" action="Submit.action" enctype="multipart/form-data" method="post">
				<div id="pic_uploader">
					<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
				</div>
				<a href="javascript:void(0)"  onclick="submit_upload()"
					class="easyui-linkbutton" plain="true" iconCls="icon-search">完成上传</a>
				<!-- <input type="submit" value="完成"/> -->
			</form>
	</div>
	
	
	<!-- 确认删除框 -->
	<div id="good_dlg" class="easyui-dialog" title="确认框" closed="true"
		style="width: 250px; height: 130px; padding: 10px"
		data-options="
	 					iconCls: 'icon-save',					
	 					buttons: [{
	 						text:'确认',
	 						iconCls:'icon-ok',
	 						handler:function(){							
	 							g_deleteRow();
	 							$('#good_dlg').dialog('close');
	 						} 
	 					},{
	 						text:'取消',
	 						handler:function(){
	 							$('#good_dlg').dialog('close');
	 						}
	 					}]
	 				">
		是否删除该商品？
	</div>
</body>
</html>