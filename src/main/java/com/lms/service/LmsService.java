package com.lms.service;

import java.util.Collection;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Book;
import com.lms.repository.BookRepository;

@Service
public class LmsService {

    @Autowired
    private BookRepository bookRepository;

    // Fetch all books
    public Collection<Book> findAllBooks() {
        return bookRepository.findAll();
    }

    // Save or update book
    public void saveBook(Book book) {
        bookRepository.save(book);
    }

    // Delete book by ID
    public void deleteBook(long id) {
        bookRepository.deleteById(id);
    }

    // Find book by ID
    public Optional<Book> findBookById(long id) {
        return bookRepository.findById(id);
    }
}