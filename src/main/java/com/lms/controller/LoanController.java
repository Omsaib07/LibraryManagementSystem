package com.lms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Book;
import com.lms.model.Loan;
import com.lms.model.User;
import com.lms.repository.BookRepository;
import com.lms.service.LoanService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/loans")
@Slf4j
public class LoanController {

    @Autowired
    private LoanService loanService;
    
    @Autowired
    private BookRepository bookRepository;

    @GetMapping
    public String showLoans(HttpSession session, Model model) {
        // Retrieve the logged-in user and their role from the session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        String role = (String) session.getAttribute("role");
        
        if (loggedInUser == null) {
            return "redirect:/login"; // Redirect if not logged in
        }
        
        List<Loan> loans;
        if ("ADMIN".equalsIgnoreCase(role)) {
            // Admin can view all loans
            loans = loanService.getAllLoans();
        } else {
            // Users can only see their own loans
            loans = loanService.getLoansByUserId(loggedInUser.getId());
        }
        
        model.addAttribute("loans", loans);
        return "loans"; // This will render the loans.jsp page
    }

    @PostMapping("/save")
    public String saveLoan(@ModelAttribute Loan loan) {
        loanService.saveLoan(loan);
        return "redirect:/loans"; // Redirect after saving the loan
    }

    @GetMapping("/delete/{id}")
    public String deleteLoan(@PathVariable Long id) {
        loanService.deleteLoan(id);
        return "redirect:/loans"; // Redirect after deleting the loan
    }
    
    @PostMapping("/return")
    public String returnBook(@RequestParam("loanId") Long loanId, HttpSession session) {
        // Get logged-in user for security check
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            log.error("❌ User not logged in when attempting to return book");
            return "redirect:/login";
        }
        
        try {
            // Find the loan
            Loan loan = loanService.getLoanById(loanId);
            
            if (loan == null) {
                log.error("❌ Loan not found with ID: {}", loanId);
                return "redirect:/loans?error=LoanNotFound";
            }
            
            // Security check - ensure this loan belongs to the logged-in user or user is admin
            String role = (String) session.getAttribute("role");
            if (!"ADMIN".equalsIgnoreCase(role) && !loan.getUser().getId().equals(loggedInUser.getId())) {
                log.error("❌ User {} attempted to return a book belonging to another user", loggedInUser.getId());
                return "redirect:/loans?error=UnauthorizedReturn";
            }
            
            // Check if book is already returned
            if (loan.getReturnDate() != null) {
                return "redirect:/loans?error=AlreadyReturned";
            }
            
            // Update the loan return date
            loan = loanService.returnBook(loanId);
            log.info("✅ Book returned successfully, loan ID: {}", loanId);
            
            // Increase available copies of the book
            Book book = loan.getBook();
            book.setAvailable_copies(book.getAvailable_copies() + 1);
            bookRepository.save(book);
            log.info("✅ Updated available copies for book: {}", book.getBook_name());
            
            return "redirect:/loans?success=true";
        } catch (Exception e) {
            log.error("❌ Error returning book: {}", e.getMessage(), e);
            return "redirect:/loans?error=ReturnFailed";
        }
    }
}