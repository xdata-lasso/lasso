-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'John', 'Doe', '2023-05-05', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Jane', 'Smith', '1990-01-01', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Alice', 'Brown', '1985-07-12', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, 'Bob', 'White', '1970-11-23', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (5, 'Charlie', 'Green', '2000-03-15', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (6, 'Diana', 'Prince', '1995-08-08', 'F');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (10, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (101, 1, 10, '2022-12-31 23:59:59', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (102, 2, 10, '2023-01-01 00:00:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (103, 3, 10, '2023-06-15 12:30:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (104, 4, 10, '2023-12-31 00:00:00', 'Cancelled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (105, 5, 10, '2023-12-31 23:59:59', 'No-Show');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (106, 6, 10, '2024-01-01 00:00:00', 'Completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59';

/*
Gold Result:
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01' AND '2023-12-31';

/*
Prediction Result:
(2,)
(3,)
*/