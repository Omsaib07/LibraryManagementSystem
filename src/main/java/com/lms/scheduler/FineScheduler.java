package com.lms.scheduler;

import com.lms.service.FineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class FineScheduler {

    @Autowired
    private FineService fineService;

    // Keep the midnight scheduler
    @Scheduled(cron = "0 0 0 * * ?")
    public void runFineUpdate() {
        System.out.println("Starting scheduled fine update...");
        fineService.updateFine();
        System.out.println("Scheduled fine update completed.");
    }
    
    // Add this method to run when application starts
    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationStart() {
        System.out.println("Application started, running fine update...");
        fineService.updateFine();
        System.out.println("Startup fine update completed.");
    }
}
