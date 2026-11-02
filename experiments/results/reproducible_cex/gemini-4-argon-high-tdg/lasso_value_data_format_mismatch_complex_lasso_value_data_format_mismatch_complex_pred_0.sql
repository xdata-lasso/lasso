-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (101, 'Alice', 'Smith', '1985-04-12', 'Female');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (102, 'Bob', 'Jones', '1990-08-23', 'Male');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (103, 'Charlie', 'Brown', '1978-11-05', 'Male');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (104, 'Diana', 'Prince', '1995-02-19', 'Female');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (105, 'Evan', 'Wright', '2001-07-30', 'Male');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (201, 'Gregory', 'House', 'Diagnostics', 20);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (202, 'Meredith', 'Grey', 'General Surgery', 12);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 101, 201, '2022-12-31 23:59:59', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 102, 201, '2023-01-01 00:00:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 103, 202, '2023-06-15 14:30:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (4, 104, 202, '2023-12-31 23:59:59', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (5, 105, 201, '2024-01-01 00:00:00', 'Scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59';

/*
Gold Result:
(102,)
(103,)
(104,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01' AND '2023-12-31';

/*
Prediction Result:
(102,)
(103,)
*/