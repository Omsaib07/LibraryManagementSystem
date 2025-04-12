package com.lms.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lms.model.Event;
import com.lms.service.EventService;

@Controller
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping
    public String viewAllEvents(Model model) {
        List<Event> events = eventService.getAllEvents();
        model.addAttribute("events", events);
        return "event_list";
    }

    @GetMapping("/new")
    public String showEventForm(Model model) {
        model.addAttribute("event", new Event());
        return "event_form";
    }

    @PostMapping("/save")
    public String saveEvent(@ModelAttribute("event") Event event,
                            @RequestParam("date") String dateStr) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        event.setDateTime(LocalDateTime.parse(dateStr, formatter));
        eventService.save(event);
        return "redirect:/events";
    }

    @GetMapping("/delete/{id}")
    public String deleteEvent(@PathVariable Long id) {
        eventService.delete(id);
        return "redirect:/events";
    }

    @GetMapping("/{id}")
    public String viewEventDetails(@PathVariable Long id, Model model) {
        Event event = eventService.getEvent(id);
        model.addAttribute("event", event);
        return "event_details";
    }
}