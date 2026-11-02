-- Schema DDL
CREATE TABLE doctors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE appointments (id INTEGER PRIMARY KEY, doctor_id INTEGER, patient_id INTEGER, FOREIGN KEY (patient_id) REFERENCES patients (id), FOREIGN KEY (doctor_id) REFERENCES doctors (id));

CREATE TABLE patients (id INTEGER PRIMARY KEY, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: doctors --
INSERT INTO "doctors" ("id", "name") VALUES (1, 'd_s_69cb19');

INSERT INTO "doctors" ("id", "name") VALUES (2, 'd_s_69cb19');

INSERT INTO "doctors" ("id", "name") VALUES (3, 'd_s_69cb19');

INSERT INTO "doctors" ("id", "name") VALUES (4, '9n8');

INSERT INTO "doctors" ("id", "name") VALUES (5, NULL);

-- Inserting into table: patients --
INSERT INTO "patients" ("id", "name") VALUES (1, 'p_s_01c9c3');

INSERT INTO "patients" ("id", "name") VALUES (-2147483647, 'p_s_01c9c3');

INSERT INTO "patients" ("id", "name") VALUES (3, '5k5swwqcgs');

INSERT INTO "patients" ("id", "name") VALUES (4, '4');

INSERT INTO "patients" ("id", "name") VALUES (2, '5k5swwqcgs');

-- Inserting into table: appointments --
INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483648, 1, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483647, 2, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483646, 2, 3);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483645, 4, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483644, 1, 4);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483643, 4, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483642, 1, 4);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (2, 1, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (3, 1, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483639, 1, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (-2147483638, 1, 1);

INSERT INTO "appointments" ("id", "doctor_id", "patient_id") VALUES (4, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', '4')
('d_s_69cb19', '4')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', '5k5swwqcgs')
('d_s_69cb19', None)
('9n8', 'p_s_01c9c3')
('9n8', 'p_s_01c9c3')
(None, '5k5swwqcgs')
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', '5k5swwqcgs')
('9n8', 'p_s_01c9c3')
('d_s_69cb19', '4')
('9n8', 'p_s_01c9c3')
('d_s_69cb19', '4')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
('d_s_69cb19', 'p_s_01c9c3')
(None, '5k5swwqcgs')
*/