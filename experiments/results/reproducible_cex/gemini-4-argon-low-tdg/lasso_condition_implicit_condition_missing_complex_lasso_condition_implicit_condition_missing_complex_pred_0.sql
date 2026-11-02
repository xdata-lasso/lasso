-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on appointment_date, status equality vs inequality, and logical AND vs OR.
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'John', 'Doe', '1980-01-01', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Jane', 'Smith', '1985-05-12', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Alice', 'Brown', '1990-08-22', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, 'Bob', 'White', '1975-11-30', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (5, 'Charlie', 'Black', '1995-03-15', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (101, 1, 1, '2025-01-01 00:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (102, 2, 1, '2024-12-31 23:59:59', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (103, 3, 1, '2025-01-01 00:00:00', 'cancelled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (104, 4, 1, '2025-06-15 10:30:00', 'completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (105, 5, 1, '2024-06-15 10:30:00', 'cancelled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled' AND appointment_date >= DATETIME('2025-01-01 00:00:00');

/*
Gold Result:
(1,)
(4,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled';

/*
Prediction Result:
(1,)
(2,)
(4,)
*/