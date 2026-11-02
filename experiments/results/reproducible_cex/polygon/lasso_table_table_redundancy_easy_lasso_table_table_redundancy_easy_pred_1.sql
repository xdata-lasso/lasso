-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (10, NULL, '18', '1000-01-20', '20');
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (11, '17', '17', '17', 17);
INSERT INTO "Doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (16, '17', '17', '17', 17);
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (13, 10, NULL, 21, NULL);
INSERT INTO "Appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (12, NULL, 16, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Patients;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT first_name FROM Patients CROSS JOIN Appointments;

/*
Prediction Result:
(None,)
(None,)
*/