package com.org.team4.web;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("users")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private JavaMailSender mailSender;		
	
	@Autowired
	//private BCryptPasswordEncoder pwEncoder;

	@GetMapping("/login")
	public String login() {
		return "users/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) {

		log.info(loginDTO.toString());

		try {
			UserDTO userInfo = userService.getUser(loginDTO);

			session.setAttribute("userInfo", userInfo);

			return "redirect:../";

		} catch (Exception e) {
			log.info(e.getMessage());
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("url", "./login");
			return "result";
		}
	}

	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {

		session.invalidate();

		return "redirect:../";
	}

	@GetMapping("/register")
	public String register(HttpSession session) {

		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

		if (userInfo != null)
			return "redirect:../users/login";
		else
			return "users/register";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute RegisterDTO registerDTO, Model model, HttpSession session) {
		
		try {
			userService.registerUser(registerDTO);
			return "redirect:../";

		} catch (Exception e) {
			log.info(e.getMessage());
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("url", "./");
			return "result";
		}

	}

	@GetMapping("/withdraw")
	public String withdraw(HttpSession session) {

		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

		if (userInfo == null)
			return "redirect:../users/login";
		else
			return "users/withdraw";
	}

	@PostMapping("/withdraw")
	public String withdraw(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) {

		try {
			userService.withdrawUser(loginDTO);
			session.invalidate();
			return "redirect:../";

		} catch (Exception e) {
			log.info(e.getMessage());
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("url", "./");
			return "result";
		}
	}

	@PostMapping("/CheckNickname")
	@ResponseBody
	public int checkNickname(@RequestParam String nickname) {

		int res = 0;
		
		try {
			res = userService.checkNickname(nickname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;

	}
	
	/* 이메일 인증 */
    @GetMapping("/mailCheck")
    @ResponseBody
    public String mailCheckGET(@RequestParam String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("인증번호 : " + email);
        
        /* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호 " + checkNum);
		
		/* 이메일 보내기 */
		String setFrom = "ok267733@gmail.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = 
				"홈페이지를 방문해주셔서 감사합니다." +
				"<br><br>" + 
				"인증 번호는 " + checkNum + "입니다." + 
				"<br>" + 
				"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";		
		
		try {
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
			
		}catch(Exception e) {
			e.printStackTrace();
		}		
		
		String num = Integer.toString(checkNum);
		
		return num;
    }
}
