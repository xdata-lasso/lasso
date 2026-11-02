-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact string comparison vs DATE() extraction, non-midnight timestamps on the target date, and boundary dates (previous/next day).
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'John', 'Doe', '1980-05-15', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Jane', 'Smith', '1992-08-20', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Alice', 'Brown', '1975-12-01', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, 'Bob', 'White', '1988-03-10', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 1, 1, '2025-01-01 00:00:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 2, 1, '2025-01-01 14:30:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 3, 1, '2024-12-31 23:59:59', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (4, 4, 1, '2025-01-02 00:00:00', 'Scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE DATE(appointment_date) = DATE('2025-01-01 00:00:00');

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE TIME(appointment_date) = TIME('2025-01-01 00:00:00');

/*
Prediction Result:
(1,)
(4,)
*/