-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1033, 'Jesse', 'Garcia', 'fall', 1034);
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1035, 'Shawn', 'Flowers', '1978-09-09', 'commercial');
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (1036, 1035, 1033, '2024-12-31 12:00:00', 'hospital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled' AND appointment_date >= DATETIME('2025-01-01 00:00:00');

/*
Gold Result:
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled';

/*
Prediction Result:
(1035,)
*/