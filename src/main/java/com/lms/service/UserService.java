package com.lms.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lms.model.User;
import com.lms.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Retrieve all users
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // Retrieve a user by ID
    public User getUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    // Save or update a user
    public void saveUser(User user) {
        userRepository.save(user);
    }

    // Delete a user by ID
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    // Validate user credentials
    public User validateUser(String email, String password) {
        Optional<User> user = userRepository.findByEmailAndPassword(email, password);
        return user.orElse(null);  // Return user if found, otherwise return null
    }
}