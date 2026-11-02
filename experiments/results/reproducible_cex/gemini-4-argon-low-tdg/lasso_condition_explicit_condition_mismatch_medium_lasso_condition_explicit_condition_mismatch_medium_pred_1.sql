-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, 'John', 'Doe', '1980-01-01', 'M');
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, 'Jane', 'Smith', 'Cardiology', 10);
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 1, 1, '2023-01-01 10:00:00', 'Completed');
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (1, 1, 'Med_Exact_Match', '10mg', 31);
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (2, 1, 'Med_Boundary_30', '10mg', 30);
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (3, 1, 'Med_Below_29', '10mg', 29);
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_name, dosage, duration_days) VALUES (4, 1, 'Med_High_Duration', '10mg', 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT medication_name FROM Prescriptions WHERE duration_days > 30 AND dosage = '10mg';

/*
Gold Result:
('Med_Exact_Match',)
('Med_High_Duration',)
*/

-- Prediction Query
SELECT medication_name FROM Prescriptions WHERE medication_name > 30 AND dosage = '10mg';

/*
Prediction Result:
('Med_Exact_Match',)
('Med_Boundary_30',)
('Med_Below_29',)
('Med_High_Duration',)
*/