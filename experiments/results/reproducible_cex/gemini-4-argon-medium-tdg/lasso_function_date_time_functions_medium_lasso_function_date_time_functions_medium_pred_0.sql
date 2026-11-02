-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact midnight match, non-midnight same-day matches (kills exact string comparison to '2025-01-01 00:00:00' or '2025-01-01'), and adjacent day boundary conditions (kills <, <=, >, >=, BETWEEN mutants).
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'Alice', 'Smith', '1980-05-15', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Bob', 'Jones', '1990-08-20', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Charlie', 'Brown', '1975-12-01', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, 'Diana', 'Prince', '1985-03-10', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (5, 'Evan', 'Wright', '2000-01-01', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (10, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (101, 1, 10, '2025-01-01 00:00:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (102, 2, 10, '2025-01-01 14:30:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (103, 3, 10, '2025-01-01 23:59:59', 'Cancelled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (104, 4, 10, '2024-12-31 23:59:59', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (105, 5, 10, '2025-01-02 00:00:00', 'Scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE DATE(appointment_date) = DATE('2025-01-01 00:00:00');

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE TIME(appointment_date) = TIME('2025-01-01 00:00:00');

/*
Prediction Result:
(1,)
(5,)
*/