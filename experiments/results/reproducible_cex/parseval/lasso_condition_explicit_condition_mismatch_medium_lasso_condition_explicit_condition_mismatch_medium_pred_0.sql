-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483648, '5k5swwqcgs', '9n8', '2020-06-08', 'pgu7vfe4');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -1364429300);

-- Inserting into table: appointments --
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, -2147483648, -2147483648, '2025-02-07 06:53:31+00:00', 'prmd');

-- Inserting into table: prescriptions --
INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (-2147483648, -2147483648, 'pre_6fface', '10mg', 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (2, -2147483648, 'pre_6fface', '10mg', 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (3, -2147483648, 'pre_6fface', '10mg', 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (-2147483645, -2147483648, 'pre_6fface', '10mg', 30);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (-2147483644, -2147483648, 'pre_6fface', 'pre_e52865', 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (-2147483643, -2147483648, NULL, '10mg', 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (4, -2147483648, 'unw6klfa', NULL, 31);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (5, -2147483648, '00t5c4ecigc', 'pre_9810b8', 30);

INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (6, -2147483648, '76nium52', NULL, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
('pre_6fface',)
(None,)
('pre_6fface',)
('pre_6fface',)
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND medication_name = '10mg';

/*
Prediction Result:
*/