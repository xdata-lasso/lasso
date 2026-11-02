-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (3, NULL, 'default1', 'scheduled', 2), (1, 'default2', 'default2', 'default1', 3);
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, NULL, NULL, '2023-01-01 01:00:00.000000', 'scheduled'), (3, NULL, 1, NULL, NULL), (0, NULL, 1, NULL, 'scheduled'), (2, NULL, 3, NULL, 'default2'), (4, NULL, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' OR (doctor_id = 1 OR doctor_id = 2);

/*
Prediction Result:
(None,)
(None,)
(None,)
(None,)
*/