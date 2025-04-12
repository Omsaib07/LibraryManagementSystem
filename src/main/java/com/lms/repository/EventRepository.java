package com.lms.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lms.model.Event;

public interface EventRepository extends JpaRepository<Event, Long> {
}