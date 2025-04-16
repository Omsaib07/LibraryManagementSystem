package com.lms.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Fine;
import com.lms.model.Loan;
import com.lms.repository.FineRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FineService {

    // Configure fine amount per day
    private static final BigDecimal FINE_AMOUNT_PER_DAY = new BigDecimal("0.50");
    private static final int GRACE_PERIOD_DAYS = 14;
    
    @Autowired
private FineRepository fineRepository;

public List<Fine> getAllFines() {
    log.info("⭐ Retrieving all fines from the system");
    try {
        // Use the improved repository method for eager loading
        List<Fine> fines = fineRepository.findAllWithLoans();
        log.info("⭐ Retrieved {} fines successfully", fines.size());
        
        // Add debug logging to see what's in the list
        if (fines.isEmpty()) {
            log.warn("⭐ No fines found in the system!");
        } else {
            log.info("⭐ First few fines:");
            for (int i = 0; i < Math.min(fines.size(), 3); i++) {
                Fine fine = fines.get(i);
                log.info("⭐ Fine ID: {}, Amount: ${}, Paid: {}, LoanID: {}", 
                    fine.getId(), fine.getFineAmount(), fine.getPaid(), 
                    fine.getLoan() != null ? fine.getLoan().getId() : "null");
            }
        }
        
        return fines;
    } catch (Exception e) {
        log.error("⭐ Error retrieving all fines: {}", e.getMessage(), e);
        return List.of(); // Return empty list instead of null
    }
}
    
    
    // Calculate and save fine for an overdue book
    public Fine calculateAndSaveFine(Loan loan) {
        log.info("⭐⭐⭐ FINE CALCULATION STARTED for loan ID: {}, borrow date: {}, return date: {}", 
            loan.getId(), loan.getBorrowDate(), loan.getReturnDate());
        log.info("⭐ Fine calculation started for loan ID: {}", loan.getId());
        
        try {
            // Skip if return date is null (book not returned yet)
            if (loan.getReturnDate() == null) {
                log.info("⭐ Return date is null, skipping fine calculation");
                return null;
            }
            
            // Check if fine already exists for this loan
            Fine existingFine = fineRepository.findByLoanId(loan.getId());
            if (existingFine != null) {
                log.info("⭐ Fine already exists for loan ID: {} with amount: ${}", 
                        loan.getId(), existingFine.getFineAmount());
                return existingFine;
            }
            
            // Calculate days overdue
            LocalDate borrowDate = convertToLocalDate(loan.getBorrowDate());
            LocalDate returnDate = convertToLocalDate(loan.getReturnDate());
            long daysFromBorrow = ChronoUnit.DAYS.between(borrowDate, returnDate);
            
            log.info("⭐ Loan dates - borrow: {}, return: {}, days between: {}, grace period: {}", 
                    borrowDate, returnDate, daysFromBorrow, GRACE_PERIOD_DAYS);
            
            // If days overdue is greater than grace period, calculate fine
            if (daysFromBorrow > GRACE_PERIOD_DAYS) {
                long daysOverdue = daysFromBorrow - GRACE_PERIOD_DAYS;
                BigDecimal fineAmount = FINE_AMOUNT_PER_DAY.multiply(new BigDecimal(daysOverdue));
                
                log.info("⭐ Creating fine - loan is overdue by {} days, fine amount: ${}", 
                        daysOverdue, fineAmount);
                
                // Create and save fine
                Fine fine = new Fine();
                fine.setLoan(loan);
                fine.setFineAmount(fineAmount);
                fine.setPaid(false);
                
                try {
                    fine = fineRepository.save(fine);
                    log.info("⭐ Fine saved successfully with ID: {}", fine.getId());
                    return fine;
                } catch (Exception e) {
                    log.error("⭐ Error saving fine: {}", e.getMessage(), e);
                    throw e; // Re-throw to be caught by outer try-catch
                }
            } else {
                log.info("⭐ No fine created - loan returned within grace period ({}≤{})", 
                        daysFromBorrow, GRACE_PERIOD_DAYS);
                return null;
            }
        } catch (Exception e) {
            log.error("⭐ Error calculating fine: {}", e.getMessage(), e);
            return null;
        }
    }
    
    // Process fine payment
    public Fine payFine(Long fineId) {
        log.info("⭐ Processing payment for fine ID: {}", fineId);
        
        Fine fine = fineRepository.findById(fineId).orElse(null);
        if (fine != null) {
            fine.setPaid(true);
            fine = fineRepository.save(fine);
            log.info("⭐ Fine marked as paid: {}", fineId);
            return fine;
        }
        log.warn("⭐ Fine not found with ID: {}", fineId);
        return null;
    }
    
    // Get all unpaid fines for a user
    public List<Fine> getUnpaidFinesByUserId(Long userId) {
        log.info("⭐ Fetching unpaid fines for user ID: {}", userId);
        
        List<Fine> fines = fineRepository.findByUserId(userId).stream()
                .filter(fine -> !fine.getPaid())
                .toList();
        
        log.info("⭐ Found {} unpaid fines for user ID: {}", fines.size(), userId);
        return fines;
    }
    
    // Get total unpaid fines for a user
    public BigDecimal getTotalUnpaidFinesByUserId(Long userId) {
        log.info("⭐ Calculating total unpaid fines for user ID: {}", userId);
        
        BigDecimal total = fineRepository.getTotalUnpaidFinesByUserId(userId);
        total = total != null ? total : BigDecimal.ZERO;
        
        log.info("⭐ Total unpaid fines for user ID {}: ${}", userId, total);
        return total;
    }
    
    // Helper method to convert Date to LocalDate
    // Helper method to convert Date to LocalDate
private LocalDate convertToLocalDate(Date date) {
    try {
        if (date == null) {
            log.error("⭐ Cannot convert null date to LocalDate");
            throw new IllegalArgumentException("Date cannot be null");
        }
        
        // Handle java.sql.Date differently than java.util.Date
        if (date instanceof java.sql.Date) {
            return ((java.sql.Date) date).toLocalDate();
        } else {
            return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        }
    } catch (Exception e) {
        log.error("⭐ Error converting date: {}", e.getMessage(), e);
        throw e; // Re-throw to be caught by the caller
    }
}
    
    // Test method to verify the repository and database connection
    public void testFineRepository() {
        try {
            // Count all fines
            long count = fineRepository.count();
            log.info("⭐ Total fines in system: {}", count);
            
            // Get all fines
            List<Fine> allFines = fineRepository.findAll();
            log.info("⭐ Retrieved {} fines from database", allFines.size());
            
            // Log the first few fines if any exist
            if (!allFines.isEmpty()) {
                int limit = Math.min(5, allFines.size());
                for (int i = 0; i < limit; i++) {
                    Fine fine = allFines.get(i);
                    log.info("⭐ Fine ID: {}, Amount: ${}, Paid: {}, LoanID: {}", 
                            fine.getId(), fine.getFineAmount(), fine.getPaid(), fine.getLoan().getId());
                }
            }
        } catch (Exception e) {
            log.error("⭐ Error testing fine repository: {}", e.getMessage(), e);
        }
    }
}