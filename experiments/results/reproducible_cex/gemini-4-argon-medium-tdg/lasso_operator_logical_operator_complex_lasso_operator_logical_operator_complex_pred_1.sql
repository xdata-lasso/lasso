-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (10, 'John', 'Doe', '1980-01-01', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (20, 'Jane', 'Smith', '1990-05-12', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (30, 'Alice', 'Brown', '1975-09-23', 'F');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'James', 'Wilson', 'Oncology', 15);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (3, 'Lisa', 'Cuddy', 'Endocrinology', 18);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (101, 10, 1, '2023-10-01 09:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (102, 20, 2, '2023-10-02 10:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (103, 30, 3, '2023-10-03 11:00:00', 'scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' OR (doctor_id = 1 OR doctor_id = 2);

/*
Prediction Result:
(10,)
(20,)
(30,)
*/