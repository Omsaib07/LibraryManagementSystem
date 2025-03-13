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
}