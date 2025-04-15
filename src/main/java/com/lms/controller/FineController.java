package com.lms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Fine;
import com.lms.model.User;
import com.lms.service.FineService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/fines")
@Slf4j
public class FineController {

    @Autowired
    private FineService fineService;

    @GetMapping
    public String viewFines(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<Fine> fines = fineService.getUnpaidFinesByUserId(loggedInUser.getId());
        model.addAttribute("fines", fines);
        model.addAttribute("totalFines", fineService.getTotalUnpaidFinesByUserId(loggedInUser.getId()));

        return "fines"; // fines.jsp
    }

    @PostMapping("/pay")
    public String payFine(@RequestParam("fineId") Long fineId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/login";
        }

        fineService.payFine(fineId);
        log.info("💰 Fine with ID {} has been paid", fineId);

        return "redirect:/fines?success=paid";
    }
}