package com.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.UserBook;

public interface UserBookRepository extends JpaRepository<UserBook, Long> {
    List<UserBook> findByUserIdAndIsReturnedFalse(Long userId);
}