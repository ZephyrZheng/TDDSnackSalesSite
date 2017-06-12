/* 初始化 */
$(function() {	
	//高显行
	$('#g_dg').datagrid({    
	    rowStyler:function(index,row){    
	        //上架提示
	    	if (row.goods_state=="0"){    
	            return 'color:#9D9D9D;';    
	        }	        
	    }    
	}); 
	
	//Todo..分页
	var pager = $('#g_dg').datagrid().datagrid('getPager');
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



//高亮库存小于50提醒
function formatinventory(val,row){
	if (val < 50){
        return '<span style="color:red;font-weight:bold;">'+val+'</span>';
    } else {
        return val;
    }
}
// 修改操作，取得选中行
function g_getSelected() {
	var row = $('#g_dg').datagrid('getSelected');
	if (row) {
		/*
		 * alert('Item ID:' + row.user_id + "\nName:" + row.user_name +
		 * "\nPhone:" + row.user_phone);
		 */
		// 把数据发送到action 回调返回data
	}

	return row;
}
// 清空修改框
function g_clearForm(){
	$('#g_add_form').form('clear');
}

// 行编辑
var editIndex = undefined;
function g_endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#g_dg').datagrid('validateRow', editIndex)) {

		$('#g_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	// 显示点击行
	// g_getSelected();
	if (editIndex != index) {
		if (g_endEditing()) {
			$('#g_dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#g_dg').datagrid('selectRow', editIndex);
		}
	}
}
//全局提交表单连接
var Local_url = "";

// 添加(回避上传图片>.<，隐藏上传功能)
function g_append() {
	//提示非空
	$("#g_add_form").form('enableValidation').form('validate');
	//取消选中行
	$('#g_dg').datagrid('unselectAll'); 
	$('#g_adddiv').panel({title: '添加用户'}); 
	// 弹出添加输入框
	g_clearForm();
	$("#state").combobox('setValue','0');
	$('#g_adddiv').dialog('open').dialog('center');
	// 设置表单action为添加
	Local_url = "${ pageContext.request.contextPath }/goods_save.action";
	$("#g_add_form").attr("action", Local_url);
	
	//>.<隐藏上传图片框
	document.getElementById("upload_row").setAttribute("style","display:none"); ; 
}
	
function g_removeit() {
	// 弹出删除确认框
	$('#good_dlg').dialog('open');
}
// 删除该行
function g_deleteRow() {
	var row = g_getSelected();
	/*
	 * alert('删除：ID:' + row.itemid + "\nName:" + row.listprice + "\nPhone:" +
	 * row.productid);
	 */
	//alert("delete_id:"+ row.goods_id)
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/goods_delete.action?goods_id="+row.goods_id;
	var param = {};
	$.post(url,param,function(){
		g_refresh();	
	});
	// alert("刷新");
	//refresh();		
}

function check_vali(){
	//提示非空
	$("#g_add_form").form('enableValidation').form('validate');
}


// 修改
function g_update() {	
	//设置
	document.getElementById("upload_row").setAttribute("style","display:visible"); 
	Local_url = "${ pageContext.request.contextPath }/goods_update.action";
	//设置表单action为更新
	$("#g_add_form").attr("action", Local_url);
	var select_row = g_getSelected();
	// 已选行
	if(select_row!=null&&select_row.length!=0){
		$('#g_add_form').form('clear');
		//更改添加框标题
		$('#g_adddiv').panel({title: '修改商品'});
		// 弹出输入框
		$('#g_adddiv').dialog('open').dialog('center');
		// 为弹出输入框赋值
		var goodsid = select_row.goods_id;		
		$("#goods_id").textbox("setValue", goodsid);
		$("#goods_name").textbox("setValue", select_row.goods_name);
		$("#inventory").textbox("setValue", select_row.goods_inventory);
		$("#price").textbox("setValue", select_row.goods_price);
		
		//$("#type").textbox("setValue", select_row.cat_id);
		$("#type").combobox('setValue',select_row.cat_id);
		
		$("#detail").textbox("setValue", select_row.goods_detail);
		// 默认上架状态
		$("#goods_state").combobox({required:true,eidtable:false});
		//alert("商品状态:"+select_row.goods_state);
		if(select_row.goods_state=="1"){
			$("#goods_state").combobox('setValue','1');	
		}else {
			$("#goods_state").combobox('setValue','0');
		}
			
		$("#pic").filebox("setValue", select_row.goods_pic);
		
		// 提交
		// refresh();
	}			
	
}

function g_data_format(){
	//高显行
	$('#g_dg').datagrid({    
	    rowStyler:function(index,row){    
	        //上架提示
	    	if (row.goods_state=="0"){    
	            return 'color:#9D9D9D;';    
	        }	        
	    }    
	}); 
	var pager = $('#g_dg').datagrid().datagrid('getPager');
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
}

// 刷新表格
function g_refresh() {
	g_data_format();
	//alert("refresh");
	$('#g_dg').datagrid('unselectAll'); 
	$('#g_dg').datagrid('reload');
	$('#Search_goods').textbox('clear');
}

// 修改表单提交
function g_submitForm(){
	//alert("提交修改");
	//关闭框
	$('#g_adddiv').dialog('close');
	$('#g_dg').datagrid('unselectAll');
	if($("#g_add_form").form('enableValidation').form('validate')){
		//document.getElementById("g_add_form").submit();
		$.ajax({
	           type: "POST",
	           url: Local_url,
	           data: $("#g_add_form").serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               //刷新不跳转
	        	   g_refresh();
	        	   //alert("修改成功"); // show response from the php script.
	           }
	         });
	}else{
		alert("提交失败,请确认是否信息完善.");
	}	
}

//取消修改
function g_cancel(){
	g_clearForm();
	$('#g_adddiv').dialog('close');
}

//商品搜索
function g_search(){
	var key_word = $('#Search_goods').val();
	//alert('搜索关键词'+key_word);
	var url = '${ pageContext.request.contextPath }/goods_findByName.action?good_key_word='
		+key_word;
	var param = {};
	$.post(url,param,function(data){
		//alert('返回'+data);
		$('#g_dg').datagrid('loadData', data);
	});
}

//弹出批量上传窗口
function uploadPics(){
	//alert("批量");
	//$('#upload_tool').panel({title: '商品图片'});
	//设置相关属性
	$("#pic_uploader").pluploadQueue({
		//Action 传入文件属性对象名
		file_data_name:'upload',
		// General settings
		runtimes : 'html5,flash,silverlight,html',
		url : 'FileUpload.action'+'?goods_id='+g_getSelected().goods_id,
		max_file_size : '10mb',
		
		//分段大小
		//chunk_size: '2mb',
		// 文件类型过滤器
		filters : {
			mime_types : [
			    { title : "Image files", extensions : "jpg,gif,png" }
			  ]
		},
		/* // 调整图片
        resize : {
            width : 200,
            height : 200,
            quality : 90,
            crop: true // crop to exact dimensions
        }, */
		//预览
		views: {
	            list: true,
	            thumbs: true, // Show thumbs
	            active: 'thumbs'
        },
		// Flash settings
		flash_swf_url : '/jsp/back/js/plupload/Moxie.swf',
		// Silverlight settings
		silverlight_xap_url : '/jsp/back/js/plupload/Moxie.xap'
	});
	$('form').submit(function(e) {
        var uploader = $('#pic_uploader').pluploadQueue();
        if (uploader.files.length > 0) {
            // When all files are uploaded submit form
            uploader.bind('StateChanged', function(uploader,addFiles) {
                if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                    $('form')[0].submit();
                }
            });
            uploader.start();
        } else {
			alert('请先上传数据文件.');
		}
        return false;
	});
	
	$('#upload_tool').dialog('open').dialog('center');
	
}

//点击完成上传图片
function submit_upload(){
	var selected = g_getSelected();
	// 发送ajax的请求
	var url = "${ pageContext.request.contextPath }/goods_writeBackdiv.action";
	//传入修改商品id,返回最新pic路径
	var param = {"goodid":selected.goods_id};
	$.post(url,param,function(data){
		if(data!=null){
			alert("上传图片成功");
			//关闭上传框
			$('#upload_tool').dialog('close');
		}else{
			alert("上传失败.")
		}
		for(var key in data){  
		   if(key=="goods_pic"){
			   var newpath = data[key];
			   //alert(newpath);
			   //回显重设
			   $("#pic").filebox("setValue", newpath);
		   }
		}  
	},"json");
	
}


