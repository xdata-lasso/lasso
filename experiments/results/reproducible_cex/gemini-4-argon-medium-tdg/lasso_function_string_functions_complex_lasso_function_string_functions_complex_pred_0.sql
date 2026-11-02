-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard concatenation, duplicate full names (kills DISTINCT mutants), and Doctors vs Patients table confusion.
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'Alice', 'Smith', '1980-01-01', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (2, 'Alice', 'Smith', '1992-05-15', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, 'Bob', 'Jones', '1975-11-30', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostic', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name || ' ' || last_name FROM Patients;

/*
Gold Result:
('Alice Smith',)
('Alice Smith',)
('Bob Jones',)
*/

-- Prediction Query
SELECT first_name || last_name FROM Patients;

/*
Prediction Result:
('AliceSmith',)
('AliceSmith',)
('BobJones',)
*/