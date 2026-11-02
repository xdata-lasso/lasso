-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (16, 'scheduled16', 'scheduled16', '1000-01-17', 'scheduled16');
INSERT INTO "Patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (15, 'scheduled16', 'scheduled16', '1000-01-17', 'scheduled16');
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (10, 'scheduled16', 'scheduled16', 'scheduled16', 16);
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (2, 'scheduled16', 'scheduled16', 'scheduled16', 16);
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (9, 15, 10, 13, 'scheduled');
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (8, 16, 2, 14, 'scheduled');
INSERT INTO "Prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (12, 8, 'scheduled16', 'scheduled16', 16);
INSERT INTO "Prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (11, 8, 'scheduled16', 'scheduled16', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(16,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' OR (doctor_id = 1 OR doctor_id = 2);

/*
Prediction Result:
(16,)
(15,)
*/