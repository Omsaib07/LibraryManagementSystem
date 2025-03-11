package com.lms.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import com.lms.model.Book;
import com.lms.service.LmsService;

@Controller
public class MainController {
    @Autowired
    private LmsService lmsService;

    // Show all books in the JSP
    @GetMapping("/")
    public String showBooks(Model model) {
        Collection<Book> books = lmsService.findAllBooks();
        model.addAttribute("books", books);
        return "index";  // This maps to index.jsp
    }

    // Save Book (Add or Update)
    @PostMapping("/saveBook")
    public String saveBook(
            @RequestParam String book_name, 
            @RequestParam String author, 
            @RequestParam String purchase_date) {
        
        Book book = new Book();
        book.setBook_name(book_name);
        book.setAuthor(author);
        book.setPurchase_date(java.sql.Date.valueOf(purchase_date));

        lmsService.saveBook(book);
        return "redirect:/";
    }

    // Delete a book
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable long id) {
        lmsService.deleteBook(id);
        return "redirect:/";
    }
}
