-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (9, '10mg', '10mg', '0001-01-01', '10mg');
INSERT INTO "Patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (8, '10mg', '10mg', '0001-01-01', '10mg');
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (11, '10mg', '10mg', '10mg', -321314605819753421);
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (10, '10mg', '10mg', '10mg', -321314605819753421);
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (16, NULL, 10, -321314605819753421, '10mg');
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (12, 9, NULL, -321314605819753421, '10mg');
INSERT INTO "Prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (14, NULL, NULL, '10mg', 797);
INSERT INTO "Prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (13, 16, '10mg', '10mg', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
('10mg',)
(None,)
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND medication_name = '10mg';

/*
Prediction Result:
('10mg',)
*/