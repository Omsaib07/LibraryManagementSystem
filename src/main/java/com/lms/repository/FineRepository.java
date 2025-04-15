package com.lms.repository;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.lms.model.Fine;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long> {
    
    @Query("SELECT f FROM Fine f WHERE f.loan.user.id = :userId")
    List<Fine> findByUserId(@Param("userId") Long userId);
    
    @Query("SELECT f FROM Fine f WHERE f.loan.id = :loanId")
    Fine findByLoanId(@Param("loanId") Long loanId);
    
    @Query("SELECT SUM(f.fineAmount) FROM Fine f WHERE f.loan.user.id = :userId AND f.paid = false")
    BigDecimal getTotalUnpaidFinesByUserId(@Param("userId") Long userId);
}