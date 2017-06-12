/* 初始化 */
$(function() {	
	//Todo..分页
	var pager = $('#u_dg').datagrid().datagrid('getPager');
	$(pager).pagination({ 
        beforePageText: '第',//页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页', 
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
        /*刷新页面
        onBeforeRefresh:function(){
            $(this).pagination('loading');
            alert('before refresh');
            $(this).pagination('loaded');
        } */
    }); 
});

// 修改操作，取得选中行
function u_getSelected() {
	var row = $('#u_dg').datagrid('getSelected');
	//alert(row);
	return row;
}
// 清空修改框
function clearForm(){
	$('#u_add_form').form('clear');
}

// 行编辑
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#u_dg').datagrid('validateRow', editIndex)) {

		$('#u_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	// 显示点击行
	// u_getSelected();
	if (editIndex != index) {
		if (endEditing()) {
			$('#u_dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#u_dg').datagrid('selectRow', editIndex);
		}
	}
}

var u_Local_url = "";
// 添加
function u_append() {
	//提示非空
	$("#u_add_form").form('enableValidation').form('validate');
	//取消选中行
	$('#u_dg').datagrid('unselectAll'); 
	$('#u_add-div').panel({title: '添加用户'}); 
	// 弹出添加输入框
	clearForm();
	$('#u_add-div').dialog('open').dialog('center');
	u_Local_url = "${ pageContext.request.contextPath }/user_add.action";
	// 设置表单action为添加
	//$("#u_add_form").attr("action", "${ pageContext.request.contextPath }/user_add.action");
	
}
	
function u_removeit() {
	// 弹出删除确认框
	$('#u_dlg').dialog('open');
}
// 删除该行
function u_deleteRow(){
	var row = u_getSelected();
	/*
	 * alert('删除：ID:' + row.itemid + "\nName:" + row.listprice + "\nPhone:" +
	 * row.productid);
	 */
	// Todo..主键传入action执行删除
	//alert("delete_id"+row.user_id);
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/user_delete.action?user_id="+row.user_id;
	var param = {};
	$.post(url,param,function(){
		u_refresh();	
	});
	// alert("刷新");
	//refresh();		
}

// 修改
function u_update() {
	//提示非空
	$("#u_add_form").form('enableValidation').form('validate');
	//设置表单action为更新
	//$("#u_add_form").attr("action", "${ pageContext.request.contextPath }/user_update.action");
	u_Local_url = "${ pageContext.request.contextPath }/user_update.action";
	var select_row = u_getSelected();
	//alert(select_row);
	// 已选行
	if(select_row!=null&&select_row.length!=0){
		$('#u_add_form').form('clear');
		//更改添加框标题
		$('#u_add-div').panel({title: '修改用户'});
		// 弹出输入框
		$('#u_add-div').dialog('open').dialog('center');
		// 为弹出输入框赋值
		var userid = select_row.user_id;
		$("#u_id").textbox("setValue", select_row.user_id);
		$("#u_name").textbox("setValue", select_row.user_name);
		$("#phone").textbox("setValue", select_row.user_phone);
		$("#pwd").textbox("setValue", select_row.user_pwd);
		$("#realname").textbox("setValue", select_row.user_real_name);
		// 默认性别判断
		if(select_row.user_sex==null){
			$("#sex").combobox('setValue','');	
		}else if(select_row.user_sex.toString()=="男"){
			$("#sex").combobox('setValue','男');
		}else {
			$("#sex").combobox('setValue','女');
		}
		$("#address").textbox("setValue", select_row.user_address);
		
		// 提交
		// refresh();
	}			
	
}
// 刷新表格
function u_refresh() {
	//alert("refresh");
	$('#u_dg').datagrid('unselectAll'); 
	$('#u_dg').datagrid('reload');
}

// 修改表单提交
function u_submitForm(){
	//alert("提交修改");
	//关闭框
	$('#u_add-div').dialog('close');
	$('#u_dg').datagrid('unselectAll');
	if($("#u_add_form").form('enableValidation').form('validate')){
		//document.getElementById("u_add_form").submit();
		//采用ajax提交，防止页面跳转
		//http://stackoverflow.com/questions/6960276/how-to-make-the-page-not-jump-on-form-submits
		$.ajax({
	           type: "POST",
	           url: u_Local_url,
	           data: $("#u_add_form").serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               u_refresh();
	        	   //alert("修改成功"); // show response from the php script.
	           }
	         });
		//loadCenter('user_manage.jsp');
	}else{
		alert("提交失败,请确认是否信息完善.");
	}
	
	
}

//取消修改
function u_cancel(){
	clearForm();
	$('#u_add-div').dialog('close');
}
// 改动行数量
function getChanges() {
	var changes = $('#u_dg').datagrid('getChanges');
	/*
	 * var s = ''; for (var i = 0; i < changes.length; i++) { s +=
	 * changes[i].name + ':' + changes[i].value + ','; } alert(s);
	 */

	alert(changes.length + "行 改动（增删改查）\n改动内容："
			+ JSON.stringify(changes));

	var updated = $('#u_dg').datagrid('getChanges', "updated");
	alert("\n修改行：" + JSON.stringify(updated));

	var added = $('#u_dg').datagrid('getChanges', "inserted");
	alert("\n添加行：" + JSON.stringify(added));

}
