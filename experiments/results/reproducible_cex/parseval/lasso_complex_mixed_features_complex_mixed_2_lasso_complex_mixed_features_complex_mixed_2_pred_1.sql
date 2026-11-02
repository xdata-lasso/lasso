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
INSERT INTO "departments" ("dept_id", "name", "building") VALUES (1, 'd_s_0ce021', 'hria2ypuzhs');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (-2147483647, 'd_s_0ce021', 'w6kl');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (2, 'd_s_0ce021', 'eutliqa11r');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (3, 'ytoo3o9', 'l7');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (4, 'zw5chn', 'mo705a9n0');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (7, '4h', 'ia2yp');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (13, 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (5, 'd_s_7c6f6d', 'ji7zwau2');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (6, 'd_s_7c6f6d', 'dwyrq13pyu78');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (-2147483639, 'dep_9d4340', '9');

INSERT INTO "departments" ("dept_id", "name", "building") VALUES (8, 'fjgq8n2f3', 'dqv0gcb98ozk');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1, 'doc_cfb5e2', 1, 'rwbbp6luhvd');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (2, 'doc_cfb5e2', 1, 'a9');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (3, 'doc_cfb5e2', 1, '00t5c4e');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (4, 'doc_cfb5e2', 1, 'au2dwy');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (5, 'doc_cfb5e2', 1, 'q13py');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (6, 'xfo', 4, 'ws');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (15, 'dpos', 7, 'ie5');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (9, 'w6kl', 2, 'a9');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (8, 'doc_c1294b', 5, 'rljsl0b4y');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (-2147483639, 'doc_2a49d8', -2147483639, '5qi2');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (7, 'doc_c1294b', 4, 'f9v');

INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (10, 'zbilyrkn', 8, '6vck6ah0f8js');

-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (-2147483648, '5k5swwqcgs', '9n8', '2020-06-08');

-- Inserting into table: admissions --
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1, -2147483648, '2023-01-01', '2024-06-15', 'pgu7vfe4');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (-2147483647, -2147483648, '2023-01-01', '2024-06-15', '5u');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (3, -2147483648, '2023-01-01', '2024-06-15', 'sl0');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (2, -2147483648, '2025-04-09', '2024-04-25', 'p5qi2rkf9v');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (4, -2147483648, '2020-08-14', NULL, '2zob');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (11, -2147483648, '2023-01-01', '2024-06-15', '00t5c4e');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (17, -2147483648, '2023-01-01', '2024-06-15', 'cigce376nium');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (5, -2147483648, '2023-01-01', '2024-06-15', 'x58pz0f8je');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (6, -2147483648, '2023-01-01', '2024-06-15', 'd21vy9uxj4hw');

INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (7, -2147483648, '2023-01-01', NULL, 'lq7xb7');

-- Inserting into table: treatments --
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1, 1, 1, '2022-04-29', 240.969194);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483647, 1, 2, '2025-06-20', 452.706544);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (2, 1, 1, '2020-12-28', 707.476301);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (3, -2147483647, 5, '2020-11-04', 755.698226);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483644, 1, 1, '2024-11-06', 222.511261);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483643, 1, 1, '2023-06-03', 695.452114);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483642, 1, 1, '2023-05-24', 107.390057);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483641, 1, 1, '2023-08-15', 813.864654);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483640, 1, 1, '2024-08-20', 668.776683);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483639, 1, 1, '2024-03-10', 50.798088);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483638, 1, 1, '2025-02-22', 172.799686);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (-2147483637, 1, 1, '2025-11-05', 745.691525);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (4, 4, 6, '2020-05-01', 407.368744);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (8, 17, 9, '2024-06-13', 21.917736);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (14, -2147483647, 6, '2025-05-15', 760.580899);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (5, 11, 1, '2022-01-29', 11797.0);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (6, -2147483647, 4, '2024-12-03', 3431.0);

INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (7, 7, 10, '2024-12-09', 814.417862);

-- Inserting into table: medications --
INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (1, 'tti', 182.319045);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (-2147483647, 'cigce376nium', 779.28645);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (2, 'y9uxj4', 124.573829);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (3, 'd', 328.40866);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (4, 'us3auvmkrpdj', 736.632717);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (10, '5k5swwqcgs', 171.746906);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (16, 'n8c4pgu7v', 86.520366);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (5, 'o9hl72kl', 0.0);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (6, 'x1', 8365.0);

INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (7, 'jtu0d', 395.809081);

-- Inserting into table: prescriptions --
INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483648, 1, 1, 'mdpos');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483647, 1, 1, 'zbuo4nrqrof');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483646, 1, 1, 'qyp5s5bbp0');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483645, 1, 1, 'klex14ji');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483644, 1, 1, '78d99r');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483643, 1, 1, 'x58pz');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483642, 3, 1, 'd2');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483641, 1, 3, 'h2gn');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483640, 1, 1, 'wnqcx');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483639, 1, 1, 'hncprjtu0dz');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483638, 1, 1, 'gq8');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483637, 3, 1, 'f3dqv0gc');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483636, 1, 3, '8ozk3zbil');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483635, 1, 1, 'kn6vc');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483634, 1, 1, 'ah0f8jsww');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483633, 1, 1, '7xb72');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483632, 3, 1, 'a7ryfd');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483631, 1, 3, 'z16nijjai5d');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483630, 1, 1, 'ogrgjd8y');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483629, 1, 1, '1afgo');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483628, 1, 1, 'itsj3');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483627, 3, 1, 'xp1q430');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483626, 1, 3, 'jh3den8c68');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483625, 1, 1, 'vacx7afu5');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483624, 1, 1, 'f77pzo72ctd');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483623, 1, 1, 'fg62');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (2, 1, 1, 'v5q8qdj');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (3, 1, 1, 'e1io');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483620, 1, 1, '8507cvtjp');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483619, 1, 1, 'n');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483618, 1, 1, 'zi36c4bf');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483617, 1, 1, 'c');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483616, 1, 1, 'z2zezjo7w');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483615, 1, 1, 'ysxcmr0o');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483614, 1, 1, 'j5');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483613, 1, 1, '5lnpim5k58qs');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483612, 1, 1, 'r94gth2m');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483611, 1, 1, 'la3');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483610, 1, 1, 'v8u');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483609, 1, 1, 'ne578lfv');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483608, 1, 1, '7zzbe8y');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483607, 1, 1, 'v42');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483606, 1, 1, '7sx58b4pma');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (4, 4, 4, '0k32odwcl5a');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483604, 1, 1, 'rqrofqyp5s');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (12, -2147483637, 3, 'bbp02eutliqa');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (18, -2147483642, 3, 'yytoo');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (-2147483601, 1, 1, 'nd');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (5, -2147483637, 4, 'qcx5');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (6, -2147483642, -2147483647, 'p');

INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (7, 7, 7, 'a7ryfd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('d_s_0ce021', 'doc_cfb5e2', 1, 25570.14499400001)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE STRFTIME('%Y', a.admit_date) > '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
*/