<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url(/tdd/jsp/back/js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css);</style>
<script type="text/javascript" src="/tdd/jsp/back/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="js/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="js/plupload/i18n/zh_CN.js"></script>
<script type="text/javascript">
// Convert divs to queue widgets when the DOM is ready
	$(function() {
		$("#uploader").pluploadQueue({
			// General settings
			runtimes : 'html5,flash,silverlight,html',
			url : 'FileUpload.action',
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
	        var uploader = $('#uploader').pluploadQueue();
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
	});
	
	
</script>
</head>

<body>
	<div>
		<div style="width: 750px; margin: 0px auto">
			<form id="formId" action="Submit.action" enctype="multipart/form-data" method="post">
				<div id="uploader">
					<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
				</div>
				<input type="submit" value="完成"/>
			</form>
		</div>
	</div>
</body>
</html>