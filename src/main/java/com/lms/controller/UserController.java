package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.lms.model.User;
import com.lms.service.UserService;

import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/users")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    // ✅ Show logged-in user's profile
    @GetMapping("/profile")
    public String showProfile(Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login"; 
        }
        model.addAttribute("user", user);
        return "profile"; // Ensure profile.jsp exists
    }

    // ✅ Show edit profile page
    @GetMapping("/edit/{id}")
    public String showEditProfile(@PathVariable Long id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !loggedInUser.getId().equals(id)) {
            return "redirect:/users/profile"; 
        }

        User user = userService.getUserById(id);
        if (user == null) {
            return "redirect:/users/profile";
        }

        model.addAttribute("user", user);
        return "edit-profile"; // Ensure edit-profile.jsp exists
    }

    // ✅ Handle profile update
    @PostMapping("/update/{id}")
    public String updateProfile(@PathVariable Long id, @ModelAttribute User user, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !loggedInUser.getId().equals(id)) {
            return "redirect:/users/profile"; 
        }

        try {
            user.setId(id);
            userService.saveUser(user);
            session.setAttribute("loggedInUser", user);
            return "redirect:/users/profile";
        } catch (Exception e) {
            logger.error("Error updating profile for user ID {}: {}", id, e.getMessage());
            return "redirect:/users/edit/" + id;
        }
    }

    // ✅ Logout functionality
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/auth/login"; 
    }
}
