
//分页参数
array = new Array();
page_id = 1;
page_size= 8;

//查询商品信息
function Get_Good(car_id,goods_id,goods_num,add_time){
    var url = '${ pageContext.request.contextPath }/goods_findByID.action?goods_id='
        +goods_id;
    var param = {};
    var result;

    //使用ajax的同步操作，避免未得到请求结果往下运行
    $.ajax({
        url:url,
        type: "POST",
        data: param,
        async:false,
		success:function (data) {
            //单件总价
            var sum_of_one = goods_num*data.goods_price;
            //把数字转换为字符串，结果的小数点后2位数的数字
            sum_of_one = sum_of_one.toFixed(2);

            //图片提取
            var pic_path = data.goods_pic.replace(/\\/g,"/");
            var pics =  pic_path.split(",");
            //商品对应url
            var good_url = "product.jsp?key_word="+data.goods_name;

            //要填充的文本
            result = data.goods_state != "0" ?
                ["<tr>",
                    "	<td>",
                    "		<table class=\"list_item_table bg5 actions1\">",
                    "			<tr>",
                    "				<td class=\"product_item_show\">",
                    "				    <div class=\"product_item_show_left\">",
                    "                   	<input type=\"checkbox\" name=\"check_item\" value=\""
                    + car_id +"\">",
                    "                   	<img src=\""
                    + pics[0] +
                    "\" class=\"list_img\">",
                    "                   </div>",
                    "                   <div class=\"product_item_show_right\">",
                    "                   	<ul>",
                    "                   		<li>"
                    + data.goods_name +"</li>",
                    "                   		<li>商品状态：<span>"
                    + add_time + "&nbsp;&nbsp;有效</span></li>",
                    "                   	</ul>",
                    "                   </div>",
                    "				</td>",
                    "				<td class=\"product_item_price\"><span>"
                    + data.goods_price + "￥</span></td>",
                    "				<td class=\"product_item_quantity\"><span>"
                    + goods_num + "</span></td>",
                    "				<td class=\"product_total_price\"><span><b>"
                    + sum_of_one + "￥</b></span></td>",
                    "				<td class=\"product_transaction_operation\">",
                    "					<button class=\"btn btn-danger btn-xs product_delete_button\">删除</button>",
                    "				</td>",
                    "			</tr>",
                    "		</table>",
                    "	</td>",
                    "</tr>"].join("")
                :
                ["<tr>",
                    "	<td>",
                    "		<table class=\"list_item_table bg5 actions1\">",
                    "			<tr>",
                    "				<td class=\"product_item_show\">",
                    "				    <div class=\"product_item_show_left\">",
                    "                   	<span class=\"font_ban glyphicon glyphicon-ban-circle\" aria-hidden=\"true\" value=\""
                    + car_id + "\"></span>",
                    "                   	<img src=\""
                    + pics[0] +
                    "\" class=\"list_img\">",
                    "                   </div>",
                    "                   <div class=\"product_item_show_right\">",
                    "                   	<ul>",
                    "                   		<li>"
                    + data.goods_name +"</li>",
                    "                   		<li>商品状态："
                    + add_time + " &nbsp;&nbsp;<span class=\"font_red2\">无效</span></li>",
                    "                   	</ul>",
                    "                   </div>",
                    "				</td>",
                    "				<td class=\"product_item_price\"><span>"
                    + data.goods_price + "￥</span></td>",
                    "				<td class=\"product_item_quantity\"><span>"
                    + goods_num + "</span></td>",
                    "				<td class=\"product_total_price\"><span><b>"
                    + sum_of_one + "￥</b></span></td>",
                    "				<td class=\"product_transaction_operation\">",
                    "					<button class=\"btn btn-default btn-xs product_delete_button\">移除</button>",
                    "				</td>",
                    "			</tr>",
                    "		</table>",
                    "	</td>",
                    "</tr>"].join("");
        }
    });
    // alert(result);
    return result;
}

//插入订单项，返回执行状态(1成功)
function insert_ord_Item(ord_id,shopcar_id){
	var url = '${ pageContext.request.contextPath }/orderItems_save.action'
	var param = {ord_id :ord_id, car_id :shopcar_id};
	//var insert_state = "0";
	$.post(url,param,function(data){
		//insert_state = data.Ori_state;
	});
	//return insert_state;
}

//商品项按钮初始化
function product_button_init() {
    //删除商品  监听product_delete_button的click方法
    $(".product_delete_button").click(function(){
        var list = $(this).parents(".list_item_table").parent("td").parent("tr");
        var list_id = $(this).parents(".list_item_table").find("[name = 'check_item']").val();
        console.log("删除商品操作");
        if(u_name!=null && u_name!="null"){
            list.addClass('animated bounceOutRight');
            //等待动作完成

            window.setTimeout(
                function(){
                    //隐藏商品所在行
                    list.hide();

                    //移除已完成的无效动作类
                    list.removeClass('animated bounceOutRight');
                },
                600
            );

            //===================================后台代码===================================//
            var url = '${ pageContext.request.contextPath }/ShopCar_delete.action?car_id='
                +list_id;
            var param = {};

            console.log("要删除的商品id：%s",list_id);

            //使用ajax的同步操作，避免未得到请求结果往下运行
            $.ajax({
                url:url,
                type: "POST",
                data: param,
                async:false,
                success:function () {
                    //从页面中删除
                    list.remove();
                    console.log("已删除的商品id：%s",list_id);
                }
            });
        }else {
            //设为用户未登录
            $("#account_button").text("我的账户");
            console.log("未登陆");
            //显示提醒div
            $("#remind_tr .remind_div h5").text("您未登录或登录失效  o_O")
            $("#remind_tr").show();
            //显示登录对话框
            show_login();
        }
    });
}

//单页列表初始化
function item_page_init() {
    var lower_bound = (page_id - 1) * page_size;
    var upper_bound = page_id* page_size;

    //判断是否超出上界
    if(upper_bound > array.length){
        for (var i = lower_bound; i < array.length; i++) {
            //填充
            var t = document.getElementById("product_show").insertRow(i + 2);
            t.innerHTML = array[i];
            console.log("rrrrrrrrr");
        }
        page_id = -1;
        console.log("超出上界，打印分页%d完毕%d",lower_bound,array.length);
        array = null;
    }else{
        for (var i = lower_bound; i < upper_bound; i++) {
            //填充
            var t = document.getElementById("product_show").insertRow(i + 2);
            t.innerHTML = array[i];
            console.log("插在第%d行,内容为=========》%s",i + 2,array[i]);
        }
        page_id ++;
        console.log("打印分页%d完毕%d",lower_bound,array.length);
    }
    //商品项按钮初始化
    product_button_init();
    iCheck_init();
}

//加载分页，并显示
function loading_page() {
    shopcar_list_init();
    //待插入内容数组是否为空
    if(page_id == -1){
        //do nothing
        console.log("array数组打印完%d",page_id);

        //移除加载图案
        $("#loading_tr").remove();
    }else{
        item_page_init();
        console.log("调用分页加载完毕");

        //隐藏加载图案
        $("#loading_tr").hide();
    }
}

//商品列表总查询，并生成数组
function shopcar_list_init() {
    var url = '${ pageContext.request.contextPath }/user_getShopCart.action?user_id='
        +u_id;
    var param = {};

    //使用ajax的同步操作，避免未得到请求结果往下运行
    $.ajax({
        url:url,
        type: "POST",
        data: param,
        async:false,
        success:function (data) {
            var shopcar_list = data.ShopCarList;

            console.log("已登录，购物车不为空，隐藏提醒面板");
            $("#remind_tr").hide();

            for (var i = 0; i < shopcar_list.length; i++) {
                //逐条调用购物车项
                array[i] = Get_Good(shopcar_list[i].car_id,shopcar_list[i].goods_id,shopcar_list[i].goods_num,shopcar_list[i].car_createtime);
            }
        }
    });
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

//页面加载动画效果方案
function page_loading_animation_init(){
    //载入头部动画
    $("#header").addClass('animated slideInDown');
    //载入导航条动画
    $("#bar_menu_list").addClass("animated fadeInLeft");
    //载入订单列表动画
    $("#product_show").addClass('animated bounceInLeft');
    //载入底部动画
    $("#footer").addClass("animated slideInUp");

    //等待动画完成
    window.setTimeout(
        function(){
            //去除使用完的头部动画类
            $("#header").removeClass('animated slideInDown');
            //去除使用完的导航条动画
            $("#bar_menu_list").removeClass("animated fadeInLeft");
            //去除使用完的订单列表动画
            $("#product_show").removeClass('animated bounceInLeft');
            //去除使用完的底部动画
            $("#footer").removeClass("animated slideInUp");
        },
        1000
    );
}

//状态判断并调用方法
function state_judge() {
    if(u_name==null || u_name=="null") {
        console.log("未登陆");
        //设为用户未登录
        $("#account_button").text("我的账户");
        //显示登录对话框
        show_login();
        //显示提醒div
        $("#remind_tr .remind_div h5").text("您未登录或登录失效  o_O")
        $("#remind_tr").show();
    }else {
        if(shopCar == "1"){
            console.log("已登陆，购物车不为空");
            //设用户名到用户按钮
            $("#account_button").text("欢迎您," + u_name);
            //隐藏提醒div
            $("#remind_tr").hide();

            //商品列表初始化
            shopcar_list_init();
        }else {
            console.log("已登陆，购物车为空");
            //设用户名到用户按钮
            $("#account_button").text("欢迎您," + u_name);
            //显示提醒div
            $("#remind_tr .remind_div h5").text("您的购物车空空如也  ( + _ + )")
            $("#remind_tr").show();
        }
    }
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

//批量操作按钮初始化
function batch_button_init(){
    //批量删除 监听checkall的click方法
    $("#batch_delete_button").click(function () {
        //获取被选中的商品checkbox
        var check_item = $("[name='check_item']:checked");
        //获取被选中的商品列表的删除按钮，形成数组
        var delete_button_array = $(check_item).parents(".list_item_table").find(".product_delete_button");
        console.log("商品列操作");
        if(u_name!=null && u_name!="null"){
            //按钮数组执行click(),延迟效果
            (function myLoop (i) {
                setTimeout(function () {
                    delete_button_array[delete_button_array.length - i].click();
                    console.log("商品列  %d  执行click操作",delete_button_array.length - i);
                    if (--i) myLoop(i);      //  decrement i and call myLoop again if i > 0
                }, 70)
            })(delete_button_array.length);
        }else {
            //设为用户未登录
            $("#account_button").text("我的账户");
            console.log("未登陆");
            //显示提醒div
            $("#remind_tr .remind_div h5").text("您未登录或登录失效  o_O")
            $("#remind_tr").show();
            //显示登录对话框
            show_login();
        }

    });

    //生成订单 监听create_order_button的click方法
    $("#create_order_button").click(function () {
        //获取被选中的商品checkbox
        var check_item_val = $("[name='check_item']:checked").val();
        if(u_name!=null && u_name!="null"){
            if(check_item_val.length == 0) {
                //无选中商品
                alert("无选中商品");
            }else {
                var url = '${ pageContext.request.contextPath }/orders_save.action?u_id='
                    + u_id;
                var param = {};
                //使用ajax的同步操作，避免未得到请求结果往下运行
                $.ajax({
                    url:url,
                    type: "POST",
                    data: param,
                    async:false,
                    success:function (data) {
                        // alert("返回订单号:"+data.OrdNum+",返回订单id"+data.Ord_id);

                        //逐条添加订单项（传入订单id，购物车id）后台执行生成订单
                        for (var i = 0; i < check_item_val.length; i++) {
                            //alert("传入添加订单项，购物车id"+check_val[i]);
                            insert_ord_Item(data.Ord_id,check_item_val[i]);
                        }
                        //移除多项购物车
                        $("#batch_delete_button").click();
                        alert("订单项添加成功.");
                }
                });
            }
        }else {
            //设为用户未登录
            $("#account_button").text("我的账户");
            console.log("未登陆");
            //显示提醒div
            $("#remind_tr .remind_div h5").text("您未登录或登录失效  o_O")
            $("#remind_tr").show();
            //显示登录对话框
            show_login();
        }

    });
}

//页面初始化基本设置
function page_setting_init() {
    //防止主内容容器mainer内容太少底部footer上浮
    $("#mainer").css({"min-height":$(window).height() - 150 - $("#footer").outerHeight()});

    $(window).resize(function(){
        //窗口变化时设置  防止主内容容器mainer内容太少底部footer上浮
        $("#mainer").css({"min-height":$(window).height() - 150 - $("#footer").outerHeight()});
    });

    //导航栏随着滚动事件隐藏与显示,使用headroom.js插件
    $("#header").headroom();

    $("#account_button").click(function () {
        if(u_name==null || u_name=="null") {
            //设为用户未登录
            $("#account_button").text("我的账户");
            //显示登录对话框
            show_login();
            //显示提醒div
            $("#remind_tr .remind_div h5").text("您未登录或登录失效  o_O")
            $("#remind_tr").show();
        }
    });

    //login_button提交表单时的click方法
    $("#login_button").click(function(){
        //判断表单验证是否成功
        if($('#login_form').valid()) {
            // 后台代码...
            //alert("登录");
            var login_url = '${ pageContext.request.contextPath }/user_login.action';
            var login_user = $("#user_name").val();
            var login_pwd =$("#user_pwd").val();
            //alert(login_user+login_pwd);
            var Order_Q = "Unconfirmed";
            var param = {user_name :login_user,user_pwd:login_pwd,Order_Q:Order_Q};
            // alert("正在跳转...");
            //使用ajax的同步操作，避免未得到请求结果往下运行
            $.ajax({
                url:login_url,
                type: "POST",
                data: param,
                async:false,
                success:function (data) {
                    if(data.LoginState == "1"){
                        //设为用户名
                        $("#account_button").text("欢迎您," + login_user);

                        //赋值
                        shopCar = data.ShopcarList;
                        u_name = data.User.user_name;
                        u_id = data.User.user_id;
                        //隐藏提醒div
                        $("#remind_tr").hide();
                        hide_login();

                        //状态判断并调用方法
                        state_judge();
                    }else{
                        alert(">.<登录失败，请重试用户名或者密码。");
                        //输入值设为空
                        $("#user_name").val("");
                        $("#user_pwd").val("");
                    }

                }
            });

        }else {
            //触发表单所有输入框失去焦点事件，以达到显示错误信息的目的
            $('#login_form').find('input').blur();
        }
    });

    //监听滚动事件，加载列表
    window.onscroll = function(){
        var t = document.documentElement.scrollTop || document.body.scrollTop;  //离上方的距离
        var h =window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight; //可见宽度
        if( t >= document.documentElement.scrollHeight -h ) {
            //显示加载图案
            $("#loading_tr").show();
            loading_page();
            console.log("done loading_page");
        }
    }

    //隐藏加载图案
    $("#loading_tr").hide();

    //返回顶部小部件初始化方法
    back_to_top_init();

    //批量操作按钮初始化
    batch_button_init();
}


