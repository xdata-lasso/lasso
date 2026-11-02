-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("id", "name") VALUES (19, NULL);
INSERT INTO "doctors" ("id", "name") VALUES (27, NULL);
INSERT INTO "appointments" ("id", "patient_id", "doctor_id") VALUES (25, 26, 19);
INSERT INTO "appointments" ("id", "patient_id", "doctor_id") VALUES (18, 26, 19);
INSERT INTO "patients" ("id", "name") VALUES (26, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
(None, None)
(None, None)
(None, None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d CROSS JOIN appointments AS a ON d.id = a.doctor_id CROSS JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
(None, None)
(None, None)
*/