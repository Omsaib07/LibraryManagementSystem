package com.lms.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Book;
import com.lms.repository.LmsRepository;

@Service
public class LmsService {
	@Autowired
	private LmsRepository lmsRepository;
	
	//GET method
	public Collection<Book> findAllBooks() {
		List<Book> books = new ArrayList<>();
		for(Book book: lmsRepository.findAll()) {
			books.add(book);
		}
		return books;
	}
	//DELETE method 
	public void deleteBook(long id) {
		lmsRepository.deleteById(id);
	}

	public void saveBook(Book book) {
		lmsRepository.save(book);
	}
	
}
