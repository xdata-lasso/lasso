-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, '2023-01-01', '2023-01-01 00:00:00', 'default1', 0), (0, 'default1', 'default1', NULL, NULL), (2, '2023-12-31 23:59:59', 'default2', '2023-12-31 23:59:59', 1), (3, 'default2', '2023-01-01 00:00:00', '2023-01-01', NULL);
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (0, NULL, '2023-01-01', '2023-01-02', 'default1'), (1, '2023-01-01', '2023-01-01 00:00:00', '2023-12-30', '2023-01-01'), (2, '2023-12-31', '2023-01-01', '2023-12-30', '2023-01-01 00:00:00'), (3, '2023-12-31 23:59:59', NULL, NULL, 'default1'), (4, '2023-12-31 23:59:59', '2023-12-31', '2023-01-01', '2023-12-31 23:59:59');
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (0, 2, NULL, '2023-12-31 00:00:00.000000', 'default2'), (1, 2, 1, '2023-12-31 23:59:59.000000', 'default1'), (2, 3, 3, NULL, '2023-01-01 00:00:00'), (3, 0, 3, NULL, '2023-12-31 23:59:59'), (4, 4, 3, '2023-12-31 00:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59';

/*
Gold Result:
(2,)
(4,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01' AND '2023-12-31';

/*
Prediction Result:
*/