-- ====================================================================
-- Database Schema for Student Management System
-- Database: sms
-- Table: student
-- ====================================================================

-- 1. Create Database if not exists
CREATE DATABASE IF NOT EXISTS sms;
USE sms;

-- 2. Drop existing table if recreating
DROP TABLE IF EXISTS student;

-- 3. Create Student Table
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL
);

-- 4. Insert Sample Data for Academic Testing
INSERT INTO student (name, email, course) VALUES 
('Farhan Shaikh', 'farhan.shaikh@example.com', 'Computer Science'),
('Sophia Reynolds', 'sophia.reynolds@example.com', 'Information Technology'),
('Alexander Wright', 'alex.wright@example.com', 'Data Science & AI'),
('Priya Sharma', 'priya.sharma@example.com', 'Software Engineering'),
('David Miller', 'david.miller@example.com', 'Business Administration');

-- 5. Verify Table Records
SELECT * FROM student;
