-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1, '5k5swwqcgs', '9n8', '2020-06-08', 'pgu7vfe4');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -1364429300);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (3, 'dpos', 'ie5', 'nw6klf', 1038707349);

-- Inserting into table: appointments --
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, 1, 1, '2025-02-07 06:53:31+00:00', 'scheduled');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (2, 1, 1, '2021-10-06 00:40:57+00:00', 'scheduled');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (3, 1, 1, '2022-01-18 15:57:55+00:00', 'scheduled');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483645, 1, 1, '2022-04-12 01:47:28+00:00', 'app_e1a15b');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483644, 1, 3, '2024-12-31 04:19:17+00:00', 'scheduled');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483643, 1, 1, '2025-05-02 19:47:39+00:00', 'scheduled');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 OR doctor_id = 2);

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status = 'scheduled' AND (doctor_id = 1 AND appointment_id = 2);

/*
Prediction Result:
(1,)
*/