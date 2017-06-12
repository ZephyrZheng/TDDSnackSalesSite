//切换已确认订单
function ShowConfirmed(){		
	//alert("Confirmed");
	removeOrdRow();
	//新增tr
	load_Order(u_id,"confirmed");
}

//切换未确认订单
function ShowUnConfirmed(){
	//alert("UnConfirmed");
	removeOrdRow();
	//新增tr
	load_Order(u_id,"Unconfirmed");
}

//切换已支付订单
function Showpaied(){
	//alert("UnConfirmed");
	removeOrdRow();
	//新增tr
	load_Order(u_id,"paied");
}

//删除订单行
function removeOrdRow(){
	//移除原tr
	//获取此订单表格（单个订单）的 table容器
	var table =document.getElementById("ordertb");
   	var r_length = table.rows.length;
   	//alert("行数："+r_length);
   	//批量移除行
   	for (var i = r_length-1; i > 0; i--) {
   		table.deleteRow(i);
   	}; 
}

//使用iCheck，初始化checkbox，设置checkbox效果，设置全选，全输出效果
function iCheck_init(){
	//使用iCheck初始化checkbox
	$('input').iCheck({
		checkboxClass: 'icheckbox_flat-grey',
		radioClass: 'iradio_flat-grey'
	});

	//订单的checkbox，初始设置为未选中
	$("[name='check_item']").iCheck('uncheck');

	//checkall全选选择框，初始设置为未选中
	$("#checkall").iCheck('uncheck');

	//checkbox 配合table hover 改变颜色样式
	$(".list_item_table").hover(
		function(){
			$(this).find("input").iCheck({
				checkboxClass: 'icheckbox_flat-orange',
				radioClass: 'iradio_flat-orange'
			});
		},
		function(){
			$(this).find("input").iCheck({
				checkboxClass: 'icheckbox_flat-grey',
				radioClass: 'iradio_flat-grey'
			});
		}
	);

	//统计checkbox总数，保存在length
	var length = $("[type='checkbox']").length,
		i    //设置i用于保存被选中的checkbox;

    //全选反选，选择操作，监听checkall全选选择框的选中状态改变事件
    $("#checkall").on("ifClicked",function(event){
		if(event.target.checked){//checkall被选中
			$("[name='check_item']").iCheck('uncheck');
			i=0;
		}else{//checkall未选中
			$("[name='check_item']").iCheck('check');
			i=length;
		}
	});

    //监听计数，监听列表checkbox的选中状态改变事件
	$("[name='check_item']").on('ifClicked',function(event){
		event.target.checked ? i-- : i++;//判断是否选中，对i进行同步改变，保存被选中数
		if(i==length){//判断列表是否全部选中
			$("#checkall").iCheck('check');
		}else{
			$("#checkall").iCheck('uncheck');
		}
	})
}

function button_init(){

	//$('.order_pay_button').hide();


	//监听批量删除按钮的click事件，触发批量 删除或移除 操作 ==》针对 未确认类型 和 已完成类型 订单
	$("#batch_delete").click(function(){
		//形成一个确认按钮列表数组
		var confirm_array = $("input:checkbox[name='check_item']:checked")//获取所有被选中订单的checkbox
				.parents(".list_item_table")//在此基础上向上寻找，获取其订单table容器
				.find(".order_delete_button:first");//在此基础上向下寻找，获取确认按钮，并选中第一个

		var remove_array = $("input:checkbox[name='check_item']:checked")//获取所有被选中订单的checkbox
				.parents(".list_item_table")//在此基础上向上寻找，获取其订单table容器
				.find(".order_remove_button:first");//在此基础上向下寻找，获取确认按钮，并选中第一个
		
		//调用按钮数组元素的click方法，执行对应删除或移除操作
		confirm_array.click();
		remove_array.click();
	});

	//监听批量确认按钮的click事件，触发批量确认操作 ==》针对未确认类型订单
	$("#batch_confirm").click(function(){
		//形成一个确认按钮列表数组
		var array = $("input:checkbox[name='check_item']:checked")//获取所有被选中订单的checkbox
				.parents(".list_item_table")//在此基础上向上寻找，获取其订单table容器
				.find(".order_sure_button:first");//在此基础上向下寻找，获取确认按钮，并选中第一个

		//执行此列表按钮的click事件，即触发确认订单操作
		for (var i = 0; i < array.length; i++) {
			array[i].click();
		};
	});

	//确认订单 #Update
	$(".order_sure_button").click(function(){

		//获取此订单表格（单个订单）的 table容器
		var item_table = $(this).parents(".list_item_table");
		//获取此订单表格（单个订单）的 所有支付按钮（一共两个，一个隐藏）
		var pay_button = $(this).parents(".list_item_table").find(".order_pay_button");
		//获取此订单表格（单个订单）的 所有删除按钮（一共两个，一个隐藏）
		var delete_button = $(this).parents(".list_item_table").find(".order_delete_button");
		//获取此订单表格（单个订单）的 所有确认按钮（一共两个，一个隐藏）
		var confirm_button = $(this).parents(".list_item_table").find(".order_sure_button");
		//获取此订单表格（单个订单）的 复选框
		var checkbox = $(this).parents(".list_item_table").find("[name = 'check_item']");

		//确认按钮和删除按钮 加入退出动作
		confirm_button.addClass('animated bounceOut');
		delete_button.addClass('animated bounceOut');

		//等待退出动作完成
		window.setTimeout( 
			function(){
				//隐藏 确认按钮和删除按钮
				confirm_button.hide();
				delete_button.hide();

				//移除 确认按钮和删除按钮 完成动作后无用的动作类
				confirm_button.removeClass('animated bounceOut');
				delete_button.removeClass('animated bounceOut');

				//--------开始第二个动作
				//显示 支付按钮
				pay_button.show();
				//支付按钮 加入进入动作
				pay_button.addClass('animated bounceIn');

				//等待进入动作完成
				window.setTimeout( 
					function(){
						//移除 支付按钮 完成动作后无用的动作类
						pay_button.removeClass('animated bounceIn');
					}, 
					1000
				);
			}, 
			700
		);

		//===================================后台操作位置====================================//

		// //获取总订单数---测试用
		// var length = $(".order_show").find("table").length;
		// //获取订单在页面中的序号---测试用
		// var num = $(item_table).parent().parent().index();
		// var ord_id = $(item_table).find(".order_id").text();
		// //设置checkbox值为订单在页面中的序号---测试用
		// checkbox.val(ord_id);

		//输出checkbox的值---测试用
		var ordid = $(checkbox).val();		
		var ord_add = $(item_table).find(".product_shipping_address_show span").text();
		//alert("修改订单：" + ordid + "地址："+order_address+"用户id"+u_id);
		
		//Todo..后台修改订单
        var update_url = '${ pageContext.request.contextPath }/orders_confirmOrder.action';
		alert("ajax提交地址"+ord_add);		
		$.ajax({
	           type: "POST",
	           url: update_url,
	           data:{      
			             "ordid" : ordid,    
			             "ord_add" : ord_add
				    },   
	           success: function(data)
	           {
	               
	           }
         });


		//获取订单列表所在行（在show_list中的行数）
		var list = $(this).parents(".list_item_table").parent("td").parent("tr");

		//为订单列表所在行 加入 退出动作
		list.addClass('animated bounceOutRight');

		//等待动作完成
		window.setTimeout( 
			function(){
				//隐藏订单列表所在行
				list.hide();

				//移除已完成的无效动作类
				list.removeClass('animated bounceOutRight');
			}, 
			600
		);


	});

	//删除动画
	function delete_view(){
		//获取订单列表所在行（在show_list中的行数）
		var list = $(this).parents(".list_item_table").parent("td").parent("tr");

		//为订单列表所在行 加入 退出动作
		list.addClass('animated bounceOutRight');

		//等待动作完成
		window.setTimeout( 
			function(){
				//隐藏订单列表所在行
				list.hide();

				//移除已完成的无效动作类
				list.removeClass('animated bounceOutRight');
			}, 
			600
		);
	}

	//付款操作	#pay
	$(".order_pay_button").click(function(){
		//Todo..执行删除后台
		//获取订单号
		var checkbox = $(this).parents(".list_item_table").find("[name = 'check_item']");
		var ordid = $(checkbox).val();		

		var url = '${ pageContext.request.contextPath }/orders_pay.action';
		var param = {ordid:ordid};
		$.post(url,param,function(data){});	

		//动画
		//获取订单列表所在行（在show_list中的行数）
		var list = $(this).parents(".list_item_table").parent("td").parent("tr");

		//为订单列表所在行 加入 退出动作
		list.addClass('animated bounceOutRight');

		//等待动作完成
		window.setTimeout( 
			function(){
				//隐藏订单列表所在行
				list.hide();

				//移除已完成的无效动作类
				list.removeClass('animated bounceOutRight');
			}, 
			600
		);

	});

	//删除订单 #Delete
	$(".order_delete_button").click(function(){
		//获取订单列表所在行（在show_list中的行数）
		var list = $(this).parents(".list_item_table").parent("td").parent("tr");

		//为订单列表所在行 加入 退出动作
		list.addClass('animated bounceOutRight');

		//等待动作完成
		window.setTimeout( 
			function(){
				//隐藏订单列表所在行
				list.hide();

				//移除已完成的无效动作类
				list.removeClass('animated bounceOutRight');
			}, 
			600
		);
		

		//Todo..执行删除后台
		//获取订单号
		var checkbox = $(this).parents(".list_item_table").find("[name = 'check_item']");
		var ordid = $(checkbox).val();		

		var url = '${ pageContext.request.contextPath }/orders_delete.action';
		var param = {ordid:ordid};
		$.post(url,param,function(data){});		


	});

	//监听订单列表的 显示或隐藏按钮 ，触发展示或隐藏订单详细内容的事件 ==》针对所有类型订单
	$(".table_show_control_button").click(function(){
		//获取 显示或隐藏按钮
		var button = $(this).find("span");
		//获取订单table
		var list_table = $(this).parents(".list_item_table");

		//判断 显示或隐藏按钮 的 图标样式，即判断订单是否为显示状态
		if(button.hasClass("glyphicon-triangle-bottom")){//为显示状态
			//显示或隐藏按钮 的 图标样式变换
			button.removeClass("glyphicon glyphicon-triangle-bottom").addClass("glyphicon glyphicon-triangle-top");

			//订单列表 加入 退出动作
			list_table.addClass('animated flipOutX');

			//显示 订单列表 的 头部隐藏菜单（包含操作按钮）
			$(this).parents(".list_item_table_item_menu_div3").siblings(".list_item_table_item_menu_div2").find(".list_item_table_list_div").show();

			//等待 订单列表 退出动作 完成
			window.setTimeout( 
				function(){
					//隐藏 订单列表 详细内容
					list_table.find(".list_item_table_tr_for_actions").hide();

					//订单列表 加入 进入动作 ，并移除已用的无效动作类
					list_table.removeClass('animated flipOutX').addClass('animated flipInX');

					//等待 订单列表 进入动作 完成
					window.setTimeout( 
						function(){
							//移除已用的无效动作类
							list_table.removeClass('animated flipInX');
						}, 
						1000
					);
				}, 
				700
			);

		}else {//为隐藏状态

			//显示或隐藏按钮 的 图标样式变换
			button.removeClass("glyphicon glyphicon-triangle-top").addClass("glyphicon glyphicon-triangle-bottom");

			//订单列表 加入 退出动作
			list_table.addClass('animated flipOutX');

			//隐藏 订单列表 的 头部隐藏菜单（包含操作按钮）
			$(this).parents(".list_item_table_item_menu_div3").siblings(".list_item_table_item_menu_div2").find(".list_item_table_list_div").hide();

			//等待 订单列表 退出动作 完成
			window.setTimeout( 
				function(){
					//显示 订单列表 详细内容
					list_table.find(".list_item_table_tr_for_actions").show();

					///订单列表 加入 进入动作 ，并移除已用的无效动作类
					list_table.removeClass('animated flipOutX').addClass('animated flipInX');

					//等待 订单列表 进入动作 完成
					window.setTimeout( 
						function(){
							//移除已用的无效动作类
							list_table.removeClass('animated flipInX');
						}, 
						1000
					);
				}, 
				700
			);
		}
	});
	
	//监听移除按钮，触发移除订单操作 ==》针对已完成类型订单 （含后台）
	$(".order_remove_button").click(function(){
		//获取订单列表所在行（在show_list中的行数）
		var list = $(this).parents(".list_item_table").parent("td").parent("tr");

		//为订单列表所在行 加入 退出动作
		list.addClass('animated bounceOutRight');

		//等待动作完成
		window.setTimeout(
			function(){
				//隐藏订单列表所在行
				list.hide();

				//移除已完成的无效动作类
				list.removeClass('animated bounceOutRight');
			}, 
			600
		);

		//===================================后台代码===================================//
		
	});
}

//页面加载动画效果方案
function page_loading_animation_init(){
	//载入头部动画
	$("#header").addClass('animated slideInDown');
	//载入导航条动画
	$("#bar_menu_list").addClass("animated fadeInLeft");
	//载入订单列表动画
	$(".order_show").addClass('animated bounceInLeft');

	//等待动画完成
	window.setTimeout( 
		function(){
			//去除使用完的头部动画类
			$("#header").removeClass('animated slideInDown');
			//去除使用完的导航条动画
			$("#bar_menu_list").removeClass("animated fadeInLeft");
			//去除使用完的订单列表动画
			$(".order_show").removeClass('animated bounceInLeft');
		}, 
		1000
	);
}

//页面杂项设置初始化
function page_setting_iniit(){
	//设置加载页面时，防止主内容容器mainer内容太少底部footer上浮
    $("#mainer").css({"min-height":$(window).height() - 150 - $("#footer").outerHeight()});

	//导航栏随着滚动事件隐藏与显示,使用headroom.js插件
	$("#header").headroom();

	//监听窗口改变事件
    $(window).resize(function(){
        //窗口变化时设置  防止主内容容器mainer内容太少底部footer上浮
        $("#mainer").css({"min-height":$(window).height() - 150 - $("#footer").outerHeight()});
    });
}

function order_menu_init(){
	//默认选中未确认订单页
	//$("#order_unconfirmed").click();
	$("#order_unconfirmed").addClass("bg1");


	//订单类型菜单动态效果
	$(".order_type_menu button").addClass("animated");
	$(".order_type_menu button").hover(
		function(){
			t= $(this);
			if(t.hasClass('bg1')){
				t.addClass('pulse');
			}else {
				t.attr("color","#333")
				t.addClass('bg6 font_black pulse');
				// alert(t.attr("color","#333"));
			}
		},
		function(){
			t= $(this);
			if(t.hasClass('bg1')){
				//去掉所有动作
				t.removeClass('pulse rubberBand');
			}else {
				t.attr("color","#fff")
				t.removeClass('bg6 font_black pulse');
			}
		}
	);
	$(".order_type_menu button").click(function(){
		t = $(this);
		if(t.hasClass('bg1')){

		}else {
			t.siblings("button").removeClass('bg1 rubberBand');
			t.removeClass('bg6 font_black pulse').addClass('bg1 rubberBand')
			window.setTimeout( 
				function(){
					t.removeClass('rubberBand');
				}, 
				600
			);
		}
	});
}

function address_change_init(){
	var map = new BMap.Map("l-map");
	var province = "广东省";
	var ac;   //自动完成的对象

	// 初始化地图,设置城市和地图级别。
	map.centerAndZoom(province,13);

	//监听输入框的click事件
	$(".address_input").click(function(){
		//建立一个自动完成的对象
		ac = new BMap.Autocomplete({
		"input" : this
		,"location" : map
		});
	});


	//监听地址输入按钮，触发 地址查看 切换到 地址输入 的事件 ==》针对未确认类型订单
	$(".address_change_button_star").click(function(){

		//获取 地址查看的div
		var show_address = $(this).parents(".product_shipping_address_show");

		//获取地址修改的div
		var change_address = $(this).parents(".product_shipping_address_show").siblings(".product_shipping_address_change");

		//获取订单容器table
		var order_table = show_address.parents(".list_item_table");

		//获取地址输入框
		var address_input = change_address.find(".address_input");

		//获取显示的地址
		var address_text = show_address.children("span");
		
		//把显示的地址输入到地址输入框
		$(address_input).val($(address_text).text());

		//移除 地址查看的div 已完成的无效动作类  （防止上一动作未移除失效的动作类）（重点）
		show_address.removeClass('animated bounceIn')

		//地址查看的div 加入 退出动作
		show_address.addClass('animated bounceOut');

		//加入列退出动作
		order_table.find(".product_item_show").addClass("animated flipOutY");
		order_table.find(".product_item_price").addClass("animated flipOutY");
		order_table.find(".product_item_quantity").addClass("animated flipOutY");
		order_table.find(".product_total_price").addClass("animated flipOutY");

		//等待 地址查看的div 退出动作 完成
		window.setTimeout( 
			function(){
				//隐藏列
				order_table.find(".product_item_show").hide();
				order_table.find(".product_item_price").hide();
				order_table.find(".product_item_quantity").hide();
				order_table.find(".product_total_price").hide();


				order_table.find(".product_shipping_address").attr("min-width","915px");
				order_table.find(".product_shipping_address").width("915px");

				//去除列无效的动作类
				order_table.find(".product_item_show").removeClass("animated flipOutY");
				order_table.find(".product_item_price").removeClass("animated flipOutY");
				order_table.find(".product_item_quantity").removeClass("animated flipOutY");
				order_table.find(".product_total_price").removeClass("animated flipOutY");


				//隐藏 地址查看的div
				show_address.hide();

				//移除 地址查看的div 已完成的无效动作类
				show_address.removeClass('animated bounceOut');

				//使订单操作按钮不可用
				show_address.parents(".list_item_table").find(".order_sure_button").addClass('disabled');
				show_address.parents(".list_item_table").find(".order_delete_button").addClass('disabled');

				//显示 地址修改的div
				change_address.show();

				//地址修改的div 加入 进入动作
				change_address.addClass('animated bounceIn');

				//等待 地址修改的div 进入动作 完成
				window.setTimeout( 
					function(){
						//移除 地址修改的div 已完成的无效动作类
						change_address.removeClass('animated flipInX');
					}, 
					1000
				);
			}, 
			700
		);
	});

	//监听地址确定按钮，触发 地址输入 切换到 地址查看 的事件 ==》针对未确认类型订单
	$(".address_change_button_sure").click(function(){
		//获取 地址查看的div
		var show_address = $(this).parents(".product_shipping_address_change").siblings(".product_shipping_address_show");

		//获取 地址修改的div
		var change_address = $(this).parents(".product_shipping_address_change");

		//获取订单容器table
		var order_table = show_address.parents(".list_item_table");

		//获取地址输入框
		var address_input = change_address.find(".address_input");

		//获取地址显示span
		var address_text = show_address.children("span");


		//判断输入是否不为空，是则改变地址
		if(! address_input.val() == "" || ! address_input.val() == null){
			address_text.text(address_input.val());
		}

		$(this).siblings(".address_change_button_cancel").click();
		
	});

	//监听地址取消按钮，触发 地址输入 切换到 地址查看 的事件 ==》针对未确认类型订单
	$(".address_change_button_cancel").click(function(){
		//获取 地址查看的div
		var show_address = $(this).parents(".product_shipping_address_change").siblings(".product_shipping_address_show");

		//获取 地址修改的div
		var change_address = $(this).parents(".product_shipping_address_change");

		//获取订单容器table
		var order_table = show_address.parents(".list_item_table");

		//获取地址输入框
		var address_input = change_address.find(".address_input");

		//获取地址显示span
		var address_text = show_address.children("span");

		//移除 地址修改的div 已完成的无效动作类  （防止上一动作未移除失效的动作类）（重点）
		change_address.removeClass('animated flipInX');

		//地址修改的div 加入 退出动作
		change_address.addClass('animated bounceOut');

		//等待 地址修改的div 退出动作 完成
		window.setTimeout( 
			function(){

				//显示列
				order_table.find(".product_item_show").show();
				order_table.find(".product_item_price").show();
				order_table.find(".product_item_quantity").show();
				order_table.find(".product_total_price").show();

				//加入列退出动作
				order_table.find(".product_item_show").addClass("animated flipInY");
				order_table.find(".product_item_price").addClass("animated flipInY");
				order_table.find(".product_item_quantity").addClass("animated flipInY");
				order_table.find(".product_total_price").addClass("animated flipInY");

				order_table.find(".product_shipping_address").attr("min-width","300px");
				order_table.find(".product_shipping_address").width("300px");

				//隐藏 地址修改的div
				change_address.hide();

				//移除 地址修改的div 已完成的无效动作类
				change_address.removeClass('animated bounceOut');

				//使订单操作按钮可用
				change_address.parents(".list_item_table").find(".order_sure_button").removeClass('disabled');
				change_address.parents(".list_item_table").find(".order_delete_button").removeClass('disabled');

				//显示 地址查看的div
				show_address.show();

				//地址查看的div 加入 进入动作
				show_address.addClass('animated bounceIn');

				//等待 地址查看的div 进入动作 完成
				window.setTimeout( 
					function(){
						//移除 地址查看的div 已完成的无效动作类
						show_address.removeClass('animated bounceIn')


						//去除列无效的动作类
						order_table.find(".product_item_show").removeClass("animated flipInY");
						order_table.find(".product_item_price").removeClass("animated flipInY");
						order_table.find(".product_item_quantity").removeClass("animated flipInY");
						order_table.find(".product_total_price").removeClass("animated flipInY");
					}, 
					1000
				);
			}, 
			700
		);
	});

}

//返回顶部小部件初始化方法
function back_to_top_init(){
	$(".back_to_top").addClass("hidden_top");
	$(window).scroll(function () {
		if ($(this).scrollTop() === 0) {
			$(".back_to_top").addClass("hidden_top")
		} else {
			$(".back_to_top").removeClass("hidden_top")
		}
	});

	$('.back_to_top').click(function () {
		$('body,html').animate({scrollTop:0}, 1200);
		return false;
	});	
}

function GetOrderItem(ordid,ordaddress, Q){
	var url = '${ pageContext.request.contextPath }/orderItems_findByOrd_Id.action?ord_id='
				+ordid;
	var param = { };
	$.post(url,param,function(data){
		for(var i=0; i<data.orderItems_list.length; i++){
			//根据订单项商品id查找商品信息
			//alert("订单"+ ordid +"包含商品:"+data.orderItems_list[i].goods_id);
			//Todo根据商品id获取商品信息动态插入订单项
			var listsize = data.orderItems_list.length;
			insert_ordItem(i,ordid,ordaddress,data.orderItems_list[i].goods_id,
				data.orderItems_list[i].goods_num,listsize, Q);
		}
	});
	//Order_init();
}

//插入订单项 N2
function insert_ordItem(i,ordid,ordaddress,goods_id,goods_num,listsize, Q){	
	//订单按钮 根据 Q 显示不同
	var ord_button;
	if(Q=="Unconfirmed"){
		var ord_button = ["		<div class=\"list_item_table_list_div\">",
							"			<button class=\"btn btn-info btn-xs order_sure_button\">",
							"					<span class=\"glyphicon glyphicon-ok-circle\" aria-hidden=\"true\"></span>",
							"					确认",
							"			</button>",
							"			<button class=\"btn btn-danger btn-xs order_delete_button\">",
							"					<span class=\"glyphicon glyphicon-remove-circle\" aria-hidden=\"true\"></span>",
							"					取消",
							"			</button>",
							"		</div>"].join("");

	}else if(Q=="confirmed"){
		ord_button = ["		<div class=\"list_item_table_list_div\">",
					"			<button class=\"btn btn-success btn-xs order_pay_button display_none\">",
					"					<span class=\"glyphicon glyphicon-usd\" aria-hidden=\"true\"></span>",
					"					立即付款",
					"			</button>",
					"			<button class=\"btn btn-danger btn-xs order_delete_button\">",
					"					<span class=\"glyphicon glyphicon-remove-circle\" aria-hidden=\"true\"></span>",
					"					取消",
					"			</button>",
					"		</div>"].join("");
	}else if(Q=="paied"){
		ord_button = ["		<div class=\"list_item_table_list_div\">",
					"			<button class=\"btn btn-success btn-xs display_none\">",
					"					<span class=\"glyphicon glyphicon-usd\" aria-hidden=\"true\"></span>",
					"					已确认",
					"			</button>",
					"		</div>"].join("");
	}

	//alert("插入订单位置"+ordid+",商品"+goods_id+",商品数量"+goods_num);
	var url = '${ pageContext.request.contextPath }/goods_findByID.action?goods_id='
		+goods_id;
	var param = {};
	$.post(url,param,function(data){
		//返回商品信息
		//alert("购买图片:"+data.goods_pic+"，购买数量："+goods_num);
		//单件总价
		var sum_of_one = goods_num*data.goods_price;
		sum_of_one = sum_of_one.toFixed(2);
		//图片提取
		var pic_path = data.goods_pic.replace(/\\/g,"/");
		var pics =  pic_path.split(",");
		//商品对应url
		//var good_url = "product.jsp?key_word="+data.goods_name;
		//alert(data.goods_name);		

		var tl =document.getElementById("orditemtb"+ordid).rows.length;   		
		var t = document.getElementById("orditemtb"+ordid).insertRow(tl);
		//插入
		if(i==0){
			//第一行
			t.innerHTML = ["<tr class=\"list_item_table_tr_for_actions\">",
							"	<td class=\"product_item_show\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<img src=\""
							 + pics[0] + "\" class=\"list_img\">",
							"			<div class=\"product_item_show_text\">",
							"					<span>"
							 + data.goods_name + "</span><br>",							
							"			</div>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_item_price\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<span>"
							 + data.goods_price + "</span>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_item_quantity\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<span>"
							 + goods_num +"</span>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_total_price\" rowspan=\""
							 + listsize + "\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<span><b>"
							 + sum_of_one + "</b></span><br/>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_shipping_address\" rowspan=\""
							 + listsize + "\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<div class=\"product_shipping_address_show\">",
							"				<span>"
							 + ordaddress + "</span>",
							"				<br>",
							"				<button class=\"btn btn-info btn-xs address_change_button_star\">",
							"					<span class=\"glyphicon glyphicon-edit\" aria-hidden=\"true\"></span>",
							"					&nbsp;修改",
							"				</button>",
							"			</div>",
							"			<div class=\"product_shipping_address_change\" style=\"display: none;\">",
							"				<div class=\"input-group\">",
							"					",
							"					<div id=\"l-map\"></div>",
							"					<input type=\"text\" class=\"form-control address_input\"/>",
							"					<div class=\"input-group-addon\">",
							"						<button class=\"btn btn-success btn-sm address_change_button_cancel\">取消修改</button>",
							"						<button class=\"btn btn-info btn-sm address_change_button_sure\">确认修改</button>",
							"					</div>",
							"				</div>",
							"			</div>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_order_status\" rowspan=\""
							 + listsize + "\">",
							"		<div class=\"list_item_table_list_divtext-danger text-danger ordstate\">未确认</div>",
							"	</td>",
							"	<td class=\"product_order_operation\" rowspan=\""
							 + listsize + "\">"
							  + ord_button + 
							"	</td>",
							"</tr>"].join("");								
		}else{
			//非第一行
			t.innerHTML = ["<tr class=\"list_item_table_tr_for_actions\">",
							"	<td class=\"product_item_show\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<img src=\""
							 + pics[0] + "\" class=\"list_img\">",
							"			<div class=\"product_item_show_text\">",
							"					<span>"
							 + data.goods_name + "</span><br>",
							"			</div>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_item_price\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<span>"
							 + data.goods_price + "</span>",
							"		</div>",
							"	</td>",
							"	<td class=\"product_item_quantity\">",
							"		<div class=\"list_item_table_list_div\">",
							"			<span>"
							 + goods_num + "</span>",
							"		</div>",
							"	</td>",
							"</tr>"].join("");
			}

	});
}

//动态插入行 N1
function insert_ordRow(ordid, ordnum, ordtime, ordaddress){
	//alert("num"+ordnum+",time:"+ordtime+",address"+ordaddress);
	//Todo...插入订单
	//填充
	var t = document.getElementById("ordertb").insertRow(1);
	//alert("num"+ordnum+",time:"+ordtime+",address"+ordaddress);
	t.innerHTML = ["<tr>",
		"	<td>",
		"		<table id=\"orditemtb"
		 + ordid + "\" class=\"list_item_table bg5 actions1\">",
		"			<!-- 订单表格头部菜单及信息显示 -->",
		"			<tr class=\"list_item_table_heander_menu\">",
		"				<td colspan=\"7\" class=\"\">",
		"					<div class=\"list_item_table_item_menu\">",
		"						<div class=\"list_item_table_item_menu_div1\">",
		"							<input type=\"checkbox\" name=\"check_item\" value=\""
		+ ordid + "\" class=\"actions1\">",
		"						</div>",
		"						<div class=\"list_item_table_item_menu_div2\">",
		"							<div>",
		"								订单号：<span class=\"order_id\">"
		+ ordnum +"</span>",
		"							</div>",
		"							<div>",
		"								时间：<span class=\"order_time\">"
		+ ordtime + "</span>",
		"							</div>",
		"						</div>",
		"						<div class=\"list_item_table_item_menu_div3\">",
		"							<a class=\"table_show_control_button\"><span class=\"glyphicon glyphicon-triangle-bottom\" aria-hidden=\"true\"></span></a>",
		"						</div>",
		"					</div>",
		"				</td>",
		"			</tr>",
		"			<!-- 订单表格头部表头 -->",
		"			<tr class=\"list_item_table_heander list_item_table_tr_for_actions\">",
		"				<td class=\"product_item_show\">",
		"					<div class=\"list_item_table_list_div\">商品</div>",
		"				</td>",
		"				<td class=\"product_item_price\">",
		"					<div class=\"list_item_table_list_div\">单价</div>",
		"				</td>",
		"				<td class=\"product_item_quantity\">",
		"					<div class=\"list_item_table_list_div\">数量</div>",
		"				</td>",
		"				<td class=\"product_total_price\">",
		"					<div class=\"list_item_table_list_div\">金额</div>",
		"				</td>",
		"				<td class=\"product_shipping_address\">",
		"					<div class=\"list_item_table_list_div\">收货地址</div>",
		"				</td>",
		"				<td class=\"product_order_status\">",
		"					<div class=\"list_item_table_list_div\">订单状态</div>",
		"				</td>",
		"				<td class=\"product_order_operation\">",
		"					<div class=\"list_item_table_list_div\">订单操作</div>",
		"				</td>",
		"			</tr>",
		"		</table>",
		"	</td>",
		"</tr>"].join("");	
	
}