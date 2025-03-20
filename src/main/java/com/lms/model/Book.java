package com.lms.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "lms_table") // Ensure this matches your DB table name
public class Book {
    @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)  // ✅ Use MySQL's auto-increment
private long id;

    @Column(name="book_name")
    private String book_name;

    @Column(name="author")
    private String author;

    @Column(name="purchase_date")
    @Temporal(TemporalType.DATE)
    private Date purchase_date;

    // ✅ Add category field
    @Column(name="category")
    private String category;
}