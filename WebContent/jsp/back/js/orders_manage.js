/* 初始化 */
$(function() {	
	//Todo..分页
	var pager = $('#or_dg').datagrid().datagrid('getPager');
	$(pager).pagination({ 
        beforePageText: '第',//页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页', 
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
    }); 
	
});


//取得选中行（实际根据json键值取，不是根据jsp的field:属性 （如user.user_id））
function ord_getSelected(){
	var row = $('#or_dg').datagrid('getSelected');
	return row;
}
// 清空修改框
function ord_clearForm(){
	$('#ord_add_form').form('clear');
}

// 行编辑
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#or_dg').datagrid('validateRow', editIndex)) {

		$('#or_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	// 显示点击行
	// ord_getSelected();
	if (editIndex != index) {
		if (endEditing()) {
			$('#or_dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#or_dg').datagrid('selectRow', editIndex);
		}
	}
}
	
function ord_removeit() {
	// 弹出删除确认框
	$('#ord_dlg').dialog('open');
}
// 删除该行
function ord_deleteRow() {
	var row = ord_getSelected();
	/*
	 * alert('删除：ID:' + row.itemid + "\nName:" + row.listprice + "\nPhone:" +
	 * row.productid);
	 */
	// Todo..主键传入action执行删除
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/orders_delete.action?ordid="+row.ord_id;
	var param = {};
	$.post(url,param,function(){
		ord_refresh();	
	});
	// alert("刷新");
	//refresh();		
}

var ord_Local_url = "";
//修改
function ord_update() {	
	var select_row = ord_getSelected();
	//设置表单action为更新(传入更新一方对象user)
	ord_Local_url = "${ pageContext.request.contextPath }/orders_update.action";
	// 已选行
	if(select_row!=null&&select_row.length!=0){
		$('#ord_add_form').form('clear');
		//更改添加框标题
		$('#ord_adddiv').panel({title: '修改订单'});
		// 弹出输入框
		$('#ord_adddiv').dialog('open').dialog('center');
		// 为弹出输入框赋值
		//主键（隐藏）
		$("#ord_id").textbox("setValue", select_row.ord_id);
		//$("#one_user").textbox("setValue", select_row.user);
		//订单号
		$("#ord_number").textbox("setValue", select_row.ord_number);
		$("#ord_u_id").textbox("setValue", select_row.user.user_id);
		//alert(select_row.user.user_id); 取子对象
		$("#ord_u_name").textbox("setValue", select_row.user.user_name);
		$("#cretime").textbox("setValue", select_row.ord_createtime);
		$("#note").textbox("setValue", select_row.ord_note);
		$("#ord_address").textbox("setValue", select_row.ord_address);
		//订单状态
		$("#ord_state").combobox({required:true,eidtable:false});
		if(select_row.ord_state=="1"){
			$("#ord_state").combobox('setValue','1');	
		}else {
			$("#ord_state").combobox('setValue','0');
		}
		//支付状态
		if(select_row.pay_state=="1"){
			$("#pay_state").combobox('setValue','1');	
		}else{
			$("#pay_state").combobox('setValue','0');
		}

	}			
	
}
//刷新表格
function ord_refresh() {
	//alert("refresh");
	$('#or_dg').datagrid('unselectAll'); 
	$('#or_dg').datagrid('reload');
}

//修改表单提交
function ord_submitForm(){
	//alert("提交修改");
	//关闭框
	$('#ord_adddiv').dialog('close');
	$('#or_dg').datagrid('unselectAll');
	if($("#ord_add_form").form('enableValidation').form('validate')){
		$.ajax({
	           type: "POST",
	           url: ord_Local_url,
	           data: $("#ord_add_form").serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               //刷新不跳转
	        	   ord_refresh();
	        	   //alert("修改成功"); // show response from the php script.
	           }
	         });
	}else{
		alert("提交失败,请确认是否信息完善.");
	}	
}

//取消修改
function ord_cancel(){
	ord_clearForm();
	$('#ord_adddiv').dialog('close');
}