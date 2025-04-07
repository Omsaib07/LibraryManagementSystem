package com.lms.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.Fine;
import com.lms.repository.FineRepository;

@Service
public class UserFineService {

    @Autowired
    private FineRepository fineRepository;

    // Get all fines for a specific user
    public List<Fine> getUserFines(Long userId) {
        return fineRepository.findAll()
                .stream()
                .filter(fine -> fine.getLoan().getUser().getId().equals(userId))  // ← get user from loan
                .collect(Collectors.toList());
    }

    // Pay (delete) a fine by its ID
    public void payFine(Long fineId) {
        fineRepository.deleteById(fineId);
    }
}