-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "doctors" ("id", "name") VALUES (1001, 'Allison Hill');
INSERT INTO "doctors" ("id", "name") VALUES (1005, 'Allison Hill');
INSERT INTO "patients" ("id", "name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "patients" ("id", "name") VALUES (1008, 'Noah Rhodes');
INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (1003, 1001, 1002);
INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (1006, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('Allison Hill', 'Noah Rhodes')
('Allison Hill', None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('Allison Hill', 'Noah Rhodes')
*/