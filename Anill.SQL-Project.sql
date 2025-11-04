-- 🎓 SQL PROJECT : Student Fee Management System (with Triggers)

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

-- 5️⃣ Trigger 1: AFTER INSERT (Log Payment)
DELIMITER //
CREATE TRIGGER after_fee_insert
AFTER INSERT ON fees
FOR EACH ROW
BEGIN
    INSERT INTO fee_log(student_id, action_done, log_date)
    VALUES (NEW.student_id, 'Fee Paid', NOW());
END //
DELIMITER ;

-- 6️⃣ Trigger 2: BEFORE INSERT (Validate Fee Amount)
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

-- 7️⃣ Insert Sample Data
INSERT INTO students (student_name, student_dept)
VALUES ('Anil', 'Mechanical'),
       ('Jaanu', 'CSE');

-- 8️⃣ Insert Fee Data (to test triggers)
INSERT INTO fees (student_id, amount, payment_date)
VALUES (1, 25000, NOW()), 
       (2, -1000, NOW());   -- This will auto-set to 0 due to trigger

-- 9️⃣ View Results
SELECT * FROM students;
SELECT * FROM fees;
SELECT * FROM fee_log;
