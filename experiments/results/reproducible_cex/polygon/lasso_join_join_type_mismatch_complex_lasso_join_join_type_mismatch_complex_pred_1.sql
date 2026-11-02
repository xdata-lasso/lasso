-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("id", "name") VALUES (24, '29');
INSERT INTO "appointments" ("id", "patient_id", "doctor_id") VALUES (20, 22, 24);
INSERT INTO "appointments" ("id", "patient_id", "doctor_id") VALUES (19, NULL, 24);
INSERT INTO "patients" ("id", "name") VALUES (21, '24');
INSERT INTO "patients" ("id", "name") VALUES (22, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('29', None)
('29', None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('29', None)
*/