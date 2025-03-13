package com.lms.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lms.model.Book;
import com.lms.service.LmsService;

import jakarta.servlet.http.HttpSession;

@Controller
public class BookController {

    @Autowired
    private LmsService lmsService;

    // ✅ This is now the only handler for /books
    @GetMapping("/books")
    public String showBooks(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login"; // Redirect if not logged in
        }

        Collection<Book> books = lmsService.findAllBooks();
        model.addAttribute("books", books);
        return "books"; // books.jsp
    }
}