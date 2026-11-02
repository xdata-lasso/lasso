-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483648, 'pat_7954f6', 'pat_60f15c', '2025-06-17', '5sw');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483647, 'pat_7954f6', NULL, '2024-01-05', 'cgsk9');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483646, NULL, 'pat_60f15c', '2022-04-27', '8c4pgu7vfe');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (2, 'A', 'A', '2025-06-04', 'hria2ypuzhs');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (3, 'A', 'O', '2023-01-03', 'wbbp6luhvdlt');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (4, 'A', 'G', '2023-05-30', 'lbn');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (5, 'A', 'O', '2022-09-14', 'mdpos');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (6, 'A', 'O', '2021-06-28', 'e5u');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (7, 'A', 'G', '2022-06-13', '6klfa9');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (8, 'A', 'O', '2024-07-24', '00t5c4ecigc');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (9, 'A', 'O', '2020-10-26', '76nium52');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (10, 'A', 'G', '2024-06-13', 'u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name || ' ' || last_name FROM Patients;

/*
Gold Result:
('pat_7954f6 pat_60f15c',)
(None,)
(None,)
('A A',)
('A O',)
('A G',)
('A O',)
('A O',)
('A G',)
('A O',)
('A O',)
('A G',)
*/

-- Prediction Query
SELECT first_name || last_name FROM Patients;

/*
Prediction Result:
('pat_7954f6pat_60f15c',)
(None,)
(None,)
('AA',)
('AO',)
('AG',)
('AO',)
('AO',)
('AG',)
('AO',)
('AO',)
('AG',)
*/