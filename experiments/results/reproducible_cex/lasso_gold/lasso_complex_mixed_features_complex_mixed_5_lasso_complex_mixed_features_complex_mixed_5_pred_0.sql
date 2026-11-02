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
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1001, 'Allison Hill', 1022, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1002, 'Noah Rhodes', 1029.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1003, 'Angie Henderson', 1036.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1004, 'Daniel Wagner', 1043.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1005, 'Cristian Santos', 1050.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1006, 'Connie Lawrence', 1057.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1007, 'Abigail Shaffer', 1064.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1008, 'Gina Moore', 1071.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1009, 'Gabrielle Davis', 1078.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1010, 'Ryan Munoz', 1085.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1011, 'Monica Herrera', 1092.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1012, 'Jamie Arnold', 1099.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1013, 'Lisa Hensley', 1106.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1014, 'Michele Williams', 1113.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1015, 'Dylan Miller', 1120.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1016, 'Brian Ramirez', 1127.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1017, 'Holly Wood', 1134.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1018, 'Derek Zuniga', 1141.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1019, 'Lisa Jackson', 1148.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1020, 'Carla Gray', 1155.0, 'threat');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1021, 'Margaret Hawkins DDS', 1162.0, 'threat');
INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (1043, 'Amy Underwood', 'F', '1970-01-01');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1044, 1043, '2023-07-02', '1971-02-02', 'support');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1045, 1043, '2023-07-03', '1971-02-03', 'four');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1046, 1043, '2023-07-04', '1971-02-04', 'institution');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1047, 1043, '2023-07-05', '1971-02-05', 'executive');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1048, 1043, '2023-07-06', '1971-02-06', 'attorney');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1049, 1043, '2023-07-07', '1971-02-07', 'development');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1050, 1043, '2023-07-08', '1971-02-08', 'white');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1051, 1043, '2023-07-09', '1971-02-09', 'yes');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1052, 1043, '2023-07-10', '1971-02-10', 'our');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1053, 1043, '2023-07-11', '1971-02-11', 'under');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1054, 1043, '2023-07-12', '1971-02-12', 'serious');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1055, 1043, '2023-07-13', '1971-02-13', 'forward');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1056, 1043, '2023-07-14', '1971-02-14', 'difference');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1057, 1043, '2023-07-15', '1971-02-15', 'reality');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1058, 1043, '2023-07-16', '1971-02-16', 'money');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1059, 1043, '2023-07-17', '1971-02-17', 'individual');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1060, 1043, '2023-07-18', '1971-02-18', 'usually');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1061, 1043, '2023-07-19', '1971-02-19', 'who');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1062, 1043, '2023-07-20', '1971-02-20', 'question');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1063, 1043, '2023-07-21', '1971-02-21', 'low');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1064, 1043, '2023-07-22', '1971-02-22', 'character');
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1085, 1044, 1001, '1992-01-23', 1106.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1086, 1044, 1001, '1992-01-24', 1117.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1087, 1044, 1001, '1992-01-25', 1128.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1088, 1044, 1001, '1992-01-26', 1139.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1089, 1044, 1001, '1992-01-27', 1150.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1090, 1044, 1001, '1992-01-28', 1161.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1091, 1044, 1001, '1992-01-29', 1172.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1092, 1044, 1001, '1992-01-30', 1183.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1093, 1044, 1001, '1992-01-31', 1194.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1094, 1044, 1001, '1992-02-01', 1205.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1095, 1044, 1001, '1992-02-02', 1216.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1096, 1044, 1001, '1992-02-03', 1227.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1097, 1044, 1001, '1992-02-04', 1238.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1098, 1044, 1001, '1992-02-05', 1249.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1099, 1044, 1001, '1992-02-06', 1260.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1100, 1044, 1001, '1992-02-07', 1271.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1101, 1044, 1001, '1992-02-08', 1282.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1102, 1044, 1001, '1992-02-09', 1293.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1103, 1044, 1001, '1992-02-10', 1304.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1104, 1044, 1001, '1992-02-11', 1315.5);
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1105, 1044, 1001, '1992-02-12', 1326.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('threat', '07', 1216.5, 1326.5)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/