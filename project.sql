CREATE DATABASE lmsdb;
USE lmsdb;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE lms_table (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author VARCHAR(255),
    book_name VARCHAR(255),
    purchase_date DATE
);
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL
);
CREATE TABLE loans (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES lms_table(id)
);
desc loans;
CREATE TABLE categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE fines (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    loan_id BIGINT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);

select * from lms_table;
insert into categories(category_name) values ("Technology");

select * from loans;
select * from categories;
INSERT INTO users (name, email, phone, password, role, username)
VALUES 
('John Doe', 'johndoe@example.com', '9876543210', 'password123', 'ADMIN', 'johndoe'),
('Alice Smith', 'alice@example.com', '9876543211', 'alice@pass', 'USER', 'alicesmith'),
('Bob Johnson', 'bob@example.com', '9876543212', 'bob12345', 'USER', 'bobjohnson'),
('Emma Brown', 'emma@example.com', '9876543213', 'emmaPass', 'ADMIN', 'emmabrown'),
('Charlie White', 'charlie@example.com', '9876543214', 'charlie2024', 'USER', 'charliewhite');
INSERT INTO loans (name, email, phone, password, role, username);
ALTER TABLE lms_table ;

select * from categories;
INSERT INTO lms_table (author, book_name, purchase_date, category) 
VALUES 
    ('J.K. Rowling', 'Harry Potter and the Philosopher\'s Stone', '2001-06-26', 'Fiction'),
    ('Yuval Noah Harari', 'Sapiens: A Brief History of Humankind', '2011-09-04', 'Non-Fiction'),
    ('Stephen Hawking', 'A Brief History of Time', '1988-04-01', 'Science'),
    ('George Orwell', '1984', '1949-06-08', 'Fiction'),
    ('Walter Isaacson', 'Steve Jobs', '2011-10-24', 'Biography'),
    ('Dan Brown', 'The Da Vinci Code', '2003-03-18', 'Mystery'),
    ('Isaac Asimov', 'Foundation', '1951-08-21', 'Science'),
    ('J.R.R. Tolkien', 'The Hobbit', '1937-09-21', 'Fantasy'),
    ('Harper Lee', 'To Kill a Mockingbird', '1960-07-11', 'Fiction'),
    ('Elon Musk', 'Tesla, SpaceX, and the Quest for a Fantastic Future', '2015-05-19', 'Technology');
INSERT INTO lms_table (author, book_name, purchase_date, category) 
VALUES 
    ('J.K.', 'Harry Potter and the Philosopher\'s Rock', '2010-07-7', 'Fiction');
alter table loans drop column category_id;  

INSERT INTO loans (user_id, book_id, borrow_date, return_date) 
VALUES -- User 4 borrowed book 9 and returned it
    (1, 12, '2025-03-02','2025-04-02' );        -- User 5 borrowed book 10 and has not returned it yet
    
select * from lms_table;
ALTER TABLE lms_table 
ADD COLUMN category_id BIGINT,
ADD CONSTRAINT fk_books_category2 FOREIGN KEY (category_id) REFERENCES categories(id);
select * from users;
select * from fines;
select * from categories;
UPDATE loans l
JOIN lms_table b ON l.book_id = b.id
SET l.category_id = b.category_id
WHERE b.category_id IS NOT NULL;

ALTER TABLE lms_table MODIFY COLUMN id INT AUTO_INCREMENT;
ALTER TABLE loans 
ADD CONSTRAINT loans_fk FOREIGN KEY (book_id) 
REFERENCES lms_table(id) ON DELETE CASCADE;

SELECT CONSTRAINT_NAME 
FROM information_schema.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'loans' AND COLUMN_NAME = 'book_id';
ALTER TABLE loans DROP FOREIGN KEY loans_ibfk_1;

DELIMITER //

CREATE TRIGGER check_duplicate_category
BEFORE INSERT ON categories
FOR EACH ROW
BEGIN
    DECLARE category_count INT;

    -- Check if the category already exists
    SELECT COUNT(*) INTO category_count 
    FROM categories 
    WHERE category_name = NEW.category_name;

    -- If category exists, throw an error
    IF category_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '⚠️ Category already exists!';
    END IF;
END;
//

DELIMITER ;

CREATE TABLE events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date_time DATETIME NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(255),
    category VARCHAR(100)
);

CREATE TABLE registrations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patron_name VARCHAR(255) NOT NULL,
    patron_email VARCHAR(255) NOT NULL,
    event_id BIGINT,
    attended BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

ALTER TABLE registrations
DROP FOREIGN KEY FK6akauhvfwgy751ff3mk30fk8h;

ALTER TABLE registrations
ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE;

ALTER TABLE lms_table ADD COLUMN available_copies INT DEFAULT 10;