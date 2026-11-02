-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, name TEXT, building TEXT);

CREATE TABLE Doctors (doc_id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, specialty TEXT);

CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT, gender TEXT, dob DATE);

CREATE TABLE Admissions (admit_id INTEGER PRIMARY KEY, patient_id INTEGER, admit_date DATE, discharge_date DATE, diagnosis TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

CREATE TABLE Treatments (treat_id INTEGER PRIMARY KEY, admit_id INTEGER, doc_id INTEGER, treatment_date DATE, cost REAL, FOREIGN KEY (admit_id) REFERENCES Admissions (admit_id), FOREIGN KEY (doc_id) REFERENCES Doctors (doc_id));

CREATE TABLE Medications (med_id INTEGER PRIMARY KEY, name TEXT, base_price REAL);

CREATE TABLE Prescriptions (presc_id INTEGER PRIMARY KEY, treat_id INTEGER, med_id INTEGER, dosage TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: doctors --
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1, 'hria2ypu', 1644814318, 'doc_ac6213');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483647, '6klfa9', 1620389964, 'doc_ac6213');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (21, 'zbuo4nrqrof', 373262291, 'doc_ac6213');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (3, 'p5s5bbp', 882961052, 'doc_ac6213');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (2, '2eutliqa11r', 2137741668, 'ytoo3o9hl7');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (4, 'pouit63xyf', 1394459557, 'jwpp');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (5, '6mb3aj0j', 982289268, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (6, '3r', -167036460, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (7, 'r1a', -569461411, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (8, 'hpl2i9e', -873300912, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (9, '8pgc', 1394285393, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (10, 'wtsr5', -69263912, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (11, 'qjektb1d2', -460035045, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (12, '3rjkwns47j2j', -1881008758, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (13, 'y', -1015337060, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (14, 'yrnxs6dvd', -563917514, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (15, '2v7t', 1770139230, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (16, 'gvplj9fjvu', 1200703349, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (17, 'k10z2my1o', 699455208, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (18, 'v1rgeza', 423028705, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (19, '1', -1970162044, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (20, 'upgly78oit', -563920971, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (22, 'lpe', 1163377746, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (23, 'cy7od033d', -1665891229, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (24, 'vnhed', 1188203659, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (25, '9lqv26u331s', -1125491025, 'doc_ab1f88');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (26, 'pw30bgwkxgi', 404445908, 'doc_ab1f88');

-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (1, '5k5swwqcgs', 'F', '2021-12-04');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (-2147483647, 'mdpos', 'F', '2021-06-28');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (5, '3d', 'F', '2020-11-02');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (2, '8c68', '8vacx7', '2020-02-05');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (3, 'u5', '1of77p', '2024-06-20');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (4, '72ct', 'c', '2023-06-03');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (8, 'dza35rmki', 'F', '2022-07-30');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (27, '8ri2hy0', 'F', '2020-12-26');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (12, 'tp6ewtqxxn', 'F', '2021-09-22');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (7, 'b', 'F', '2024-03-23');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (15, 'mzn2mfx7h3', 'F', '2025-02-01');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (6, '6sto', 'F', '2024-11-11');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (25, 'j', 'F', '2023-04-07');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (23, '5k', 'F', '2022-04-30');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (13, 'zys7dyyd1jmg', 'F', '2021-09-07');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (26, 'c', 'F', '2021-03-31');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (18, 'qta8y3a17', 'F', '2023-09-08');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (16, 'ygmayq3q', 'F', '2020-07-15');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (22, 'uap9', 'F', '2025-10-05');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (24, 'ntdqr', 'F', '2021-03-30');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (20, '5wli', 'F', '2020-07-06');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (19, 'dn2np490x', 'F', '2020-08-16');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (10, 'sqtg', 'F', '2020-09-18');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (9, 'cuq', 'F', '2020-04-21');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (11, 'i9f2ccukj', 'F', '2022-11-04');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (14, '1quik1yhb08h', 'F', '2022-01-15');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (17, 't1pqo', 'F', '2022-02-15');

INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (21, 'ztv', 'F', '2020-03-12');

-- Inserting into table: admissions --
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1, 1, '2023-01-01', '2022-04-27', '8c4pgu7vfe');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (-2147483647, 1, '2023-01-01', '2021-06-03', '5u');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (2, 1, '2023-01-01', '2022-12-09', '3pyu78d');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (3, -2147483647, '2022-01-18', '2021-08-18', 'l0b4y');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (4, 1, '2025-07-21', '2022-12-05', '2rk');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (5, 1, '2023-10-06', '2022-12-15', 'x58pz0f8je');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (6, 1, '2020-07-19', '2025-01-26', 'vy9uxj4');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (7, 1, '2023-12-18', '2020-04-02', 'v');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (8, 1, '2022-09-24', '2021-04-26', 'gndqwnqc');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (9, -2147483647, '2025-07-02', '2021-04-09', 'cprj');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (10, -2147483647, '2023-07-15', '2024-08-30', 'z');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (11, 1, '2021-09-23', '2021-01-21', '8n2f3');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (12, 1, '2022-11-06', '2023-10-23', 'gcb98oz');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (13, 1, '2025-03-14', '2024-06-09', 'i');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (14, 1, '2024-04-08', '2023-02-18', 'kn6vck6ah0f8');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (15, 1, '2023-03-04', '2023-11-21', 'lq7xb7');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (16, -2147483647, '2020-11-23', '2024-03-11', '7');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (17, -2147483647, '2024-04-05', '2020-12-21', 'r');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (18, -2147483647, '2024-11-10', '2025-10-07', 'ijja');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (19, 1, '2025-08-02', '2020-09-12', 'h5ogrgjd8yz');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (20, -2147483647, '2024-10-27', '2020-02-11', 'fgogritsj3ay');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (21, -2147483647, '2022-09-06', '2024-09-24', '4301j');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (22, 6, '2023-01-01', '2025-09-21', '4iz7');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (23, 7, '2023-01-01', '2020-01-18', 'qlud8');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (24, 8, '2023-01-01', '2020-12-02', 'tb8r9114qbre');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (25, 9, '2023-01-01', '2025-09-13', 'j');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (26, 10, '2023-01-01', '2020-10-20', 'uuwsj8kjh8');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (27, 11, '2023-01-01', '2025-06-18', 'pxlvri');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (28, 12, '2023-01-01', '2023-04-01', 'urz0kaqtncg');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (29, 13, '2023-01-01', '2020-05-16', 's3b7v88kw');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (30, 14, '2023-01-01', '2020-07-18', 'dbdh');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (31, 15, '2023-01-01', '2023-05-27', 'j47nxar50');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (32, 16, '2023-01-01', '2021-04-18', 'sjhanzxdpu');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (33, 17, '2023-01-01', '2022-05-11', 'wfwx');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (34, 18, '2023-01-01', '2022-11-22', 'lawk0');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (35, 19, '2023-01-01', '2024-10-27', 'r5dqtsmg');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (36, 20, '2023-01-01', '2025-12-07', 'aqz2o20pj6d');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (37, 21, '2023-01-01', '2020-09-11', 'ysu');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (38, 22, '2023-01-01', '2025-10-03', 'phd');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (39, 23, '2023-01-01', '2021-11-21', 'u2gir31vwq5');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (40, 24, '2023-01-01', '2024-10-28', 'a2sb');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (41, 25, '2023-01-01', '2025-02-19', 'oi1pav');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (42, 26, '2023-01-01', '2020-06-16', 'wnyqro');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (43, 27, '2023-01-01', '2023-07-14', 'rlr');

-- Inserting into table: treatments --
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1, 1, 1, '2021-03-30', 294.861575);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483647, 1, 1, '2024-09-12', 801.414196);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483646, 1, 1, '2024-06-05', 391.037879);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483645, 1, 1, '2020-03-24', 476.006677);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483644, 1, 1, '2022-05-10', 419.43898);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483643, 1, 1, '2024-08-25', 162.575651);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483642, 1, 1, '2021-03-24', 638.700568);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483641, 1, 1, '2025-09-04', 834.163912);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483640, 1, 1, '2022-04-28', 627.816635);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483639, 1, 1, '2022-08-11', 735.218284);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483638, 1, 1, '2023-07-14', 203.071475);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483637, 1, 1, '2023-09-09', 843.866361);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (2, 22, 4, '2022-01-27', 767.869106);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (3, 23, 5, '2021-08-14', 563.529532);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (4, 24, 6, '2021-07-24', 733.986177);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (5, 25, 7, '2022-03-01', 235.871701);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (6, 26, 8, '2025-08-24', 594.557446);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (7, 27, 9, '2024-10-21', 186.560838);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (8, 28, 10, '2025-01-15', 748.913804);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (9, 29, 11, '2025-02-21', 9.487854);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (10, 30, 12, '2024-10-01', 659.619834);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (11, 31, 13, '2025-01-03', 224.501855);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (12, 32, 14, '2020-07-03', 14.163977);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (13, 33, 15, '2021-02-09', 144.19338);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (14, 34, 16, '2020-09-28', 63.114566);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (15, 35, 17, '2023-10-16', 364.303078);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (16, 36, 18, '2024-02-10', 178.444842);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (17, 37, 19, '2025-04-23', 990.907636);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (18, 38, 20, '2021-10-18', 318.136826);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (19, 39, 22, '2022-06-27', 66.494394);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (20, 40, 23, '2020-05-13', 47.421322);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (21, 41, 24, '2025-05-14', 319.391855);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (22, 42, 25, '2021-11-27', 117.474993);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (23, 43, 26, '2021-12-28', 645.56382);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483614, 1, 1, '2020-03-19', 348.456963);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('doc_ab1f88', '01', 344.12570142857146, 990.907636)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/