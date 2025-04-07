package com.lms.scheduler;

import com.lms.service.FineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class FineScheduler {

    @Autowired
    private FineService fineService;

    // Run every day at 00:00 (midnight)
    @Scheduled(cron = "0 0 0 * * ?")
    public void runFineUpdate() {
        System.out.println("Starting scheduled fine update...");
        fineService.updateFine();
        System.out.println("Scheduled fine update completed.");
    }
}
