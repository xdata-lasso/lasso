-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483648, 'pat_f5577d', '5k5swwqcgs', '2021-12-04', '9n8c4pgu7v');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (2, 'pat_f5577d', 'e4', '2021-05-05', 'ia2yp');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (3, 'pat_f5577d', 'uzhsrwbbp6lu', '2021-04-10', 'dlttil');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483645, NULL, 'n', '2022-09-14', 'mdpos');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Patients;

/*
Gold Result:
('pat_f5577d',)
(None,)
('pat_f5577d',)
('pat_f5577d',)
*/

-- Prediction Query
SELECT p.first_name FROM Patients AS p JOIN Appointments AS a ON p.patient_id = a.patient_id;

/*
Prediction Result:
*/