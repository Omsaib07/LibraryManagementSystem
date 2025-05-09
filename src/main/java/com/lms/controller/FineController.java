package com.lms.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    
    // Admin routes with original paths from AdminFineController
    
    @GetMapping("/admin")
    public String viewAllFines(HttpSession session, Model model) {
        log.info("⭐ Admin accessing all fines view");
        
        // Check if user is admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equalsIgnoreCase(role)) {
            log.warn("⭐ Unauthorized access attempt to admin fines page");
            return "redirect:/";
        }
        
        // Get all fines
        List<Fine> allFines = fineService.getAllFines();
        log.info("⭐ Retrieved {} fines for admin view", allFines.size());
        model.addAttribute("fines", allFines);
        
        // Calculate totals
        BigDecimal totalPaid = allFines.stream()
                .filter(Fine::getPaid)
                .map(Fine::getFineAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal totalUnpaid = allFines.stream()
                .filter(f -> !f.getPaid())
                .map(Fine::getFineAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("totalPaid", totalPaid);
        model.addAttribute("totalUnpaid", totalUnpaid);
        model.addAttribute("totalFines", totalPaid.add(totalUnpaid));
        
        return "admin/adminfines";
    }
    
    @PostMapping("/admin/mark-paid")
    public String markFinePaid(@RequestParam("fineId") Long fineId, 
                              RedirectAttributes redirectAttributes,
                              HttpSession session) {
        log.info("⭐ Admin attempting to mark fine {} as paid", fineId);
        
        // Check if user is admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equalsIgnoreCase(role)) {
            log.warn("⭐ Unauthorized access attempt to admin payment function");
            return "redirect:/";
        }
        
        // Process payment
        Fine fine = fineService.payFine(fineId);
        if (fine != null) {
            log.info("⭐ Admin successfully marked fine {} as paid", fineId);
            redirectAttributes.addFlashAttribute("successMessage", 
                    "Fine #" + fineId + " has been marked as paid successfully");
        } else {
            log.error("⭐ Admin failed to mark fine {} as paid", fineId);
            redirectAttributes.addFlashAttribute("errorMessage", 
                    "Failed to mark fine as paid. Fine may not exist.");
        }
        
        return "redirect:/fines/admin";
    }
    
    @GetMapping("/admin/search")
    public String searchFines(@RequestParam(required = false) Long userId,
                             @RequestParam(required = false) Boolean paidStatus,
                             Model model,
                             HttpSession session) {
        log.info("⭐ Admin searching fines - userId: {}, paidStatus: {}", userId, paidStatus);
        
        // Check if user is admin
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equalsIgnoreCase(role)) {
            log.warn("⭐ Unauthorized access attempt to admin search function");
            return "redirect:/";
        }
        
        // Get filtered fines
        List<Fine> allFines = fineService.getAllFines();
        model.addAttribute("fines", allFines);
        model.addAttribute("userId", userId);
        model.addAttribute("paidStatus", paidStatus);
        
        // Calculate totals as before
        BigDecimal totalPaid = allFines.stream()
                .filter(Fine::getPaid)
                .map(Fine::getFineAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal totalUnpaid = allFines.stream()
                .filter(f -> !f.getPaid())
                .map(Fine::getFineAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("totalPaid", totalPaid);
        model.addAttribute("totalUnpaid", totalUnpaid);
        model.addAttribute("totalFines", totalPaid.add(totalUnpaid));
        
        return "admin/adminfines";
    }
}