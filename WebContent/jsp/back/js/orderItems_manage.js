/* 初始化 */
$(function() {	
	//高显行
//	$('#ori_dg').datagrid({    
//	    rowStyler:function(index,row){    
//	        //上架提示
//	    	if (row.ori_state=="N"){    
//	            return 'color:#9D9D9D;';    
//	    	}else if(row.ori_state=="N"){
//	    		return 'color:#009100;'; 
//	    	}
//	    }    
//	}); 
	
	//Todo..分页
	var pager = $('#ori_dg').datagrid().datagrid('getPager');
	$(pager).pagination({ 
        beforePageText: '第',//页数文本框前显示的汉字 
        afterPageText: '页    共 {pages} 页', 
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
    }); 
	
	//过滤搜索框
	//初次进入清空
	$('#Search_user').textbox('clear');
	$.extend($.fn.textbox.methods, {
		addClearBtn: function(jq, iconCls){
			return jq.each(function(){
				var t = $(this);
				var opts = t.textbox('options');
				opts.icons = opts.icons || [];
				opts.icons.unshift({
					iconCls: iconCls,
					handler: function(e){
						$(e.data.target).textbox('clear').textbox('textbox').focus();
						$(this).css('visibility','hidden');
					}
				});
				t.textbox();
				if (!t.textbox('getText')){
					t.textbox('getIcon',0).css('visibility','hidden');
				}
				t.textbox('textbox').bind('keyup', function(){
					var icon = t.textbox('getIcon',0);
					if ($(this).val()){
						icon.css('visibility','visible');
					} else {
						icon.css('visibility','hidden');
					}
				});
			});
		}
	});
	
	$(function(){
		$('#Search_user').textbox().textbox('addClearBtn', 'icon-clear');
	});
});

function ori_data_format(){
	//高显行
//	$('#ori_dg').datagrid({    
//	    rowStyler:function(index,row){    
//	        //上架提示
//	    	if (row.ori_state=="N"){    
//	            return 'color:#9D9D9D;';    
//	    	}else if(row.ori_state=="1"){
//	    		return 'color:#009100;font-weight:bold;'; 
//	    	}
//	    }    
//	}); 
}

//Search
function ori_search(){
	alert("ori_search");
	var key_word = $('#Search_user').val();
	//alert('搜索关键词'+key_word);
	var url = '${ pageContext.request.contextPath }/orderItems_findByName.action?key_word='
		+key_word;
	var param = {};
	$.post(url,param,function(data){
		//alert('返回'+data);
		$('#ori_dg').datagrid('loadData', data);
	});
}

//取得选中行（实际根据json键值取，不是根据jsp的field:属性 （如user.user_id））
function ori_getSelected() {
	var row = $('#ori_dg').datagrid('getSelected');
	return row;
}
// 清空修改框
function ori_clearForm(){
	$('#ori_add_form').form('clear');
}

// 行编辑
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#ori_dg').datagrid('validateRow', editIndex)) {

		$('#ori_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	// 显示点击行
	// ori_getSelected();
	if (editIndex != index) {
		if (endEditing()) {
			$('#ori_dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#ori_dg').datagrid('selectRow', editIndex);
		}
	}
}
	
function ori_removeit() {
	// 弹出删除确认框
	$('#ori_dlg').dialog('open');
}
// 删除该行
function ori_deleteRow() {
	var row = ori_getSelected();
	/*
	 * alert('删除：ID:' + row.itemid + "\nName:" + row.listprice + "\nPhone:" +
	 * row.productid);
	 */
	//alert("删除订单项id_"+row.ori_id);
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/orderItems_delete.action?ori_id="+row.ori_id;
	var param = {};
	$.post(url,param,function(){
		ori_refresh();	
	});
	// alert("刷新");
	//ori_refresh();		
}

var ori_Local_url = "";

//修改
function ori_update() {	
	var select_row = ori_getSelected();
	//设置表单action为更新(传入更新一方对象user)
	ori_Local_url = "${ pageContext.request.contextPath }/orderItems_update.action";
	//$("#ori_add_form").attr("action", "${ pageContext.request.contextPath }/orders_update.action");
	// 已选行
	if(select_row!=null&&select_row.length!=0){
		$('#ori_add_form').form('clear');
		//更改添加框标题
		$('#ori_adddiv').panel({title: '修改订单项'});
		// 弹出输入框
		$('#ori_adddiv').dialog('open').dialog('center');
		// 为弹出输入框赋值
		//主键（隐藏）
		$("#ori_id").textbox("setValue", select_row.ori_id);
		//alert("update_oriid="+select_row.ori_id);
		$("#ori_goods_id").textbox("setValue", select_row.goods_id);
		//订单号(外键 传给action)
		$("#ori_ord_id").textbox("setValue", select_row.orders.ord_id);
		$("#ori_ord_num").textbox("setValue", select_row.orders.ord_number);
		//alert(select_row.user.user_id); 取子对象
		$("#ori_goods_num").textbox("setValue", select_row.goods_num);
		$("#ori_note").textbox("setValue", select_row.ord_note);
		$("#ori_rec_state").combobox({required:true,eidtable:false});
		//alert(select_row.ori_state);
		if(select_row.rec_state=="1"){
			$("#ori_rec_state").combobox('setValue','1');	
		}else if(select_row.rec_state=="0") {
			$("#ori_rec_state").combobox('setValue','0');
		}
		/*
		//支付状态
		if(select_row.pay_state=="1"){
			$("#pay_state").combobox('setValue','1');	
		}else if(select_row.ori_state=="0") {
			$("#pay_state").combobox('setValue','0');
		}*/
		
		$("#ori_passway").textbox("setValue", select_row.ori_passway);
	}			
	
}
//刷新表格
function ori_refresh() {
	//alert("ori_refresh");
	$('#ori_dg').datagrid('unselectAll'); 
	$('#ori_dg').datagrid('reload');
	$('#Search_user').textbox('clear');
	ori_data_format();
}

//修改表单提交
function ori_submitForm(){
	//alert("提交修改");
	//关闭框
	$('#ori_adddiv').dialog('close');
	$('#ori_dg').datagrid('unselectAll');
	if($("#ori_add_form").form('enableValidation').form('validate')){
		$.ajax({
	           type: "POST",
	           url: ori_Local_url,
	           data: $("#ori_add_form").serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               //刷新不跳转
	        	   ori_refresh();
	        	   //alert("修改成功"); // show response from the php script.
	           }
	         });
		//document.getElementById("ori_add_form").submit();
	}else{
		alert("提交失败,请确认是否信息完善.");
	}	
}

//取消修改
function ori_cancel(){
	ori_clearForm();
	$('#ori_adddiv').dialog('close');
}