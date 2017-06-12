
//登录对话框初始化方法
function login_dialog_init(){
	//获取登录对话框
	var login_modal = $('#login_modal');
	//获取登录对话框的显示框
	var modal_dialog = login_modal.find('.modal-dialog');
	//获取错误提醒框
	var waring_dialog = $('.waring_dialog');

	//设置加载页面时，错误提示框隐藏
	waring_dialog.hide();

	//登录表单验证器
	$("#login_form").validate({
		//失去焦点触发
	    onfocusout: function(element) {
	    	//判断是否验证成功
	        if ($(element).valid()) {
	        	//错误提示框移出
	            $(element).siblings(".waring_dialog").fadeOut();
	            //去掉输入框边款代表输入错误的边框样式
	            $(element).removeClass("border_danger");
	            //加上输入框边款代表输入正确的边框样式
	            $(element).addClass('border_success');
	        }else {
	        	//错误提示框进入
	            $(element).siblings(".waring_dialog").fadeIn();
	            //去掉输入框边款代表输入正确的边框样式
	            $(element).removeClass('border_success');
	            //加上输入框边款代表输入错误的边框样式
	            $(element).addClass('border_danger');
	        }
	    },
	    //键盘输入停止触发
	    onkeyup: function(element) {
	    	//判断是否验证成功
	        if ($(element).valid()) {
	        	//错误提示框移出
	            $(element).siblings(".waring_dialog").fadeOut();
	            //去掉输入框边款代表输入错误的边框样式
	            $(element).removeClass("border_danger");
	            //加上输入框边款代表输入正确的边框样式
	            $(element).addClass('border_success');
	        }else {
	        	//错误提示框进入
	            $(element).siblings(".waring_dialog").fadeIn();
	            //去掉输入框边款代表输入正确的边框样式
	            $(element).addClass('border_danger');
	            //加上输入框边款代表输入错误的边框样式
	            $(element).removeClass('border_success');
	        }
	    },
	    //定义校验规则
	    rules:{
	        user_name:{
	            required:true,
	            maxlength:21
	        },
	        user_pwd:{
	            required:true,
	            maxlength:9
	        }
	    },
	    //定义错误显示信息
	    messages:{
	        user_name:{
	            required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;用户名不能为空！",
	            maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;用户名长度不能超过21位！"
	        },
	        user_pwd:{
	            required:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;密码不能为空！",
	            maxlength:"出错啦&nbsp;&nbsp;( *>﹏<* )&nbsp;&nbsp;&nbsp;&nbsp;密码不能超过9位！"
	        }
	    },
	    //定义错误信息放置位置
	    errorPlacement: function(error, element) {
	    	//error代表错误显示的类，element代表输入框，把error赋予显示位置
	        error.appendTo( element.siblings(".waring_dialog").children("span"));
	    },
	    //单个校验成功时调用
	    success: function(label) {//label代表错误信息显示的位置
	    	//获取输入框
	    	var a = label.parents(".waring_dialog").siblings("input");
	    	//去掉错误信息error类
	    	$(label).removeClass('error');	
	    	//值设为空
	    	$(label).val("");
	        a.removeClass('border_danger');
	        a.addClass('border_success');
	    },
	    //debug模式，用于调试，不提交表单，可运行
	    // debug:true
	});

	//监听窗口改变，并设置登录对话框水平垂直居中
	$(window).resize(function(){
		//设置对话框位置水平垂直居中
		modal_dialog.css({
			//设置垂直居中
			'margin-top': Math.max(0, ($(window).height() - modal_dialog.outerHeight()) / 2),
			//设置水平居中
			'margin-left': Math.max(0, ($(window).width() - 500) / 2)
		});
	});

    //监听登录对话框的显示事件，在事件执行时执行此代码，设置加载时登录对话框水平垂直居中显示
	login_modal.on('show.bs.modal', function(){
		// 关键代码，如没将modal设置为 block，则$modala_dialog.height() 为零
		$(this).css('display', 'block');
		modal_dialog.css({
			'margin-top': Math.max(0, ($(window).height() - modal_dialog.outerHeight()) / 2),
			'margin-left': Math.max(0, ($(window).width() - 500) / 2)
		});
	});


	//点击错误提示框的关闭按钮时的动画
	$(".waring_dialog button").click(function(){
		//错误对话框移除
	    $(this).parent(".waring_dialog").fadeOut();
	});

	//login_button提交表单时的click方法
	$("#login_button").click(function(){
		//判断表单验证是否成功
	    if($('#login_form').valid()) {
	    	//get Login value
			var login_user = document.getElementById('user_name').value;
			var login_pwd = document.getElementById('user_pwd').value;

	        // Todo...
	        var login_url = '${ pageContext.request.contextPath }/user_login.action';

			//alert(login_user+login_pwd);
			var Order_Q = "Unconfirmed";
			var param = {user_name :login_user,user_pwd:login_pwd,Order_Q:Order_Q};
			
			//alert("用户密码："+login_user+login_pwd);
			
			$.post(login_url,param,function(login_return){
				if(login_return.LoginState=="1"){
					//alert(login_return.User.user_name);				
					//alert("登录成功,正在跳转。。。");
					location.reload();
					
				}else{
					alert(">.<登录失败，请重试用户名或者密码。");
					show_login();
					//closeDiv();
				}
				
			}); 
			//关闭输入框
			//closeDiv();

	    }else {
	    	//触发表单所有输入框失去焦点事件，以达到显示错误信息的目的
	        $('#login_form').find('input').blur();
	    }
	});
}

//显示登录对话框
function show_login(){
	$("#login_modal").modal({backdrop: 'static'});
}
//隐藏登录对话框
function hide_login(){
	$("#login_modal").modal('hide');
}