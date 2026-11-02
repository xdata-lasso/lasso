-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1016, 'Eric', 'Bernard', 'great', 1017);
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1018, 'Curtis', 'James', '1976-07-07', 'her');
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (1019, 1018, 1016, '1977-08-08', 'throw');
INSERT INTO "prescriptions" ("prescription_id", "appointment_id", "medication_name", "dosage", "duration_days") VALUES (1020, 1019, 'Dennis Williams', '10mg', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE medication_name > 30 AND dosage = '10mg';

/*
Prediction Result:
('Dennis Williams',)
*/