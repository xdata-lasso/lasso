-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1001, 'Danielle', 'Johnson', 'face', 1002);
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1003, 'John', 'Taylor', '1970-01-01', 'blue');
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (1004, 1003, 1001, '1971-02-02', 'require');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('John', 'Danielle')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.doctor_id = p.patient_id JOIN Doctors AS d ON a.patient_id = d.doctor_id;

/*
Prediction Result:
*/