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
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, 1, -2147483648, '2023-01-01', 'nprmdposii');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (2, 1, -2147483648, '2023-01-01', 'unw6klfa');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (3, 1, -2147483648, '2023-01-01', '00t5c4ecigc');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483645, 1, -2147483648, '1970-01-01 00:00:00+00:00', '76nium52');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483644, 1, -2147483648, '2023-01-01', 'uo4nrqrofqy');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (4, 1, -2147483648, '2023-12-31 00:00:01+00:00', '5bbp0');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (5, 1, -2147483648, '1970-01-01 00:00:00+00:00', 'tliqa1');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (6, 1, -2147483648, '1970-01-01 00:00:00+00:00', 'ytoo3o9');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (7, 1, -2147483648, '1970-01-01 00:00:00+00:00', '72klex14ji7z');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (8, 1, -2147483648, '1970-01-01 00:00:00+00:00', '2dwyrq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01 00:00:00' AND '2023-12-31 23:59:59';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT patient_id FROM Appointments WHERE appointment_date BETWEEN '2023-01-01' AND '2023-12-31';

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
*/