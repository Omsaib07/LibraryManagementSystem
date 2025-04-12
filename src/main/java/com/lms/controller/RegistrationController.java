package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Event;
import com.lms.model.Registration;
import com.lms.repository.EventRepository;
import com.lms.service.RegistrationService;

@Controller
public class RegistrationController {

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private EventRepository eventRepository;

    @GetMapping("/register/{eventId}")
    public String showRegistrationForm(@PathVariable Long eventId, Model model) {
        Event event = eventRepository.findById(eventId).orElseThrow(() -> new RuntimeException("Event not found"));
        model.addAttribute("event", event);
        model.addAttribute("registration", new Registration());
        return "register_form";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Registration registration, @RequestParam Long eventId) {
        Event event = eventRepository.findById(eventId).orElseThrow(() -> new RuntimeException("Event not found"));
        registration.setEvent(event);
        registrationService.saveRegistration(registration);
        return "redirect:/events";
    }

    @GetMapping("/registration_list")
    public String viewAllRegistrations(Model model) {
        model.addAttribute("registrations", registrationService.getAllRegistrations());
        return "registration_list";
    }
}