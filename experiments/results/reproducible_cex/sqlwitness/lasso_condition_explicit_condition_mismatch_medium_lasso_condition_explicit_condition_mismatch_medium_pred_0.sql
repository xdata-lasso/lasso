-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (29, 'default1', NULL, '10mg', 31), (30, 'default1', '10mg', NULL, 1), (31, 'default2', 'default1', NULL, 29), (0, 'default2', 'default1', 'default1', 31), (1, '10mg', 'default2', 'default1', NULL);
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (29, NULL, 0, NULL, 'default1'), (31, NULL, 1, '2023-01-01 01:00:00.000000', 'default2'), (1, NULL, 30, '2023-01-01 01:00:00.000000', 'default2'), (30, NULL, 30, NULL, '10mg'), (0, NULL, 1, '2023-01-01 00:00:00.000000', 'default1'), (2, NULL, NULL, '2023-01-01 00:00:00.000000', 'default2');
INSERT INTO prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (31, 30, 'default2', NULL, 30), (0, 30, '10mg', 'default2', 31), (30, NULL, NULL, NULL, 1), (29, 31, 'default1', '10mg', 29), (1, 1, '10mg', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND medication_name = '10mg';

/*
Prediction Result:
('10mg',)
*/