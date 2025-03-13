package com.lms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lms.model.Fine;
import com.lms.service.FineService;

@Controller
@RequestMapping("/fines")
public class FineController {

    @Autowired
    private FineService fineService;

    @GetMapping
    public String showFines(Model model) {
        model.addAttribute("fines", fineService.getAllFines());
        return "fines";
    }

    @PostMapping("/save")
    public String saveFine(@ModelAttribute Fine fine) {
        fineService.saveFine(fine);
        return "redirect:/fines";
    }

    @GetMapping("/delete/{id}")
    public String deleteFine(@PathVariable Long id) {
        fineService.deleteFine(id);
        return "redirect:/fines";
    }
}