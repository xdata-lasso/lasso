-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1005, 'Joy', 'Gardner', 'performance', 1006);
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1011, 'Joy', 'Gardner', 'performance', 1006);
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1007, 'Robert', 'Johnson', '1972-03-03', 'discover');
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1010, 'Robert', 'Johnson', '1972-03-03', 'discover');
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (1008, 1007, 1005, '1973-04-04', 'early');
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (1009, 1010, 1011, '1973-04-04', 'early');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('Robert', 'Joy')
('Robert', 'Joy')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = a.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Prediction Result:
('Robert', 'Joy')
('Robert', 'Joy')
('Robert', 'Joy')
('Robert', 'Joy')
*/