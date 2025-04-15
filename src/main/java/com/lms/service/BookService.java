package com.lms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Book;
import com.lms.repository.BookRepository;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;
    
    // Get all books
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }
    
    // Get book by ID
    public Book getBookById(Long id) {
        return bookRepository.findById(id).orElse(null); // This handles the Optional<Book> to Book conversion
    }
    
    // Save a book
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }
    
    // Delete a book
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
    
    // Get available books (books that can be borrowed)
    public List<Book> getAvailableBooks() {
        // You might need to adjust this logic based on your specific requirements
        return getAllBooks();
        
        // If you have a way to track borrowed books, you could filter them like this:
        // return getAllBooks().stream()
        //     .filter(book -> !isBookBorrowed(book.getId()))
        //     .collect(Collectors.toList());
    }
    
    // Helper method to check if a book is borrowed (you'll need to implement this)
    private boolean isBookBorrowed(Long bookId) {
        // Implement logic to check if the book is currently borrowed
        return false; // Placeholder implementation
    }
}