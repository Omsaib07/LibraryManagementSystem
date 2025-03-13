package com.lms.service;

import com.lms.model.Book;
import com.lms.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    // Fetch all books
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    // Save a book
    public void saveBook(Book book) {
        bookRepository.save(book);
    }

    // Delete a book by ID
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }

    // Find a book by ID (optional feature)
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }
}