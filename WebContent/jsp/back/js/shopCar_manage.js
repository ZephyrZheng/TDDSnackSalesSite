/* 初始化 */
$(function() {	
	//高显行
	$('#sh_dg').datagrid({    
	    rowStyler:function(index,row){    
	        //上架提示
	    	if (row.car_state=="0"){    
	            return 'color:#9D9D9D;';    
	        }	        
	    }    
	}); 
	
	//Todo..分页
	var pager = $('#sh_dg').datagrid().datagrid('getPager');
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

//Search
function Search(){
	var key_word = $('#Search_user').val();
	//alert('搜索关键词'+key_word);
	var url = '${ pageContext.request.contextPath }/orderItems_findByName.action?key_word='
		+key_word;
	var param = {};
	$.post(url,param,function(data){
		//alert('返回'+data);
		$('#sh_dg').datagrid('loadData', data);
	});
}

//取得选中行（实际根据json键值取，不是根据jsp的field:属性 （如user.user_id））
function sh_getSelected() {
	var row = $('#sh_dg').datagrid('getSelected');
	return row;
}
// 清空修改框
function clearForm(){
	$('#sh_add_form').form('clear');
}

// 行编辑
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#sh_dg').datagrid('validateRow', editIndex)) {

		$('#sh_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	// 显示点击行
	// sh_getSelected();
	if (editIndex != index) {
		if (endEditing()) {
			$('#sh_dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#sh_dg').datagrid('selectRow', editIndex);
		}
	}
}
	
function removeit() {
	// 弹出删除确认框
	$('#sc_dlg').dialog('open');
}
// 删除该行
function sh_deleteRow() {
	var row = sh_getSelected();
	/*
	 * alert('删除：ID:' + row.itemid + "\nName:" + row.listprice + "\nPhone:" +
	 * row.productid);
	 */
	// Todo..主键传入action执行删除
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/ShopCar_delete.action?car_id="+row.car_id;
	var param = {};
	$.post(url,param,function(){
		sh_refresh();	
	});
	// alert("刷新");
	//sh_refresh();		
}

var sh_Local_url = "";

//修改
function sh_update() {	
	var select_row = sh_getSelected();
	//设置表单action为更新(传入更新一方对象user)
	sh_Local_url = "${ pageContext.request.contextPath }/ShopCar_update.action";
	// 已选行
	if(select_row!=null&&select_row.length!=0){
		$('#sh_add_form').form('clear');
		//更改添加框标题
		$('#sh_adddiv').panel({title: '修改购物车项'});
		// 弹出输入框
		$('#sh_adddiv').dialog('open').dialog('center');
		// 为弹出输入框赋值
		//主键（隐藏）
		$("#car_id").textbox("setValue", select_row.car_id);
		$("#car_goods_id").textbox("setValue", select_row.goods_id);
		//用户id(User外键 )
		$("#car_u_id").textbox("setValue", select_row.user.user_id);
		//alert(select_row.user.user_id); 取子对象
		$("#car_goods_num").textbox("setValue", select_row.goods_num);
		$("#car_note").textbox("setValue", select_row.car_note);
		$("#car_state").combobox({required:true,eidtable:false});
		//alert(select_row.ori_state);
		if(select_row.car_state=="1"){
			$("#car_state").combobox('setValue','1');	
		}else if(select_row.car_state=="0") {
			$("#car_state").combobox('setValue','0');
		}
		$("#car_createtime").textbox("setValue", select_row.car_createtime);
	}			
	
}

function sh_format(){
	//高显行
	$('#sh_dg').datagrid({    
	    rowStyler:function(index,row){    
	        //上架提示
	    	if (row.car_state=="0"){    
	            return 'color:#9D9D9D;';    
	        }	        
	    }    
	}); 
}

//刷新表格
function sh_refresh() {
	sh_format();
	
	//alert("refresh");
	$('#sh_dg').datagrid('unselectAll'); 
	$('#sh_dg').datagrid('reload');
	$('#Search_user').textbox('clear');
}

//修改表单提交
function sh_submitForm(){
	//alert("提交修改");
	//关闭框
	$('#sh_adddiv').dialog('close');
	$('#sh_dg').datagrid('unselectAll');
	//alert(Local_url);
	if($("#sh_add_form").form('enableValidation').form('validate')){
		$.ajax({
	           type: "POST",
	           url: sh_Local_url,
	           data: $("#sh_add_form").serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               sh_refresh();
	        	   //alert("修改成功"); // show response from the php script.
	           }
	         });
	}else{
		alert("提交失败,请确认是否信息完善.");
	}	
}

//取消修改
function sh_cancel(){
	clearForm();
	$('#sh_adddiv').dialog('close');
}