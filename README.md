🎓 SQL PROJECT — Student Fee Management System (with Triggers)

**📌 Overview**

This project demonstrates a simple Student Fee Management System built using MySQL.
It showcases how to use Triggers to automate database actions such as:

Logging student fee payments

Validating incorrect or negative fee amounts

**🧩 Database Structure**

Database Name: fee_mgmt

Tables:

students – Stores student information

fees – Records fee payments

fee_log – Tracks all payment actions automatically

⚙️ Triggers Used

before_fee_insert — Validates fee amount before inserting data

If the amount is negative or zero, it automatically sets it to 0.

after_fee_insert — Logs fee payment automatically in fee_log table

💻 SQL Code
-- 1️⃣ Create Database
CREATE DATABASE fee_mgmt;
USE fee_mgmt;

-- 2️⃣ Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    student_dept VARCHAR(30)
);

-- 3️⃣ Create Fees Table
CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 4️⃣ Create Fee Log Table
CREATE TABLE fee_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    action_done VARCHAR(30),
    log_date DATETIME
);

-- 5️⃣ AFTER INSERT Trigger
DELIMITER //
CREATE TRIGGER after_fee_insert
AFTER INSERT ON fees
FOR EACH ROW
BEGIN
    INSERT INTO fee_log(student_id, action_done, log_date)
    VALUES (NEW.student_id, 'Fee Paid', NOW());
END //
DELIMITER ;

-- 6️⃣ BEFORE INSERT Trigger
DELIMITER //
CREATE TRIGGER before_fee_insert
BEFORE INSERT ON fees
FOR EACH ROW
BEGIN
    IF NEW.amount <= 0 THEN
        SET NEW.amount = 0;
    END IF;
END //
DELIMITER ;

-- 7️⃣ Sample Data
INSERT INTO students (student_name, student_dept)
VALUES ('Anil', 'Mechanical'),
       ('Jaanu', 'CSE');

-- 8️⃣ Test Trigger
INSERT INTO fees (student_id, amount, payment_date)
VALUES (1, 25000, NOW()), 
       (2, -1000, NOW()); -- will set to 0 due to trigger

-- 9️⃣ Check Data
SELECT * FROM students;
SELECT * FROM fees;
SELECT * FROM fee_log;



**🧠 Learning Outcome**
How to create and use MySQL Triggers
Implementing data validation at the database level
Automating logging and tracking user actions
