-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, name TEXT, building TEXT);

CREATE TABLE Doctors (doc_id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, specialty TEXT, FOREIGN KEY (dept_id) REFERENCES Departments (dept_id));

CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT, gender TEXT, dob DATE);

CREATE TABLE Admissions (admit_id INTEGER PRIMARY KEY, patient_id INTEGER, admit_date DATE, discharge_date DATE, diagnosis TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

CREATE TABLE Treatments (treat_id INTEGER PRIMARY KEY, admit_id INTEGER, doc_id INTEGER, treatment_date DATE, cost REAL, FOREIGN KEY (doc_id) REFERENCES Doctors (doc_id), FOREIGN KEY (admit_id) REFERENCES Admissions (admit_id));

CREATE TABLE Medications (med_id INTEGER PRIMARY KEY, name TEXT, base_price REAL);

CREATE TABLE Prescriptions (presc_id INTEGER PRIMARY KEY, treat_id INTEGER, med_id INTEGER, dosage TEXT, FOREIGN KEY (med_id) REFERENCES Medications (med_id), FOREIGN KEY (treat_id) REFERENCES Treatments (treat_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "name", "building") VALUES (1, 'd_s_bff6dd', 'hria2ypuzhs');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (-2147483647, 'd_s_bff6dd', 'w6kl');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (3, 'd_s_bff6dd', 'fqyp');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (2, 's5bbp02e', 'tliqa1');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (4, 'u', 'mkrpdj');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (11, 'e4', 'hria2ypuzhs');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (17, 'rwbbp6luhvd', 'tti');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (6, 'd_s_9b3482', 'ytoo3o9');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (5, 'd_s_9b3482', 'l7');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (-2147483639, 'dep_9d4340', 'klex14ji');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (7, 'fjgq8n2f3dq', '0gcb98');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (8, '2fxa7ryfd', 'z16ni');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1, 'doc_6ef18e', 1, 'rwbbp6luhvd');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483647, 'doc_6ef18e', 1, 'a9');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (2, 'doc_6ef18e', 1, 'hl72klex1');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (3, 'doc_6ef18e', 1, 'ji7zwau2');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (4, 'doc_6ef18e', 1, 'dwyrq13pyu78');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (5, '9rljsl0b4', 1, 'p5qi2rk');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483642, 'doc_6ef18e', 1, '68x8vacx7a');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483641, 'doc_6ef18e', 1, 'io22785');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483640, 'doc_6ef18e', 1, 'f');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483639, 'doc_6ef18e', 1, 'sxcmr0o');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (6, 'wzw5chn9mo70', 4, 'a9n0jxfo');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (15, 'bnp', 11, 'mdpos');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (9, 'e5u', -2147483647, 'w6kl');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483635, 'doc_2a49d8', -2147483639, 'zwau2dwyr');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (8, 'doc_a53740', 5, '13pyu');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (7, 'doc_a53740', 5, 'd99rljsl0');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (10, 'zk3z', 7, 'i');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (11, 'jai', 8, 'dh5ogrgj');

-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (-2147483648, '5k5swwqcgs', '9n8', '2020-06-08');

-- Inserting into table: admissions --
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1, -2147483648, '2023-01-01', '2024-06-15', 'pgu7vfe4');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (-2147483647, -2147483648, '2023-01-01', '2024-06-15', '5u');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (3, -2147483648, '2023-01-01', '2024-06-15', 'x58pz0f8je');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (2, -2147483648, '2020-07-19', '2025-01-26', 'vy9uxj4');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (4, -2147483648, '2023-12-13', NULL, 'zdo2z');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (18, -2147483648, '2023-01-01', '2024-06-15', '5k5swwqcgs');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (12, -2147483648, '2023-01-01', '2024-06-15', '9n8c4pgu7v');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (6, -2147483648, '2023-01-01', '2024-06-15', 'yp5qi2rk');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (5, -2147483648, '2023-01-01', '2024-06-15', 'x58pz');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (7, -2147483648, '2000-03-01', NULL, 'tu0');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (8, -2147483648, NULL, NULL, 'ah0f8jsww');

-- Inserting into table: treatments --
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1, 1, 1, '2022-04-29', 240.969194);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483647, 1, 1, '2020-06-23', 128.76421);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (3, 1, 1, '2023-09-07', 185.427628);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (2, 1, -2147483647, '2024-12-03', 109.083092);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (4, 4, 6, '2022-06-24', 17.68408);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (10, 18, -2147483647, '2020-01-23', 587.783596);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (16, 2, -2147483640, '2024-09-12', 801.414196);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (5, -2147483647, -2147483635, '2021-08-12', 0.0);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (6, -2147483647, 2, '2020-07-19', 8365.0);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (7, 7, 10, '2021-12-23', 728.712934);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (8, 8, 11, '2020-08-13', 917.457483);

-- Inserting into table: medications --
INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (1, 'tti', 182.319045);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (-2147483647, '00t5c4e', 950.466571);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (3, 'x', 668.309685);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (2, 'hncprjtu0dz', 521.610309);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (4, 'q0k32od', 357.061424);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (8, '0t5c4ecigce', 467.07027);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (14, 'nium52zbu', 225.300904);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (5, '1vy9uxj4', 11797.0);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (6, 'wb', 3431.0);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (7, 'z', 521.610309);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (9, 'q7x', 21.129657);

-- Inserting into table: prescriptions --
INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483648, 1, 1, 'mdpos');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483647, 1, 1, 'gce376nium');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483646, 1, 1, '52zbuo4nrq');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483645, 1, 1, 'ryytoo3');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483644, 1, 1, '9v');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483643, 1, 1, 'wb');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483642, 2, 1, 'dqwn');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483641, 1, 2, 'fjgq8n2f3dq');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483640, 1, 1, 'gcb98oz');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483639, 1, 1, 'zbilyrkn');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483638, 1, 1, 'k');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483637, 2, 1, 'h0f8jswwlq');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483636, 1, 2, '7');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483635, 1, 1, 'xa');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483634, 1, 1, 'fdrz16n');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483633, 1, 1, 'jai');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483632, 2, 1, 'h');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483631, 1, 2, 'grgj');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483630, 1, 1, 'yzt1afgog');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483629, 1, 1, 'tsj');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483628, 1, 1, 'y');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483627, 2, 1, '1q43');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483626, 1, 2, 'jh3den8');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483625, 1, 1, 'u5');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483624, 3, 1, '1of77pzo72c');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483623, 3, 1, 'c');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (2, 1, 1, 'mfg62g0v5q8q');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (3, 1, 1, 'j');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483620, 1, 1, '7cvtjpt');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483619, 3, 1, '6b');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483618, 3, 1, 'u5zi');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483617, 1, 1, 'foa');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483616, 3, 1, '0');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483615, 3, 1, 'zezjo7wg');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483614, 1, 1, 'ztdgj5i3lq5l');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483613, 3, 1, 'im5k');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483612, 3, 1, 'qs27p2r94');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483611, 1, 1, '2mnajjla3o');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483610, 1, 1, '8uttmu');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483609, 1, 1, 'vy');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483608, 1, 1, 'zzbe8yvkv');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483607, 1, 1, 'q7sx58b4');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483606, 1, 1, 'aus3');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (4, 4, 4, '5am');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483604, 1, 1, 'rqro');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (7, 1, 8, 'qyp5s5bbp0');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (13, 2, 8, 'eutliqa11r');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483601, 1, 1, 'v');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (5, 2, 3, 'h2gndqwnqcx5');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (6, 2, -2147483647, 'p');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (8, 7, 7, 'kn6vc');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (9, 8, 9, 'yzt1afgog');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('d_s_bff6dd', 'doc_6ef18e', 1, 22554.394141000004)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(a.patient_id) AS total_patients, SUM(t.cost) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
('d_s_bff6dd', 'doc_6ef18e', 6, 9617.02772)
('dep_9d4340', 'doc_2a49d8', 1, 0.0)
*/