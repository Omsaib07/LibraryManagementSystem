package com.lms.repository;

import com.lms.model.Fine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long> {

    @Transactional
    @Modifying
    @Query(value = """
            INSERT INTO fines (loan_id, fine_amount, paid)
            SELECT l.id, 
                   :initialFine + (:dailyFine * (DATEDIFF(CURDATE(), l.borrow_date) - :daysBeforeFine)), 
                   0
            FROM loans l
            WHERE l.return_date IS NULL
                  AND DATEDIFF(CURDATE(), l.borrow_date) > :daysBeforeFine
            ON DUPLICATE KEY UPDATE
                fine_amount = :initialFine + (:dailyFine * (DATEDIFF(CURDATE(), l.borrow_date) - :daysBeforeFine));
            """, nativeQuery = true)
    int updateFine(int daysBeforeFine, double initialFine, double dailyFine);
}
