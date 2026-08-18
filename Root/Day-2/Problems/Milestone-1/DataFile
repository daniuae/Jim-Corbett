-- ==========================================
-- HOSPITAL MANAGEMENT DATABASE
-- ALL TABLES + DATA IN ONE SCRIPT
-- ==========================================
CREATE DATABASE hospital
_
db;
USE hospital
_
db;
-- ==========================================
-- PATIENTS
-- ==========================================
CREATE TABLE patients (
patient
_
id INT PRIMARY KEY,
patient
_
name VARCHAR(100),
gender VARCHAR(10),
age INT,
city VARCHAR(50)
);
INSERT INTO patients VALUES
(1,
'Rahul'
,
'Male'
,35,
'Chennai'),
(2,
'Priya'
,
'Female'
,28,
'Bangalore'),
(3,
'Arun'
,
'Male'
,45,
'Hyderabad'),
(4,
'Sneha'
,
'Female'
,31,
'Mumbai'),
(5,
'Kiran'
,
'Male'
,50,
'Delhi'),
(6,
'Ramesh Kumar'
,
'Male'
,42,
'Chennai'),
(7,
'Lakshmi Devi'
,
'Female'
,36,
'Coimbatore'),
(8,
'Suresh Babu'
,
'Male'
,29,
'Madurai'),
(9,
'Anitha Rao'
,
'Female'
,55,
'Bangalore'),
(10,
'Vijay Sharma'
,
'Male'
,61,
'Mumbai'),
(11,
'Deepa Nair'
,
'Female'
,48,
'Kochi'),
(12,
'Karthik Raj'
,
'Male'
,34,
'Chennai'),
(13,
'Meena Patel'
,
'Female'
,40,
'Ahmedabad'),
(14,
'Rohit Singh'
,
'Male'
,27,
'Delhi'),
(15,
'Pooja Gupta'
,
'Female'
,31,
'Hyderabad'),
(16,
'Naveen Kumar'
,
'Male'
,45,
'Pune'),
(17,
'Shalini Verma'
,
'Female'
,52,
'Lucknow'),
(18,
'Ajay Das'
,
'Male'
,38,
'Kolkata'),
(19,
'Neha Reddy'
,
'Female'
,24,
'Hyderabad'),
(20,
'Manoj Jain'
,
'Male'
,58,
'Jaipur');
-- ==========================================
LTMB12-SQL Practice - Set1
-- DOCTORS
-- ==========================================
CREATE TABLE doctors (
doctor
_
id INT PRIMARY KEY,
doctor
_
name VARCHAR(100),
specialization VARCHAR(50),
consultation
_
fee DECIMAL(10,2)
);
INSERT INTO doctors VALUES
(101,
'Dr. Kumar'
,
'Cardiology'
,1000),
(102,
'Dr. Mehta'
,
'Neurology'
,1500),
(103,
'Dr. Sharma'
,
'Orthopedics'
,1200),
(104,
'Dr. Reddy'
,
'Dermatology'
,800),
(105,
'Dr. Anjali Iyer'
,
'Pediatrics'
,900),
(106,
'Dr. Rajesh Gupta'
,
'ENT'
,850),
(107,
'Dr. Vivek Menon'
,
'General Medicine'
,700),
(108,
'Dr. Sunita Shah'
,
'Gynecology'
,1300),
(109,
'Dr. Akash Verma'
,
'Cardiology'
,1200),
(110,
'Dr. Harish Rao'
,
'Neurology'
,1800),
(111,
'Dr. Kavitha Devi'
,
'Orthopedics'
,1400),
(112,
'Dr. Prakash Nair'
,
'Pulmonology'
,1100);
-- ==========================================
-- APPOINTMENTS
-- ==========================================
CREATE TABLE appointments (
appointment
_
id INT PRIMARY KEY,
patient
_
id INT,
doctor
_
id INT,
appointment
_
date DATE,
status VARCHAR(20),
FOREIGN KEY(patient
_
id)
REFERENCES patients(patient
_
id),
FOREIGN KEY(doctor
_
id)
REFERENCES doctors(doctor
_
id)
);
LTMB12-SQL Practice - Set1
INSERT INTO appointments VALUES
(1001,1,101,
'2025-05-01'
,
'Completed'),
(1002,2,102,
'2025-05-03'
,
'Completed'),
(1003,3,101,
'2025-05-05'
,
'Pending'),
(1004,4,103,
'2025-05-06'
,
'Completed'),
(1005,5,104,
'2025-05-08'
,
'Cancelled'),
(1006,6,105,
'2025-05-10'
,
'Completed'),
(1007,7,106,
'2025-05-11'
,
'Completed'),
(1008,8,107,
'2025-05-11'
,
'Completed'),
(1009,9,108,
'2025-05-12'
,
'Pending'),
(1010,10,109,
'2025-05-12'
,
'Completed'),
(1011,11,110,
'2025-05-13'
,
'Completed'),
(1012,12,111,
'2025-05-13'
,
'Completed'),
(1013,13,112,
'2025-05-14'
,
'Cancelled'),
(1014,14,105,
'2025-05-14'
,
'Completed'),
(1015,15,106,
'2025-05-15'
,
'Completed'),
(1016,16,107,
'2025-05-16'
,
'Pending'),
(1017,17,108,
'2025-05-17'
,
'Completed'),
(1018,18,109,
'2025-05-17'
,
'Completed'),
(1019,19,110,
'2025-05-18'
,
'Completed'),
(1020,20,111,
'2025-05-18'
,
'Pending'),
(1021,1,112,
'2025-05-19'
,
'Completed'),
(1022,2,105,
'2025-05-20'
,
'Completed'),
(1023,3,106,
'2025-05-20'
,
'Completed'),
(1024,4,107,
'2025-05-21'
,
'Completed'),
(1025,5,108,
'2025-05-21'
,
'Cancelled');
