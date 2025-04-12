package com.lms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lms.model.Loan;
import com.lms.model.User;
import com.lms.service.LoanService;
import com.lms.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    // Show all users
    @GetMapping
    public String showUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "users";  // Render users.jsp
    }

    // Show the user creation form
    @GetMapping("/new")
    public String showUserForm(Model model) {
        model.addAttribute("user", new User());
        return "user_form";  // Renders user_form.jsp
    }
    // Show logged-in user's profile
@GetMapping("/profile")
public String showProfile(Model model, HttpSession session) {
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        return "redirect:/auth/"; // Redirect to login if not logged in
    }
    model.addAttribute("user", user);
    return "my-profile"; // This should match my-profile.jsp
}
@Autowired
private LoanService loanService; // Add this line
// Show logged-in user's loans
@GetMapping("/my-loans")
public String showUserLoans(Model model, HttpSession session) {
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        return "redirect:/auth/"; // Redirect to login if not logged in
    }

    List<Loan> loans = loanService.getLoansByUserId(user.getId());
    model.addAttribute("loans", loans);
    return "my-loans"; // This should match my-loans.jsp
}
    // Save a user
    @PostMapping("/save")
    public String saveUser(@ModelAttribute User user) {
        userService.saveUser(user);
        return "redirect:/users";
    }

    // Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "user_form";  // Reuse user_form.jsp for editing
    }

    // Update user
    @PostMapping("/update/{id}")
    public String updateUser(@PathVariable Long id, @ModelAttribute User user) {
        user.setId(id);
        userService.saveUser(user);
        return "redirect:/users";
    }

    // Delete a user
    @GetMapping("/delete/{id}")
public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
    List<Loan> loans = loanService.getLoansByUserId(id);
    if (!loans.isEmpty()) {
        redirectAttributes.addFlashAttribute("error", "Cannot delete user with existing loans.");
        return "redirect:/users";
    }
    redirectAttributes.addFlashAttribute("success", "User deleted successfully.");
    userService.deleteUser(id);
    return "redirect:/users";
}
}