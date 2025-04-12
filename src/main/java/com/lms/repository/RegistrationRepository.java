package com.lms.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.Event;
import com.lms.model.Registration;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {
    List<Registration> findByEvent(Event event);
}