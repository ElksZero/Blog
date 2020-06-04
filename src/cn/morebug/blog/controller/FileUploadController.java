package cn.morebug.blog.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.morebug.blog.bean.UserVo;
import net.sf.json.JSONObject;

@Controller
public class FileUploadController {
	
	@ResponseBody
	@RequestMapping(value="uploadImg",method=RequestMethod.POST)
	public JSONObject uploadImg(HttpServletRequest request,@RequestParam(value="editormd-image-file" ,required=false)MultipartFile img) throws IOException{
		//真实的项目地址
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ request.getContextPath() + "/";
		//为每个用户设置一个单独的文件夹存储图片
		UserVo userVo = (UserVo)request.getSession().getAttribute("userVo");
		
		JSONObject json = new JSONObject();
		//图片上传目的路径//即图片存储位置
		String uploadPath = request.getServletContext().getRealPath("upload/editormdImg/" + userVo.getUsername());
		//如果文件夹不存在，则创建
		File fileDir = new File(uploadPath);
		if(!fileDir.exists()) {
			fileDir.mkdirs();
		}
		
		// 目的文件
        File realFile = new File(uploadPath + File.separator + img.getOriginalFilename());
        InputStream is = img.getInputStream();
        BufferedOutputStream os = new BufferedOutputStream(new FileOutputStream(realFile));
        byte[] bytes = new byte[1024];
        int realLength = 0;
        while((realLength = is.read(bytes, 0, 1024))!= -1) {
        	os.write(bytes, 0, realLength);
        }
		json.put("success", 1);
		json.put("message", "上传成功");
		json.put("url", basePath +"upload/editormdImg/" + userVo.getUsername() + "/" +img.getOriginalFilename());
		return json;
	}
}
