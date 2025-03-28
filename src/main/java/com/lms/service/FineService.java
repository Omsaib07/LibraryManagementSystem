package com.lms.service;

import com.lms.model.Fine;
import com.lms.repository.FineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FineService {

    @Autowired
    private FineRepository fineRepository;

    // Constants for fine calculation
    private static final int DAYS_BEFORE_FINE = 7;  // Fine starts after 7 days
    private static final double INITIAL_FINE_AMOUNT = 50.0;  // Initial fine amount
    private static final double DAILY_FINE_AMOUNT = 10.0;    // Daily fine amount

    public List<Fine> getAllFines() {
        return fineRepository.findAll();
    }

    public Fine getFineById(Long id) {
        return fineRepository.findById(id).orElse(null);
    }

    public void saveFine(Fine fine) {
        fineRepository.save(fine);
    }

    public void deleteFine(Long id) {
        fineRepository.deleteById(id);
    }

    // Update fine logic
    public void updateFine() {
        System.out.println("Running Fine Update Job...");
        int rowsAffected = fineRepository.updateFine(DAYS_BEFORE_FINE, INITIAL_FINE_AMOUNT, DAILY_FINE_AMOUNT);
        System.out.println("Fines updated for " + rowsAffected + " records.");
    }
}
