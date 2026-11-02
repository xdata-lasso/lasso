-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (101, 'Alice', 'Smith', '1985-04-12', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (102, 'Bob', 'Jones', '1990-08-23', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (103, 'Charlie', 'Brown', '1978-11-05', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (104, 'Diana', 'Prince', '1992-02-19', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (105, 'Evan', 'Wright', '1980-06-30', 'M');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (106, 'Fiona', 'Gallagher', '1995-12-14', 'F');
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (107, 'George', 'Clark', '1988-09-01', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (0, 'Zero', 'Doc', 'General', 5);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Gregory', 'House', 'Diagnostics', 20);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'Meredith', 'Grey', 'Surgery', 12);
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (3, 'Stephen', 'Strange', 'Neurology', 15);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (501, 101, 1, '2025-05-01 09:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (502, 102, 2, '2025-05-01 10:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (503, 103, 2, '2025-05-01 11:00:00', 'completed');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (504, 104, 1, '2025-05-01 12:00:00', 'cancelled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (505, 105, 3, '2025-05-01 13:00:00', 'scheduled');
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (506, 106, 0, '2025-05-01 14:00:00', 'scheduled');
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (901, 501, 'Ibuprofen', '400mg', 7);
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (902, 503, 'Amoxicillin', '500mg', 10);
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
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND doctor_id = 1 OR doctor_id = 2;

/*
Prediction Result:
(101,)
(102,)
(103,)
*/