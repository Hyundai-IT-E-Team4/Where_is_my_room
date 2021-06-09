package com.org.team4.web;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.owasp.esapi.ESAPI;
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
import org.springframework.web.multipart.MultipartFile;

import com.org.team4.dto.FindPasswordDTO;
import com.org.team4.dto.LoginDTO;
import com.org.team4.dto.RegisterDTO;
import com.org.team4.dto.UpdateEmailDTO;
import com.org.team4.dto.UpdatePasswordDTO;
import com.org.team4.dto.UserDTO;
import com.org.team4.interceptor.Auth;
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

   @GetMapping("/login")
   public String login() {
      return "users/login";
   }

   @PostMapping("/login")
   public String login(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) {

      log.info(loginDTO.toString());

      try {
         UserDTO userInfo = userService.getUser(loginDTO);
         log.info(userInfo.toString());
         session.setAttribute("userInfo", userInfo);
         return "redirect:../";

      } catch (Exception e) {
         log.info(e.getMessage());
         model.addAttribute("msg", e.getMessage());
         model.addAttribute("url", "./login");
         return "result";
      }
   }

   @Auth
   @GetMapping("/logout")
   public String logout(Model model, HttpSession session) {

      session.invalidate();

      return "redirect:../";
   }

   @GetMapping("/register")
   public String register(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo != null)
         return "redirect:../";
      else
         return "users/register";
   }

   @PostMapping("/register")
   public String register(@ModelAttribute RegisterDTO registerDTO, Model model, HttpSession session) {

      try {
    	  log.warn("이걸봐!! " + registerDTO.getEmail());
         userService.registerUser(registerDTO);
         return "redirect:../";

      } catch (Exception e) {
         log.info(e.getMessage());
         model.addAttribute("msg", e.getMessage());
         model.addAttribute("url", "./");
         return "result";
      }

   }

   @Auth
   @GetMapping("/withdraw")
   public String withdraw(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo == null)
         return "redirect:../users/login";
      else
         return "users/withdraw";
   }

   @PostMapping("/withdraw")
   public String withdraw(@ModelAttribute LoginDTO loginDTO, Model model, HttpSession session) throws Exception {

      log.info(loginDTO.toString());

      int res = userService.withdrawUser(loginDTO);

      if (res != 0) {
         session.invalidate();

         model.addAttribute("msg", "정상적으로 탈퇴되었습니다.");
         model.addAttribute("url", "../");
      } else {
         model.addAttribute("msg", "비밀번호가 틀렸습니다. 다시 입력해주세요.");
         model.addAttribute("url", "javascript:history.back()");
      }

      return "result";
   }

   @Auth
   @GetMapping("/info")
   public String info(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo == null)
         return "redirect:../users/login";
      else
         return "users/info";
   }

   @Auth
   @GetMapping("/update")
   public String update(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo == null)
         return "redirect:../users/login";
      else
         return "users/update";
   }

   @PostMapping("/update")
   public String update(@ModelAttribute UserDTO userDTO, Model model, HttpSession session, MultipartFile uploadProfileImg) throws Exception {

      log.info(userDTO.toString());

      long res = userService.updateUser(userDTO, uploadProfileImg);
      
      if (res != 0) {

         UserDTO userInfo = userDTO;
         session.setAttribute("userInfo", userInfo);
         log.info("세션의 프로필 경로 {}", userInfo.getProfile_img());

         model.addAttribute("msg", "정보가 수정되었습니다.");
         model.addAttribute("url", "../users/info");

      } else {
         model.addAttribute("msg", "비밀번호가 틀렸습니다. 다시 입력해주세요.");
         model.addAttribute("url", "javascript:history.back()");
      }

      return "result";
   }

   @Auth
   @GetMapping("/updateEmail")
   public String updateEmail(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo == null)
         return "redirect:../users/login";
      else
         return "users/updateEmail";
   }

   @Auth
   @PostMapping("/updateEmail")
   public String updateEmail(@ModelAttribute UpdateEmailDTO updateEmailDTO, Model model, HttpSession session)
         throws Exception {

      long res = userService.updateEmail(updateEmailDTO);

      if (res != 0) {
         session.invalidate();

         model.addAttribute("msg", "이메일이 변경되었습니다. 다시 로그인하세요");
         model.addAttribute("url", "../users/login");

      } else {
         model.addAttribute("msg", "비밀번호가 틀렸습니다. 다시 입력해주세요.");
         model.addAttribute("url", "javascript:history.back()");
      }

      return "result";
   }

   @Auth
   @GetMapping("/updatePassword")
   public String updatePassword(HttpSession session) {

      UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");

      if (userInfo == null)
         return "redirect:../users/login";
      else
         return "users/updatePassword";
   }

   @PostMapping("/updatePassword")
   public String updatePassword(@ModelAttribute UpdatePasswordDTO updatePasswordDTO, Model model, HttpSession session)
         throws Exception {

      long res = userService.updatePassword(updatePasswordDTO);

      if (res != 0) {
         session.invalidate();

         model.addAttribute("msg", "비밀번호가 변경되었습니다. 다시 로그인하세요");
         model.addAttribute("url", "../users/login");

      } else {
         model.addAttribute("msg", "현재 비밀번호가 틀렸습니다. 다시 입력해주세요.");
         model.addAttribute("url", "javascript:history.back()");
      }

      return "result";
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
   public String mailCheck(@RequestParam String email) throws Exception {

      /* 뷰(View)로부터 넘어온 데이터 확인 */
      log.info("이메일 데이터 전송 확인");
      log.info("인증번호 : " + email);

      /* 인증번호(난수) 생성 */
      Random random = new Random();
      int checkNum = random.nextInt(888888) + 111111;
      log.info("인증번호 " + checkNum);

      /* 이메일 보내기 */
      String setFrom = "whereismyroom4@gmail.com";
      String toMail = email;
      String title = "회원가입 인증 이메일 입니다.";
      String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
            + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

      try {
         MimeMessage message = mailSender.createMimeMessage();
         MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

         helper.setFrom(setFrom);
         helper.setTo(toMail);
         helper.setSubject(title);
         helper.setText(content, true);
         mailSender.send(message);

      } catch (Exception e) {
         e.printStackTrace();
      }

      String num = Integer.toString(checkNum);

      return num;
   }
   
   @GetMapping("/findPassword")
   public String findAccount() {
      return "users/findPassword";
   }
   
   @PostMapping("/findPassword")
   public String findPassword(@ModelAttribute FindPasswordDTO findPasswordDTO, Model model) throws Exception {

      /* 인증번호(난수) 생성 */
      Random random = new Random();
      int newPassword = random.nextInt(888888) + 111111;
      log.info("새 랜덤 비밀번호 " + newPassword);
      
      findPasswordDTO.setNewPassword(Integer.toString(newPassword));
      
      int res = userService.findPassword(findPasswordDTO);   

      if (res != 0) {
         
         /* 이메일 보내기 */
         String setFrom = "whereismyroom4@gmail.com";
         String toMail = findPasswordDTO.getEmail();
         String title = "가입된 이메일의 새 비밀번호 입니다.";
         String content = "기존 비밀번호를 지우고 새로운 비밀번호를 발급받으셨습니다." + "<br><br>" + "새 비밀번호는 <b>" + newPassword + "</b>입니다." + "<br>"
               + "새 비밀번호를 이용해 새로 로그인 해주세요.";

         try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);

         } catch (Exception e) {
            e.printStackTrace();
         }
         
         model.addAttribute("msg", "등록된 이메일로 새 비밀번호를 전송했습니다.");
         model.addAttribute("url", "../users/login");
      } else {
         model.addAttribute("msg", "가입된 이메일 또는 이름이 존재하지 않습니다.");
         model.addAttribute("url", "javascript:history.back()");
      }

      return "result";
   }
}