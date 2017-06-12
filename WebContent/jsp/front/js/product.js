/* 初始化 */

var key_word="";

function load()
{//发送请求获取数据，填充页面
	//alert("#$@#$");
	//$('#Search_goods').val();
	//alert('搜索关键词'+key_word);
	//var key_word = "达利园蛋黄派";
	if(key_word!=null&&key_word!=""){
		var url = '${ pageContext.request.contextPath }/goods_findByName.action?good_key_word='
			+key_word;
		var param = {};
		$.post(url,param,function(data){
			//alert("请求返回数据");
			//alert(data.rows[0].goods_name);
			//http://stackoverflow.com/questions/10084234/how-to-parse-multi-dimensional-json-data-through-javascript
			document.getElementById("g_detail").innerHTML = data.rows[0].goods_detail;
			document.getElementById("g_inventory").innerHTML = data.rows[0].goods_inventory;
			document.getElementById("h_name").innerHTML = data.rows[0].goods_name;
			document.getElementById("n_price").innerHTML = data.rows[0].goods_price;
			document.getElementById("o_price").innerHTML = data.rows[0].goods_price+3;
			//Todo..异步请求填充分类
			Get_category(data.rows[0].cat_id);
			
			var rel_path = data.rows[0].goods_pic;
			rel_path = rel_path.replace(/\\/g,"/");
			//alert(rel_path);
			var pics =  rel_path.split(",");
			//for(var i=0; i<pics.length; i++) alert(pics[i]);
			//图片更新
			$("#g_img_1").attr("src", pics[0]); 
			$("#g_img_1").attr('data-zoom-image', pics[0]);
			$("#good_a0").attr('data-image', pics[0]);
			document.getElementById("gth_0").src = pics[0];
			
			$("#good_a1").attr('data-image', pics[1]);
			document.getElementById("gth_1").src = pics[1];
			
			$("#good_a2").attr('data-image', pics[2]);
			document.getElementById("gth_2").src = pics[2];
			
			$("#good_a3").attr('data-image', pics[3]);
			document.getElementById("gth_3").src = pics[3];
			
		});
	}
	
	
}

function Get_category(cat_id){
	//alert("分类id:___"+cat_id);
	var cat_url = '${ pageContext.request.contextPath }/Category_findById.action?cat_id='
		+cat_id;
	var param = {};
	$.post(cat_url,param,function(cat_data){
		//alert(cat_data);
//		alert(cat_data.Cat_parent);
//		alert(cat_data.Cat_name);		
		document.getElementById("cat_par").innerHTML = cat_data.Cat_parent;
		document.getElementById("cat_name").innerHTML = cat_data.Cat_name;
	});
}


function g_search(){
	var good = document.getElementById("inputbox").value;
	alert(good);
	key_word = good;
	load();
	//location.reload();
	//load();
	//onload(good);
}

function test(){
	alert("test");
}