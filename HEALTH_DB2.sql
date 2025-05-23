--- TABLE 1

CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT ,
    doctor_id INT ,
    appointment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
);

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-24 10:30:00', 'Scheduled'),
(2, 2, '2025-05-25 14:00:00', 'Completed'),
(3, 3, '2025-05-26 09:00:00', 'Cancelled'),
(4, 4, '2025-05-27 16:30:00', 'Scheduled'),
(5, 5, '2025-05-28 11:15:00', 'Completed'),
(6, 6, '2025-05-29 13:45:00', 'Scheduled'),
(7, 7, '2025-05-30 15:00:00', 'Cancelled'),
(8, 8, '2025-05-31 17:00:00', 'Scheduled'),
(9, 9, '2025-06-01 08:30:00', 'Completed'),
(10, 10, '2025-06-02 12:30:00', 'Scheduled');

select * from appointments;


--- TABLE 2

CREATE TABLE Medical_Records (
    record_id SERIAL PRIMARY KEY,
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    prescribed_medications TEXT,
    record_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO Medical_Records (diagnosis, treatment, prescribed_medications, record_date) VALUES
('Hypertension', 'Lifestyle changes and medication', 'Amlodipine, Losartan', '2025-05-20'),
('Type 2 Diabetes', 'Insulin therapy and diet control', 'Metformin, Glimepiride', '2025-05-21'),
('Asthma', 'Inhalers and breathing exercises', 'Salbutamol, Budesonide', '2025-05-22'),
('Migraine', 'Pain management and preventive medication', 'Sumatriptan, Propranolol', '2025-05-23'),
('Arthritis', 'Physical therapy and anti-inflammatory drugs', 'Ibuprofen, Celecoxib', '2025-05-24'),
('Bronchitis', 'Antibiotics and cough syrups', 'Amoxicillin, Dextromethorphan', '2025-05-25'),
('Gastric Ulcer', 'Proton pump inhibitors and diet modification', 'Omeprazole, Ranitidine', '2025-05-26'),
('Dermatitis', 'Topical corticosteroids and moisturizers', 'Hydrocortisone, Tacrolimus', '2025-05-27'),
('Hypothyroidism', 'Hormone replacement therapy', 'Levothyroxine', '2025-05-28'),
('Pneumonia', 'Antibiotic therapy and rest', 'Azithromycin, Ceftriaxone', '2025-05-29');

select * from medical_records;


CREATE EXTENSION DBLINK;



select a.*,p.*
from appointments as a
full join dblink('dbname=HEALTH_DB1 user=postgres password=admin',
				'select  patient_id ,  name , age, gender ,contact_number from patients ')
				as p(patient_id INT,name VARCHAR,age INT,gender VARCHAR,contact_number VARCHAR)
ON a.patient_id=p.patient_id;