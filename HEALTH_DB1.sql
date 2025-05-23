--- TABLE 1

CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    age INT CHECK (age >= 0),
    gender VARCHAR CHECK (gender IN ('Male', 'Female', 'Other')),
    contact_number VARCHAR UNIQUE
);

INSERT INTO Patients (name, age, gender, contact_number) VALUES
('Amit Kumar', 35, 'Male', '9876543210'),
('Sneha Verma', 28, 'Female', '9123456780'),
('Rajesh Singh', 42, 'Male', '9765432109'),
('Priya Sharma', 31, 'Female', '9156789023'),
('Arun Mehta', 50, 'Male', '9812345678'),
('Deepa Iyer', 26, 'Female', '9923456710'),
('Vikram Patel', 39, 'Male', '9786543212'),
('Pooja Joshi', 22, 'Female', '9034567891'),
('Rohan Das', 45, 'Male', '9898765432'),
('Megha Sen', 29, 'Female', '9109876543');

select * from patients;


--- TABLE 2

CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    specialization VARCHAR,
    experience INT CHECK (experience >= 0),
    contact_number VARCHAR UNIQUE
);

INSERT INTO Doctors (name, specialization, experience, contact_number) VALUES
('Dr. Ramesh Gupta', 'Cardiology', 15, '9812345670'),
('Dr. Anjali Mehta', 'Neurology', 12, '9923456781'),
('Dr. Sandeep Verma', 'Orthopedics', 20, '9765432102'),
('Dr. Priyanka Sharma', 'Dermatology', 8, '9156789034'),
('Dr. Arun Patel', 'Pediatrics', 18, '9876543215'),
('Dr. Meera Iyer', 'Oncology', 14, '9786543226'),
('Dr. Vikram Joshi', 'Gynecology', 10, '9034567897'),
('Dr. Pooja Sen', 'Psychiatry', 9, '9109876548'),
('Dr. Rohan Das', 'Endocrinology', 16, '9898765429'),
('Dr. Sneha Kulkarni', 'Radiology', 11, '9123456783');

select * from doctors;




CREATE EXTENSION DBLINK;

select p.*,a.*
from patients as p
full join dblink(
		'dbname=HEALTH_DB2 user=postgres password=admin',
		'select appointment_id , patient_id , doctor_id, appointment_date , status from appointments '
) as a(appointment_id INT,patient_id INT,doctor_id INT,appointment_date TIMESTAMP,status VARCHAR )
ON p.patient_id=a.patient_id;
