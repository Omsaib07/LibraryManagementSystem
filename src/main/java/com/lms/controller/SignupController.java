package com.lms.controller;

import com.lms.model.User;
import com.lms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SignupController {

    @Autowired
    private UserService userService;

    // Show the signup page
    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup";  // Ensure you have a signup.html or signup.jsp page
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String name,
                         @RequestParam String username,
                         @RequestParam String email,
                         @RequestParam String phone,
                         @RequestParam String password,
                         Model model) {
        
        // Check if the username is already taken
        if (userService.validateUser(email, password) != null) {
            model.addAttribute("error", "Email already registered!");
            return "signup";  // Redirect back to signup page with error message
        }

        // Create and save a new user
        User newUser = new User();
        newUser.setName(name);
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setPassword(password);
        newUser.setRole("USER");  // Default role

        userService.saveUser(newUser);

        return "redirect:/login";  // Redirect to login page after successful signup
    }
}
