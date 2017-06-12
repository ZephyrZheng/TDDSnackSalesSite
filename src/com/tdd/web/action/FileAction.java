package com.tdd.web.action;


import java.io.*;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class FileAction extends ActionSupport {

	private static final long serialVersionUID = 113695314694166436L;

	private static final int BUFFER_SIZE = 2 * 1024;

	// 把文件上传本地路径
	public final String FILEPATH ="E:\\Study\\tomcat\\apache-tomcat-9.0.0.M13\\webapps\\upload_test\\";
	
	private int id = -1;

	private File file;
	private String name;
	private List<String> names;
	private String fileFileName;
	private String fileContentType;
	private String savePath;
	private int chunk;
	private int chunks;

	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setNames(List<String> names) {
		this.names = names;
	}

	public List<String> getNames() {
		return names;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
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

	private String result;

	public void setResult(String result) {
		this.result = result;
	}

	public String getResult() {
		return result;
	}

	private void copy(File src, File dst) {
		InputStream in = null;
		OutputStream out = null;
		try {
			if (dst.exists()) {
				out = new BufferedOutputStream(new FileOutputStream(dst, true),
						BUFFER_SIZE);
			} else {
				out = new BufferedOutputStream(new FileOutputStream(dst),
						BUFFER_SIZE);
			}
			in = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);

			byte[] buffer = new byte[BUFFER_SIZE];
			int len = 0;
			while ((len = in.read(buffer)) > 0) {
				out.write(buffer, 0, len);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (null != in) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public String upload() throws Exception {

		String dstPath = FILEPATH + this.getName();
		
		System.out.println("目标地址_____:" + dstPath);
		
		File dstFile = new File(dstPath);

		// 文件已存在（上传了同名的文件）
		if (chunk == 0 && dstFile.exists()) {
			dstFile.delete();
			dstFile = new File(dstPath);
		}

		copy(file, dstFile);
		
		System.out.println("上传文件:" + fileFileName + " 临时文件名：" + fileContentType + " "
				+ chunk + " " + chunks);
		if (chunk == chunks - 1) {
			// 完成一整个文件;
		}

		return SUCCESS;
	}

	public String submit() {
		String filePath = ServletActionContext.getServletContext().getRealPath(
				this.getSavePath());
		System.out.println("保存文件路径： " + filePath);
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		result =  "";
		int count = Integer.parseInt(request.getParameter("uploader_count"));
		for (int i = 0; i < count; i++) {
			fileFileName = request.getParameter("uploader_" + i + "_name");
			name = request.getParameter("uploader_" + i + "_tmpname");
			System.out.println(fileFileName + " " + name);
			try {
				//do something with file;
				result += fileFileName + "导入完成. <br />";  
			} catch(Exception e) {
				result += fileFileName + "导入失败:" + e.getMessage() + ". <br />";
				e.printStackTrace();
			}
		}
		return SUCCESS;
	}



}