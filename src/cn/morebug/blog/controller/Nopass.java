package cn.morebug.blog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Nopass {
	
	@RequestMapping("/nopass")
	public String toNopass() {
		return "errors/nopass";
	}
}
