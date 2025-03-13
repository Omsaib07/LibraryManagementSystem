package com.lms.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lms.model.Loan;

@Repository
public interface LoanRepository extends JpaRepository<Loan, Long> {
}