package com.tdd.web.action;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.tdd.domain.Goods;
import com.tdd.service.GoodsService;
import com.tdd.service.ShopCarService;
import com.tdd.utils.FastJsonUtil;

public class GoodsAction extends ActionSupport implements ModelDriven<Goods> {

	private Long goodid;
	
	public Long getGoodid() {
		return goodid;
	}
	public void setGoodid(Long goodid) {
		this.goodid = goodid;
	}
	
	private String good_key_word;
	public String getGood_key_word() {
		return good_key_word;
	}
	public void setGood_key_word(String good_key_word) {
		this.good_key_word = good_key_word;
	}
	
	private Long cat_id;
	public Long getCat_id() {
		return cat_id;
	}
	public void setCat_id(Long cat_id) {
		this.cat_id = cat_id;
	}

	// 把文件上传本地路径  远程："http://119.29.178.156:22/Tdd/goodsImg/";
	public final String FILEPATH ="F:\\JEE_Project\\WS_ssh\\tdd\\WebContent\\jsp\\front\\image\\product\\";
	// 缓存大小
	//plupload 属性
	private int id = -1;
	//private File file;
	private String name;
	private int chunk;
	private int chunks;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getChunk() {
		return chunk;
	}

	public void setChunk(int chunk) {
		this.chunk = chunk;
	}

	public int getChunks() {
		return chunks;
	}

	public void setChunks(int chunks) {
		this.chunks = chunks;
	}

	private static final long serialVersionUID = 3809457198171840741L;

	private Goods good = new Goods();
	
	public Goods getModel() {
		return good;
	}
	
	private GoodsService goodsService;
	public void setGoodsService(GoodsService goodsService) {
		this.goodsService = goodsService;
	}
	
	private ShopCarService shopCarService;
	public void setShopCarService(ShopCarService shopCarService) {
		this.shopCarService = shopCarService;
	}

	//分页
	private String rows;//传入每页显示的记录数  
    
    private String page;//传入当前第几页  
	
	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	//分页查找
	public String findByPage(){
		//统计所有数据行数
		int allcount = goodsService.findAll().size();
		
		DetachedCriteria criteria = DetachedCriteria.forClass(Goods.class);
		//默认当前页1  
        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
        //默认每页显示条数10  
        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
        
        //获取当前页数据
        List<Goods> rows = goodsService.findByPage(intPage,number,criteria);
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
		jsonMap.put("total", allcount);
		jsonMap.put("rows", rows);
		//System.out.println("jsonMap__________\n"+jsonMap);

		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(jsonMap);
		//System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}
	
	//ID查找商品
	public String findByID(){
		good = goodsService.findById(good.getGoods_id());
		//jsonMap.put("Getgood", good);
		// 数据转换成json传给前台
		String jsonString = FastJsonUtil.toJSONString(good);
		//System.out.println("jsonString__________:\n"+jsonString);
		HttpServletResponse response = ServletActionContext.getResponse();
		FastJsonUtil.write_json(response, jsonString);
		return NONE;
	}
	
	//商品查找
	public String findByName(){
		DetachedCriteria criteria = DetachedCriteria.forClass(Goods.class);
		System.out.println("查询关键字：______________" + good_key_word);
		if (good_key_word != null && !good_key_word.isEmpty()) {
			//传入关键字
			criteria.add(Restrictions.like("goods_name", "%"+good_key_word+"%"));
			System.out.println("分类id" + cat_id);
			//分类查询
			//criteria.add(Restrictions.eq("cat_id", cat_id));
			
			//默认当前页1  
	        int intPage = Integer.parseInt((page == null || page == "0") ? "1":page);  
	        //默认每页显示条数10  
	        int number = Integer.parseInt((rows == null || rows == "0") ? "10":rows);  
			
			List<Goods> rows = goodsService.findByPage(intPage, number, criteria);
			//统计所有数据行数
	  		int allcount = rows.size();
			Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
			jsonMap.put("total", allcount);
			jsonMap.put("rows", rows);

			// 数据转换成json传给前台
			String jsonString = FastJsonUtil.toJSONString(jsonMap);
			//System.out.println("jsonString__________:\n"+jsonString);
			HttpServletResponse response = ServletActionContext.getResponse();
			FastJsonUtil.write_json(response, jsonString);
			
		}
		return NONE;
	}
	
	//提取图片
	public String[] getImgs(String s){
		String[] imgs = s.split(",");
		return imgs;
	}
	
	
	/*
	 * 文件操作
	 */
	
	/*
	 *	文件上传：定义成员属性，命名要有特定规则
	 * 	File goods_pic; 上传文件 
	 * 	String goods_picFileName; 上传文件名 
	 * 	String goods_picContentType;	上传文件类型
	 */
	private File upload;
	private String uploadFileName;
	private String uploadContentType;
	
	public void setUpload(File upload) {
		this.upload = upload;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	
	public String save(){
		//有图片上传
		/*if (this.getName()!=null) {
			System.out.println("添加用户：上传________");
			//图片上传，路径更新
			String dstPath = FILEPATH + good.getGoods_id()+ "\\" + this.getName();
			
			System.out.println("目标地址_____:" + dstPath);
			
			File dstFile = new File(dstPath);

			good.setGoods_pic(dstPath);
			System.out.println("新图路径："+dstPath);

			try {
				FileUtils.copyFile(upload, dstFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			System.out.println("上传文件:" + uploadFileName + " 临时文件名：" + uploadContentType + " "
					+ chunk + " " + chunks);
			if (chunk == chunks - 1) {
				// 完成一整个文件;
			}
			//写入数据库，路径传给jsp回显设置
			System.out.println("回显地址：____________" + good.getGoods_pic());
		}*/
		
		goodsService.save(good);
		return "add";
	}
	
	public String delete(){
		//获取jsp传递删除id
		System.out.println("delete_________id:" + good.getGoods_id());
		good = goodsService.findById(good.getGoods_id());
		//删除置失效，图片保留
		/*if (good.getGoods_pic()!=null) {
			// 先删除旧的图片
			String oldFilepath = good.getGoods_pic();
			if(oldFilepath != null && !oldFilepath.trim().isEmpty()){
				System.out.println("_______文件路径:" +oldFilepath);
				String []pre_path = oldFilepath.split(",");
				System.out.println("分割数组____________:"+pre_path);
				for (String del_path : pre_path) {
					System.out.println("遍历删除文件____________:"+del_path);
					// 说明，旧的路径存在的，删除图片
					File f = new File(del_path);
					f.delete();
				}
				//图片父文件夹
				String del_path = FILEPATH + good.getGoods_id();
				System.out.println("删除文件夹____________:"+del_path);
				//删除文件夹
				File par_f = new File(del_path);
				par_f.delete();
			}
		}*/
		//good.setGoods_pic(null);
		//隐式删除
		good.setGoods_state('0');
		goodsService.update(good);
		//goodsService.delete(good);
		
		//级联把包含商品购物车设置无效
		shopCarService.delete_goods(good.getGoods_id());
		
		return "delete";
	}
	
	//传入good对象 除了pic要传入(upload)文件进行设置，其他属性自动封装
	public String update(){		
		/*// 判断，说明客户上传了新的图片
		if(uploadFileName != null){
			String oldFilepath = good.getGoods_pic();
			// 先删除旧的图片
			if(oldFilepath != null && !oldFilepath.trim().isEmpty()){
				System.out.println("旧图片地址______："+oldFilepath);
				// 说明，旧的路径存在的，删除图片
				File f = new File(oldFilepath);
				f.delete();
			}
			// 上传新的图片
			// 先处理文件的名称的问题
			String uuidname = UploadUtils.getUUIDName(uploadFileName);
			File file = new File(FILEPATH + good.getGoods_id() + "\\"+uuidname);
			try {
				FileUtils.copyFile(upload, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			System.out.println("新图片______："+FILEPATH+uuidname);
			// 把客户新图片的路径更新到数据库中
			good.setGoods_pic(FILEPATH+uuidname);
		}*/
		System.out.println("当前更新图片地址______________:"+good.getGoods_pic());
		goodsService.update(good);
		//如果商品修改为无效，级联更新购物车
		if(good.getGoods_state()=='0'){
			shopCarService.delete_goods(good.getGoods_id());
		}
		return "update";
	}
	
	public String picsUpload(){
		//获取jsp传递插入图片对象id
		System.out.println("添加图片_________id:" + good.getGoods_id());
		//根据id获取对象以及旧路径
		good = goodsService.findById(good.getGoods_id());
		String oldpath = good.getGoods_pic();
		//图片上传，路径更新
		//绝对路径
		String dstPath = FILEPATH + good.getGoods_id()+ "\\" + this.getName();
		//相对路径
		String rela_path = "image\\product\\";
		rela_path = rela_path + good.getGoods_id()+ "\\" + this.getName();
		
		System.out.println("目标地址_____:" + dstPath+",相对路径_____:"+rela_path);
		
		File dstFile = new File(dstPath);
		
		//有文件夹存在，且上传文件不同名
		if (oldpath != null && !oldpath.trim().isEmpty() && !dstFile.exists()) {
			String new_path = oldpath.trim()+","+rela_path;
			good.setGoods_pic(new_path);
			System.out.println("新增路径："+new_path);
		}else if(!dstFile.exists()){
			good.setGoods_pic(rela_path);
			System.out.println("新图路径："+rela_path);
		}

		// 文件已存在（上传了同名的文件）
		if (chunk == 0 && dstFile.exists()) {
			dstFile.delete();
			dstFile = new File(dstPath);
		}

		try {
			FileUtils.copyFile(upload, dstFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("上传文件:" + uploadFileName + " 临时文件名：" + uploadContentType + " "
				+ chunk + " " + chunks);
		if (chunk == chunks - 1) {
			// 完成一整个文件;
		}
		//写入数据库，路径传给jsp回显设置
		System.out.println("回显地址：____________" + good.getGoods_pic());
		
		goodsService.update(good);
		return "picsUpload";
	}
	
	//Get newpicpath（批量上传图片后回显到修改框）
	public String writeBackdiv(){
        System.out.println("修改图片商品id________________________"+goodid);
		// 调用业务层
		Goods g = goodsService.findById(goodid);
		
		// 使用fastjson，把list转换成json字符串
		String jsonString = FastJsonUtil.toJSONString(g);
		// 把json字符串写到浏览器
		HttpServletResponse response = ServletActionContext.getResponse();
		// 输出
		FastJsonUtil.write_json(response, jsonString);
		
		return NONE;
	}
	
	
	public String save_test(){
		Goods good = new Goods();
		good.setGoods_name("老干妈");
		good.setGoods_price(20.5f);
		good.setGoods_state('1');
		good.setGoods_inventory(6773);
		good.setCat_id(6L);
		good.setGoods_detail("经典佐料，配合雪糕体验更佳。");
		
		goodsService.save(good);
		return NONE;
	}
	

}
