package com.lms.controller;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lms.model.Book;
import com.lms.model.Loan;
import com.lms.model.User;
import com.lms.repository.BookRepository;
import com.lms.repository.LoanRepository;
import com.lms.repository.UserRepository;
import com.lms.service.BookService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j // ✅ For logging
public class BookController {

    private final BookService bookService;

    // ✅ Constructor Injection (Recommended)
    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

@Autowired
private LoanRepository loanRepository;

@Autowired
private UserRepository userRepository;

@Autowired
private BookRepository bookRepository;

    // ✅ Show books page
    @GetMapping("/books")
    public String showBooks(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login"; // Redirect if not logged in
        }

        List<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        return "books"; // books.jsp
    }

    // ✅ Save book with category
    @PostMapping("/saveBook")
    public String saveBook(@RequestParam String book_name,
                           @RequestParam String author,
                           @RequestParam String purchase_date,
                           @RequestParam String category,
                           @RequestParam Integer available_copies,
                           HttpSession session) {
        // ✅ Check if user is logged in before saving
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }

        try {
            // ✅ Convert String to Date properly
            LocalDate date = LocalDate.parse(purchase_date);

            // ✅ Save book
            Book book = new Book();
            book.setBook_name(book_name);
            book.setAuthor(author);
            book.setPurchase_date(java.sql.Date.valueOf(date)); // Convert to SQL Date
            book.setCategory(category);
            book.setAvailable_copies(available_copies); // Set available copies

            bookService.saveBook(book);  // Save book to DB
            log.info("✅ Book saved successfully: {}", book);
        } catch (DateTimeParseException e) {
            log.error("❌ Invalid date format: {}", purchase_date, e);
            return "redirect:/books?error=InvalidDate";
        }

        return "redirect:/books";
    }

    // ✅ Delete book by ID
    @GetMapping("/deleteBook")
    public String deleteBook(@RequestParam Long id, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login"; // Ensure user is logged in
        }

        bookService.deleteBook(id); // Delete book from DB
        log.info("✅ Book deleted successfully: ID={}", id);

        return "redirect:/books"; // Redirect to books list
    }

    // ✅ Get book by ID (optional feature)
    @GetMapping("/getBook")
    @ResponseBody
    public Book getBook(@RequestParam Long id) {
        return bookService.getBookById(id);
    }

    @PostMapping("/borrowBook")
public String borrowBook(@RequestParam("bookId") Long bookId, HttpSession session, Model model) {
    // Get userId from session
    Long userId = (Long) session.getAttribute("userId");
    
    if (userId == null) {
        log.error("❌ User ID not found in session when borrowing book");
        return "redirect:/books?error=NotLoggedIn";
    }
    
    try {
        // Fetch user and book entities with proper error handling
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
        
        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> new RuntimeException("Book not found with ID: " + bookId));
        
        // Check if book has available copies
        if (book.getAvailable_copies() <= 0) {
            log.error("❌ No copies available for book: {}", book.getBook_name());
            return "redirect:/books?error=NoCopiesAvailable";
        }
        
        // Create and save Loan object
        Loan loan = new Loan();
        loan.setUser(user);
        loan.setBook(book);
        loan.setBorrowDate(new Date());
        
        Loan savedLoan = loanRepository.save(loan);
        log.info("✅ Loan created successfully: {}", savedLoan.getId());
        
        // Update book's available copies
        book.setAvailable_copies(book.getAvailable_copies() - 1);
        bookRepository.save(book);
        log.info("✅ Updated available copies for book: {}", book.getBook_name());
        
        return "redirect:/books?success=BookBorrowed";
    } catch (Exception e) {
        log.error("❌ Error while borrowing book: {}", e.getMessage(), e);
        return "redirect:/books?error=BorrowFailed";
    }
}
}