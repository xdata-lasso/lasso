-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (101, 'Alice', 'Smith', '1980-05-10', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (102, 'Bob', 'Jones', '1992-08-20', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (103, 'Charlie', 'Brown', '1975-11-30', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (104, 'Diana', 'Prince', '1988-03-15', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (105, 'Evan', 'Wright', '1995-07-25', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (201, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 101, 201, '2025-01-01 00:00:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 102, 201, '2025-01-01 14:30:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 103, 201, '2025-01-01', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (4, 104, 201, '2024-12-31 23:59:59', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (5, 105, 201, '2025-01-02 00:00:00', 'Scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE DATE(appointment_date) = DATE('2025-01-01 00:00:00');

/*
Gold Result:
(101,)
(102,)
(103,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE TIME(appointment_date) = TIME('2025-01-01 00:00:00');

/*
Prediction Result:
(101,)
(103,)
(105,)
*/