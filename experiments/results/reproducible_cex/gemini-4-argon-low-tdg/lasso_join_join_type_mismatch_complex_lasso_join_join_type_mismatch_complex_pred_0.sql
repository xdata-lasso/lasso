-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic LEFT JOIN behavior: a doctor with an appointment and a doctor without any appointments.
-- Kills mutants that replace the first LEFT JOIN with an INNER JOIN.
INSERT INTO doctors (id, name) VALUES (1, 'Dr. Smith');
INSERT INTO doctors (id, name) VALUES (2, 'Dr. Jones');
INSERT INTO patients (id, name) VALUES (1, 'Alice');
INSERT INTO appointments (id, doctor_id, patient_id) VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('Dr. Smith', 'Alice')
('Dr. Jones', None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d INNER JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('Dr. Smith', 'Alice')
*/