-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'Alice', 'Anderson', '1985-04-12', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Bob', 'Brown', '1990-08-23', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Charlie', 'Clark', '1978-11-05', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Diana', 'Davis', 'Cardiology', 12);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'Edward', 'Evans', 'Neurology', 8);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (3, 'Fiona', 'Foster', 'Pediatrics', 15);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 2, 3, '2023-05-10 10:00:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 3, 1, '2023-05-11 14:30:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 1, 2, '2023-05-12 09:15:00', 'Completed');
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (1, 1, 'Amoxicillin', '500mg', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('Bob', 'Fiona')
('Charlie', 'Diana')
('Alice', 'Edward')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.doctor_id = p.patient_id JOIN Doctors AS d ON a.patient_id = d.doctor_id;

/*
Prediction Result:
('Charlie', 'Edward')
('Alice', 'Fiona')
('Bob', 'Diana')
*/