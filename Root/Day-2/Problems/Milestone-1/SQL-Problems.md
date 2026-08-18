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
-- ==========================================
-- BILLING
-- ==========================================
CREATE TABLE billing (
bill
_
id INT PRIMARY KEY,
appointment
_
id INT,
bill
_
amount DECIMAL(10,2),
payment
_
status VARCHAR(20),
FOREIGN KEY(appointment
_
id)
REFERENCES appointments(appointment
_
id)
);
LTMB12-SQL Practice - Set1
INSERT INTO billing VALUES
(1,1001,1000,
'Paid'),
(2,1002,1500,
'Paid'),
(3,1003,1000,
'Pending'),
(4,1004,1200,
'Paid'),
(5,1005,0,
'Cancelled'),
(6,1006,900,
'Paid'),
(7,1007,850,
'Paid'),
(8,1008,700,
'Paid'),
(9,1009,1300,
'Pending'),
(10,1010,1200,
'Paid'),
(11,1011,1800,
'Paid'),
(12,1012,1400,
'Paid'),
(13,1013,0,
'Cancelled'),
(14,1014,900,
'Paid'),
(15,1015,850,
'Paid'),
(16,1016,700,
'Pending'),
(17,1017,1300,
'Paid'),
(18,1018,1200,
'Paid'),
(19,1019,1800,
'Paid'),
(20,1020,1400,
'Pending'),
(21,1021,1100,
'Paid'),
(22,1022,900,
'Paid'),
(23,1023,850,
'Paid'),
(24,1024,700,
'Paid'),
(25,1025,0,
'Cancelled');
-- ==========================================
-- TREATMENTS
-- ==========================================
CREATE TABLE treatments (
treatment
_
id INT PRIMARY KEY,
appointment
_
id INT,
treatment
_
name VARCHAR(100),
treatment
_
cost DECIMAL(10,2),
FOREIGN KEY(appointment
_
id)
REFERENCES appointments(appointment
_
id)
);
INSERT INTO treatments VALUES
(1,1001,
'ECG'
,500),
(2,1002,
'Brain Scan'
,2500),
LTMB12-SQL Practice - Set1
(3,1004,
'Knee X-Ray'
,1200),
(4,1006,
'Vaccination'
,300),
(5,1007,
'Ear Cleaning'
,400),
(6,1008,
'General Checkup'
,250),
(7,1010,
'ECG'
,500),
(8,1011,
'MRI Scan'
,3500),
(9,1012,
'Bone Scan'
,1800),
(10,1014,
'Vaccination'
,300),
(11,1015,
'ENT Checkup'
,500),
(12,1017,
'Pregnancy Scan'
,2200),
(13,1018,
'Stress Test'
,900),
(14,1019,
'Neurology Test'
,4000),
(15,1021,
'Pulmonary Function Test'
,1600);
-- ==========================================
-- MEDICINES
-- ==========================================
CREATE TABLE medicines (
medicine
_
id INT PRIMARY KEY,
medicine
_
name VARCHAR(100),
medicine
_price DECIMAL(10,2)
);
INSERT INTO medicines VALUES
(1,
'Paracetamol'
,20),
(2,
'Amoxicillin'
,120),
(3,
'Aspirin'
,50),
(4,
'Metformin'
,180),
(5,
'Atorvastatin'
,250),
(6,
'Omeprazole'
,90),
(7,
'Cetirizine'
,40),
(8,
'Vitamin D'
,150);
-- ==========================================
-- PRESCRIPTIONS
-- ==========================================
CREATE TABLE prescriptions (
prescription
_
id INT PRIMARY KEY,
appointment
_
id INT,
medicine
_
id INT,
quantity INT,
LTMB12-SQL Practice - Set1
FOREIGN KEY(appointment
_
id)
REFERENCES appointments(appointment
_
id),
FOREIGN KEY(medicine
_
id)
REFERENCES medicines(medicine
_
id)
);
INSERT INTO prescriptions VALUES
(1,1001,1,10),
(2,1001,3,5),
(3,1002,2,7),
(4,1004,5,15),
(5,1006,7,10),
(6,1007,6,5),
(7,1008,1,10),
(8,1010,4,20),
(9,1011,5,30),
(10,1012,3,15),
(11,1014,8,10),
(12,1015,7,5),
(13,1017,2,10),
(14,1018,1,20),
(15,1019,5,15);
-- ==========================================
-- APPOINTMENT AUDIT
-- ==========================================
CREATE TABLE appointment
_
audit (
audit
_
id INT AUTO
_
INCREMENT PRIMARY KEY,
appointment
_
id INT,
action
_
type VARCHAR(50),
action
_
time TIMESTAMP DEFAULT CURRENT
_
TIMESTAMP
);
LTMB12-SQL Practice - Set1
-- ==========================================
-- DATA SUMMARY
-- ==========================================
-- Patients : 20
-- Doctors : 12
-- Appointments : 25
-- Billing : 25
-- Treatments : 15
-- Medicines : 8
-- Prescriptions : 15
-- Audit Table : Empty (for Trigger Practice)
-- ==========================================
This dataset is large enough to practice the following Topics:
All Joins (INNER, LEFT, RIGHT, SELF)
Aggregate Functions
GROUP BY / HAVING
Subqueries
CTEs
Window Functions (ROW
_
NUMBER, RANK, DENSE
_
RANK, LAG, LEAD)
Views
Stored Procedures
Functions
Triggers
Case Statements
Real-world Hospital Analytics and Reporting Queries.
LTMB12-SQL Practice - Set1
Easy Level Questions (2 Marks Each × 5 =
10 Marks)
1. Inner Join
Scenario:
The hospital administrator wants to know which patients have successfully completed
appointments and the doctors they consulted.
Question:
Write a query to display:
●
Patient Name
●
Doctor Name
●
Appointment Date
for all appointments with status = 'Completed'
.
2. Left Join
Scenario:
The finance team wants to identify all appointments and check whether a bill has been
generated for each appointment.
Question:
Write a query to display:
●
Appointment ID
●
Appointment Date
●
Bill Amount
Show all appointments even if billing information is missing.
LTMB12-SQL Practice - Set1
3. Simple Subquery
Scenario:
Management wants to identify doctors who charge more than the average consultation fee.
Question:
Write a query to display:
●
Doctor ID
●
Doctor Name
●
Consultation Fee
for doctors whose consultation fee is greater than the average consultation fee of all doctors.
4. Join with Aggregate Function
Scenario:
The hospital director wants to know how many appointments each doctor handled.
Question:
Write a query to display:
●
Doctor Name
●
Total Appointments
for every doctor.
LTMB12-SQL Practice - Set1
5. Join with Aggregate Function + HAVING
Scenario:
The management wants to reward doctors who handled more than 2 appointments.
Question:
Write a query to display:
●
Doctor Name
●
Total Appointments
for doctors who handled more than 2 appointments.
Medium Level Questions (4 Marks Each ×
5 = 20 Marks)
1. Join + Subquery
Scenario:
The medical director wants to identify patients who consulted doctors from the Cardiology
department.
Question:
Write a query to display:
●
Patient Name
●
Doctor Name
●
Appointment Date
Use a subquery to first identify all Cardiology doctors.
LTMB12-SQL Practice - Set1
2. Join + Aggregate + Subquery
Scenario:
Management wants to identify doctors whose total generated billing amount is greater than the
average billing generated by all doctors.
Question:
Write a query to display:
●
Doctor Name
●
Total Revenue Generated
Only show doctors whose total revenue is above the average doctor revenue.
3. Join with Window Function (ROW
_
NUMBER)
Scenario:
The hospital wants to find the most recent appointment for every patient.
Question:
Write a query to display:
●
Patient Name
●
Appointment Date
●
Doctor Name
Return only the latest appointment of each patient using ROW
_
NUMBER().
4. Join with Window Function (RANK)
Scenario:
The finance team wants to rank doctors based on total billing revenue generated.
Question:
LTMB12-SQL Practice - Set1
Write a query to display:
●
Doctor Name
●
Total Revenue
●
Revenue Rank
Use RANK() to assign rankings based on revenue generated.
5. Complex Join + Aggregate + Window Function
Scenario:
The hospital CEO wants to identify the highest revenue-generating doctor within each
specialization.
Question:
Write a query to display:
●
Specialization
●
Doctor Name
●
Total Revenue
Return only the top revenue-generating doctor from each specialization using a window
function.
LTMB12-SQL Practice - Set1
SQL Joins + Window Functions (20
Scenario-Based Questions)
Dataset: Hospital Management System
These questions are written in a real-world business format suitable for assessments,
interviews, and lab exercises.
1. Latest Appointment for Every Patient
Scenario
The hospital administration wants to send follow-up feedback forms to patients based on their
most recent visit.
Question
Write a query to display the latest appointment details for every patient, including:
●
Patient Name
●
Appointment Date
●
Doctor Name
Return only the most recent appointment for each patient.
LTMB12-SQL Practice - Set1
2. Rank Doctors Based on Consultation
Fees
Scenario
The HR department wants to analyze the fee structure of doctors across the hospital.
Question
Write a query to rank all doctors based on their consultation fees from highest to lowest.
Display:
●
Doctor Name
●
Specialization
●
Consultation Fee
●
Rank
3. Highest Bill Generated by Each Patient
Scenario
The finance team wants to identify the largest bill paid by each patient.
Question
Write a query to display the highest bill amount generated by every patient.
Display:
●
Patient Name
●
Bill Amount
●
Appointment Date
Return only the highest bill for each patient.
LTMB12-SQL Practice - Set1
4. Rank Doctors by Total Revenue
Scenario
Hospital management wants to evaluate doctor performance based on revenue generated
through appointments.
Question
Write a query to rank doctors based on the total billing revenue they have generated.
Display:
●
Doctor Name
●
Total Revenue
●
Revenue Rank
5. Most Expensive Treatment Handled by
Each Doctor
Scenario
The medical director wants to know the costliest treatment handled by every doctor.
Question
Write a query to display the most expensive treatment performed under each doctor.
Display:
●
Doctor Name
●
Treatment Name
●
Treatment Cost
Return only one record per doctor.
LTMB12-SQL Practice - Set1
6. Appointment Numbering for Patients
Scenario
The patient care team wants to track how many times each patient has visited the hospital.
Question
Write a query to assign a sequence number to every appointment of each patient based on
appointment date.
Display:
●
Patient Name
●
Appointment Date
●
Visit Number
7. Dense Ranking of Doctors by Revenue
Scenario
The CEO wants to create a leaderboard of doctors based on revenue generation.
Question
Write a query to assign dense rankings to doctors based on total billing revenue.
Display:
●
Doctor Name
●
Revenue
●
Dense Rank
LTMB12-SQL Practice - Set1
8. Previous Appointment Date of Every
Patient
Scenario
The hospital wants to analyze the frequency of patient visits.
Question
Write a query to display each appointment along with the previous appointment date of the
same patient.
Display:
●
Patient Name
●
Current Appointment Date
●
Previous Appointment Date
9. Next Appointment Date of Every Patient
Scenario
The appointment scheduling team wants to predict upcoming patient visits.
Question
Write a query to display each appointment along with the next appointment date of the same
patient.
Display:
●
Patient Name
●
Current Appointment Date
●
Next Appointment Date
LTMB12-SQL Practice - Set1
10. Highest Revenue Doctor in Each
Specialization
Scenario
The hospital board wants to recognize the top-performing doctor from every specialization.
Question
Write a query to identify the doctor who generated the highest billing revenue within each
specialization.
Display:
●
Specialization
●
Doctor Name
●
Total Revenue
11. Rank Patients Based on Total Hospital
Spending
Scenario
The finance department wants to identify high-value patients based on overall spending.
Question
Write a query to rank patients according to the total amount billed across all their appointments.
Display:
●
Patient Name
●
Total Billing Amount
●
Rank
LTMB12-SQL Practice - Set1
12. Latest Treatment Received by Each
Patient
Scenario
The medical records department wants to maintain the latest treatment history of every patient.
Question
Write a query to display the most recent treatment received by each patient.
Display:
●
Patient Name
●
Treatment Name
●
Appointment Date
13. Top 2 Revenue-Generating Doctors
Scenario
The hospital management wants to award the best-performing doctors of the month.
Question
Write a query to identify the top 2 doctors based on total revenue generated.
Display:
●
Doctor Name
●
Total Revenue
●
Rank
LTMB12-SQL Practice - Set1
14. Running Revenue Generated by Each
Doctor
Scenario
The finance team wants to track how revenue accumulates over time for every doctor.
Question
Write a query to display the cumulative billing revenue generated by each doctor after every
appointment.
Display:
●
Doctor Name
●
Appointment Date
●
Bill Amount
●
Running Revenue
15. Difference Between Current and
Previous Bill
Scenario
The hospital wants to study spending patterns of repeat patients.
Question
Write a query to display the difference between the current bill amount and the previous bill
amount for every patient.
Display:
●
Patient Name
●
Appointment Date
●
Current Bill
●
Previous Bill
●
Difference
LTMB12-SQL Practice - Set1
16. Most Frequently Visited Doctor for
Each Patient
Scenario
The hospital wants to understand patient loyalty towards doctors.
Question
Write a query to identify the doctor whom each patient has visited the most.
Display:
●
Patient Name
●
Doctor Name
●
Total Visits
Return only one doctor per patient.
17. Rank Treatments by Cost Within Each
Doctor
Scenario
The operations team wants to analyze the treatment portfolio of each doctor.
Question
Write a query to rank treatments handled by each doctor based on treatment cost.
Display:
●
Doctor Name
●
Treatment Name
●
Treatment Cost
●
Treatment Rank
LTMB12-SQL Practice - Set1
18. First Appointment of Every Patient
Scenario
The hospital wants to study patient onboarding trends.
Question
Write a query to display the first appointment recorded for every patient.
Display:
●
Patient Name
●
Appointment Date
●
Doctor Name
Return only the earliest appointment for each patient.
19. Doctor Revenue Contribution
Percentage
Scenario
Management wants to understand how much each doctor contributes to the hospital's overall
revenue.
Question
Write a query to calculate the percentage contribution of each doctor to the total hospital billing
revenue.
Display:
●
Doctor Name
●
Revenue Generated
●
Revenue Contribution %
LTMB12-SQL Practice - Set1
20. Top 3 Patients by Spending in Each
City
Scenario
The hospital marketing team wants to identify the most valuable patients in every city.
Question
Write a query to find the top 3 patients based on total billing amount within each city.
Display:
●
City
●
Patient Name
●
Total Billing Amount
●
Rank within City
Return only the top 3 patients from every city.
