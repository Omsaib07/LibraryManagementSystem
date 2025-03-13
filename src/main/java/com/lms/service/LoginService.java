package com.lms.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.User;
import com.lms.repository.UserRepository;

@Service
public class LoginService {

    @Autowired
    private UserRepository userRepository;

    public User authenticate(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsernameAndPassword(username, password);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getPassword().equals(password)) { // Ideally, use password hashing
                return user;
            }
        }
        return null; // Authentication failed
    }
}