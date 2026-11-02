-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (101, 'Alice', 'Smith', '1990-01-01', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (102, 'Bob', 'Jones', '1985-05-05', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (103, 'Charlie', 'Brown', '1970-10-10', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (104, 'Diana', 'Prince', '1995-12-12', 'F');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (0, 'Zero', 'Doc', 'General', 1);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'One', 'Doc', 'Cardiology', 10);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'Two', 'Doc', 'Neurology', 5);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (3, 'Three', 'Doc', 'Pediatrics', 8);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 101, 1, '2023-10-01 10:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (2, 102, 2, '2023-10-02 11:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (3, 103, 0, '2023-10-03 12:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (4, 104, 3, '2023-10-04 13:00:00', 'scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 AND appointment_id = 2);

/*
Prediction Result:
*/