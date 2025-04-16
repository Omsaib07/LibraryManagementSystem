package com.lms.repository;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.lms.model.Fine;

@Repository

public interface FineRepository extends JpaRepository<Fine, Long> {
    // Make sure this method exists and is properly implemented
    @Query("SELECT f FROM Fine f JOIN FETCH f.loan")
    List<Fine> findAllWithLoans();
    
    Fine findByLoanId(Long loanId);
    
    @Query("SELECT f FROM Fine f JOIN f.loan l WHERE l.user.id = :userId")
    List<Fine> findByUserId(Long userId);
    
    @Query("SELECT SUM(f.fineAmount) FROM Fine f JOIN f.loan l WHERE l.user.id = :userId AND f.paid = false")
    BigDecimal getTotalUnpaidFinesByUserId(Long userId);

    
}