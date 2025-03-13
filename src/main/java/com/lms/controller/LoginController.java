package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.User;
import com.lms.service.LoginService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/")
    public String showLoginPage() {
        return "login"; // Renders login.jsp
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String username,
                            @RequestParam String password,
                            Model model,
                            HttpSession session) {

        User user = loginService.authenticate(username, password);
        if (user == null) {
            model.addAttribute("error", "Invalid username or password!");
            return "login";
        }

        session.setAttribute("loggedInUser", user);
        session.setAttribute("role", user.getRole().toString());

        return user.getRole().toString().equalsIgnoreCase("ADMIN") 
               ? "redirect:/admin-dashboard" 
               : "redirect:/user-dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Clear session
        return "redirect:/auth/login";
    }
}