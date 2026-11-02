-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Duplicate first_name (kills DISTINCT), NULL first_name (kills IS NOT NULL), Join traps (unreferenced patient, patient with multiple appointments), Table/Column confusion (Doctors vs Patients, first_name vs last_name)
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'Alice', 'Smith', '1980-05-15', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Alice', 'Jones', '1992-11-20', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Bob', 'Brown', '1975-03-10', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (4, NULL, 'White', '2000-01-01', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostician', 20);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'James', 'Wilson', 'Oncology', 15);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 1, 1, '2023-10-01 09:00:00', 'Completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 1, 2, '2023-10-02 10:00:00', 'Scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 2, 1, '2023-10-03 11:00:00', 'Cancelled');
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (1, 1, 'Ibuprofen', '400mg', 7);
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (2, 1, 'Amoxicillin', '500mg', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Patients;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
(None,)
*/

-- Prediction Query
SELECT p.first_name FROM Patients AS p JOIN Appointments AS a ON p.patient_id = a.patient_id;

/*
Prediction Result:
('Alice',)
('Alice',)
('Alice',)
*/