-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO doctors (id, name) VALUES (10, 'Dr. Alice');
INSERT INTO doctors (id, name) VALUES (20, 'Dr. Bob');
INSERT INTO patients (id, name) VALUES (100, 'Pat Charlie');
INSERT INTO patients (id, name) VALUES (200, 'Pat Dana');
INSERT INTO patients (id, name) VALUES (300, 'Pat Eve');
INSERT INTO appointments (id, doctor_id, patient_id) VALUES (1000, 10, 100);
INSERT INTO appointments (id, doctor_id, patient_id) VALUES (2000, 10, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('Dr. Alice', 'Pat Charlie')
('Dr. Alice', 'Pat Dana')
('Dr. Bob', None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('Dr. Alice', 'Pat Charlie')
('Dr. Alice', 'Pat Dana')
*/