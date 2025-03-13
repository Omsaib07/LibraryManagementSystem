package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Book;
import com.lms.service.LmsService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    private LmsService lmsService;

    // ✅ REMOVED showBooks() method to avoid duplicate mapping

    // Save a book (Add or Update)
    @PostMapping("/saveBook")
    public String saveBook(@RequestParam String book_name, 
                           @RequestParam String author, 
                           @RequestParam String purchase_date, 
                           HttpSession session) {

        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/books"; // Restrict non-admins
        }

        Book book = new Book();
        book.setBook_name(book_name);
        book.setAuthor(author);
        book.setPurchase_date(java.sql.Date.valueOf(purchase_date));

        lmsService.saveBook(book);
        return "redirect:/books";
    }

    // Delete a book (Admin only)
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable long id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/books"; // Restrict non-admins
        }

        lmsService.deleteBook(id);
        return "redirect:/books";
    }

    // Redirect to the appropriate dashboard
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        String role = (String) session.getAttribute("role");

        if ("ADMIN".equals(role)) {
            return "redirect:/admin-dashboard";
        } else {
            return "redirect:/user-dashboard";
        }
    }



}