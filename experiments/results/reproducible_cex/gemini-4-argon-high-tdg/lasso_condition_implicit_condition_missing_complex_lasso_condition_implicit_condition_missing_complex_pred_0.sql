-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'Alice', 'Smith', '1990-05-14', 'Female');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Bob', 'Jones', '1985-08-22', 'Male');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Charlie', 'Brown', '1978-11-30', 'Male');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, 'Diana', 'Prince', '1995-02-10', 'Female');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (10, 'Gregory', 'House', 'Diagnostics', 20);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (20, 'Meredith', 'Grey', 'Surgery', 12);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (100, 1, 10, '2025-02-15 10:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (200, 2, 10, '2025-02-15 10:00:00', 'cancelled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (300, 3, 20, '2024-11-20 09:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (400, 4, 20, '2024-11-20 09:00:00', 'cancelled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled' AND appointment_date >= DATETIME('2025-01-01 00:00:00');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled';

/*
Prediction Result:
(1,)
(3,)
*/