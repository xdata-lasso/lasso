-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'default1', 'default2', 'default2', NULL), (31, 'default1', 'default1', '10mg', NULL), (30, 'default1', '10mg', '10mg', 0);
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (0, NULL, '10mg', NULL, 'default1'), (30, 'default1', '10mg', '2023-01-02', '10mg');
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (31, 0, NULL, NULL, NULL), (30, 0, NULL, '2023-01-01 01:00:00.000000', '10mg'), (1, 0, 31, '2023-01-01 00:00:00.000000', '10mg');
INSERT INTO prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (1, NULL, '10mg', '10mg', NULL), (29, 1, NULL, '10mg', 31), (31, 1, '10mg', 'default2', 29), (30, 1, '10mg', NULL, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE medication_name > 30 AND dosage = '10mg';

/*
Prediction Result:
*/