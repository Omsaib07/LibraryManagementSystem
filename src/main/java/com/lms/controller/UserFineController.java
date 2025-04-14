package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lms.service.UserFineService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/my-fines")
public class UserFineController {

    @Autowired
    private UserFineService userFineService;

    @GetMapping
    public String showUserFines(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("loggedInUserId");
        model.addAttribute("fines", userFineService.getUserFines(userId));
        return "my-fines";
    }

    @GetMapping("/pay/{id}")
    public String payFine(@PathVariable Long id) {
        userFineService.payFine(id);
        return "redirect:/user/fines";
    }
}