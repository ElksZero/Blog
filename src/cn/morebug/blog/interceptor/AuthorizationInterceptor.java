package cn.morebug.blog.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.morebug.blog.bean.UserVo;
//权限拦截器
public class AuthorizationInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		response.setContentType("text/html; charset=utf-8");
		UserVo userVo = (UserVo)request.getSession().getAttribute("userVo");
		//获取请求URI
		String requestURI = request.getRequestURI();
		String requestIP = request.getRemoteAddr();
		System.out.println("IP:" + requestIP + " 请求地址："+ requestURI);
		
		if(userVo == null) {
			request.getRequestDispatcher("/nopass").forward(request, response);
			return false;
		}
		boolean flag = true;
		//写作
		if(userVo.getAuthorization().getWrite() != 1 && requestURI.contains("myArticleManage")) {
			flag = false;
		}
		if(userVo.getAuthorization().getWrite() != 1 && requestURI.contains("edit")) {
			flag = false;
		}
		//标签管理
		if(userVo.getAuthorization().getLabelSet() != 1 && requestURI.contains("articleLabelsManage")) {
			flag = false;
		}
		//分类管理
		if(userVo.getAuthorization().getTypeSet() != 1 && requestURI.contains("articleTypesManage")) {
			flag = false;
		}
		//评论管理
		if(userVo.getAuthorization().getCommentSet() != 1 && requestURI.contains("articleCommentsManage")) {
			flag = false;
		}
		//文章管理
		if(userVo.getAuthorization().getArticleSet() != 1 && requestURI.contains("articleManage")) {
			flag = false;
		}
		//用户管理
		if(userVo.getAuthorization().getUserSet() != 1 && requestURI.contains("articleCommentsManage")) {
			flag = false;
		}
		if(!flag) {
			request.getRequestDispatcher("/nopass").forward(request, response);
			return flag;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
}
