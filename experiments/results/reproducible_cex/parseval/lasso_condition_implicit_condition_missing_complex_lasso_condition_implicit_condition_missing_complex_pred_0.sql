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
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', -1364429300);

-- Inserting into table: appointments --
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, 1, -2147483648, '2025-02-07 06:53:31+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (2, 1, -2147483648, '2022-01-18 15:57:55+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (3, 1, -2147483648, '2021-08-20 16:50:24+00:00', 'app_764217');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483645, 1, -2147483648, '2021-12-31 07:20:26+00:00', 'cancelled');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483644, 1, -2147483648, '2021-02-17 05:47:13+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (4, 1, -2147483648, '2024-02-29 12:08:41+00:00', NULL);

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (5, 1, -2147483648, '2022-12-10 02:38:39+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (6, 1, -2147483648, '2020-09-15 12:11:12+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (7, 1, -2147483648, '2025-05-02 19:47:39+00:00', 'app_e48308');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (8, 1, -2147483648, '2022-07-16 22:41:51+00:00', 'app_e48308');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled' AND appointment_date >= DATETIME('2025-01-01 00:00:00');

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE status <> 'cancelled';

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/