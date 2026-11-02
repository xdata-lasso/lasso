-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO doctors (doctor_id, first_name, last_name, specialty, years_experience) VALUES (1, NULL, 'default2', NULL, NULL), (0, 'default2', 'default1', 'default2', NULL), (2, 'default1', 'default1', 'default2', 1), (3, NULL, NULL, NULL, 1), (4, 'default2', 'default1', NULL, 0), (5, 'default2', 'default1', 'default1', NULL);
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender) VALUES (1, NULL, NULL, '2023-01-02', 'default2'), (0, NULL, 'default1', NULL, NULL), (2, 'default2', NULL, NULL, NULL), (3, NULL, 'default1', '2023-01-01', 'default2'), (4, 'default1', 'default2', '2023-01-01', 'default2');
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES (1, 2, 0, '2023-01-01 00:00:00.000000', 'default2'), (0, NULL, 3, '2023-01-01 00:00:00.000000', 'default2'), (2, 4, 3, NULL, NULL), (3, NULL, 2, '2023-01-01 00:00:00.000000', 'default1'), (4, 4, 4, '2023-01-01 00:00:00.000000', NULL), (5, 0, 4, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('default2', 'default2')
('default1', None)
('default1', 'default2')
(None, 'default2')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = a.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Prediction Result:
(None, 'default2')
(None, 'default2')
('default2', 'default2')
(None, 'default2')
('default1', 'default2')
(None, None)
(None, None)
('default2', None)
(None, None)
('default1', None)
(None, 'default2')
(None, 'default2')
('default2', 'default2')
(None, 'default2')
('default1', 'default2')
(None, 'default2')
(None, 'default2')
('default2', 'default2')
(None, 'default2')
('default1', 'default2')
*/