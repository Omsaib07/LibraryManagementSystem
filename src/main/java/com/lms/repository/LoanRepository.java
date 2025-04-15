package com.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.lms.model.Loan;

public interface LoanRepository extends JpaRepository<Loan, Long> {
    @Query("SELECT l FROM Loan l WHERE l.user.id = :userId")
List<Loan> findByUserId(@Param("userId") Long userId);
}