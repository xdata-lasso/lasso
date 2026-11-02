-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (2, 'default1', 'default2', 'default2', 2), (1, 'default1', 'default1', NULL, NULL), (0, NULL, NULL, NULL, NULL);
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (3, NULL, 'default2', '2023-01-01', 'default1'), (0, 'default1', 'default2', NULL, 'default2'), (2, 'scheduled', 'default1', '2023-01-01', 'default1'), (1, 'scheduled', NULL, '2023-01-01', NULL), (4, 'scheduled', 'scheduled', '2023-01-01', NULL);
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 3, 0, NULL, 'scheduled'), (0, 4, 2, '2023-01-01 01:00:00.000000', 'scheduled'), (2, 1, 2, '2023-01-01 01:00:00.000000', 'scheduled'), (3, 2, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(4,)
(1,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 AND appointment_id = 2);

/*
Prediction Result:
*/