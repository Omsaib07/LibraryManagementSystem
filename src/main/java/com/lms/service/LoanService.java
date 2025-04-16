package com.lms.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Fine;
import com.lms.model.Loan;
import com.lms.repository.LoanRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoanService {

    @Autowired
    private LoanRepository loanRepository;

    @Autowired
    private FineService fineService;

    // ✅ Get all loans
    public List<Loan> getAllLoans() {
        return loanRepository.findAll();
    }

    // ✅ Get loans by user ID
    public List<Loan> getLoansByUserId(Long userId) {
        return loanRepository.findByUserId(userId);
    }

    // ✅ Get loan by ID
    public Loan getLoanById(Long id) {
        return loanRepository.findById(id).orElse(null);
    }

    // ✅ Save a loan
    public Loan saveLoan(Loan loan) {
        return loanRepository.save(loan);
    }

    // ✅ Delete a loan
    // ✅ Delete a loan only if no fine exists
    public void deleteLoan(Long id) {
        loanRepository.deleteById(id);
    }

    // ✅ Return a book and calculate fine
    public Loan returnBook(Long loanId) {
    log.info("Starting returnBook method for loan ID: {}", loanId);
    
    Loan loan = loanRepository.findById(loanId).orElse(null);
    if (loan == null) {
        log.error("Loan not found with ID: {}", loanId);
        return null;
    }
    
    if (loan.getReturnDate() != null) {
        log.info("Book already returned on: {}", loan.getReturnDate());
        return loan;
    }
    
    // Set return date
    loan.setReturnDate(new Date());
    loan = loanRepository.save(loan);
    log.info("Return date set to: {} for loan ID: {}", loan.getReturnDate(), loanId);
    log.info("Calling fineService.calculateAndSaveFine for loan ID: {}", loanId);
log.info("Loan borrow date: {}, return date: {}", loan.getBorrowDate(), loan.getReturnDate());
    // Calculate and save fine if overdue
    try {
        Fine fine = fineService.calculateAndSaveFine(loan);
        if (fine != null) {
            log.info("Fine created successfully: amount = {}", fine.getFineAmount());
        } else {
            log.info("No fine created (not overdue or error occurred)");
        }
    } catch (Exception e) {
        log.error("Error calculating fine: {}", e.getMessage(), e);
        // Continue with the return process even if fine calculation fails
    }
    
    return loan;
}
public Loan renewLoan(Long loanId) {
    Loan existingLoan = getLoanById(loanId);
    if (existingLoan != null && existingLoan.getReturnDate() == null) {
        // First mark the existing loan as returned today
        existingLoan.setReturnDate(new Date());
        loanRepository.save(existingLoan);
        
        // Create a new loan entry
        Loan newLoan = new Loan();
        newLoan.setUser(existingLoan.getUser());
        newLoan.setBook(existingLoan.getBook());
        newLoan.setBorrowDate(new Date());  // Set today as borrow date
        newLoan.setReturnDate(null);        // Not returned yet
        newLoan.setCategoryId(existingLoan.getCategoryId());
        
        return loanRepository.save(newLoan);
    }
    return null;
}
}

