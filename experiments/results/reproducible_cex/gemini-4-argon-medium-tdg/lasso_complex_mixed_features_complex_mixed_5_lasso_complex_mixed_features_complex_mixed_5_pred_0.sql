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
-- DATASET 1
-- Tests basic inclusion, HAVING COUNT(treat_id) > 20 boundary (21 vs 20), date boundaries ('2023-01-01' and '2023-12-31'), and duplicate cost values for AVG(DISTINCT) vs AVG(ALL).
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'General', 'A');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (1, 'Dr. Smith', 1, 'Cardiology');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (2, 'Dr. Jones', 1, 'Cardiology');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (3, 'Dr. Brown', 1, 'Neurology');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1, 'Alice', 'F', '1980-05-15');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (1, 1, '2023-01-01', '2023-01-10', 'Checkup');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2, 1, '2023-12-31', '2024-01-05', 'Flu');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (3, 1, '2023-06-15', '2023-06-20', 'Migraine');
-- Group 1: Cardiology, Month '01', Count = 21 (Included). Multiple doctors, duplicate costs, and a NULL cost.
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (1, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (2, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (3, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (5, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (6, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (7, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (8, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (9, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (10, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (11, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (12, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (13, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (14, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (15, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (16, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (17, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (18, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (19, 1, 2, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (20, 1, 2, '2023-01-03', 500.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (21, 1, 2, '2023-01-03', NULL);
-- Group 2: Cardiology, Month '12', Count = 21 (Included). Tests '2023-12-31' boundary.
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (22, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (23, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (24, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (25, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (26, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (27, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (28, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (29, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (30, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (31, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (32, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (33, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (34, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (35, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (36, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (37, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (38, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (39, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (40, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (41, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (42, 2, 1, '2024-01-01', 600.0);
-- Group 3: Neurology, Month '06', Count = 20 (Excluded by HAVING > 20, would be included if >= 20).
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (43, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (44, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (45, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (46, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (47, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (48, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (49, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (50, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (51, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (52, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (53, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (54, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (55, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (56, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (57, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (58, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (59, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (60, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (61, 3, 3, '2023-06-16', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (62, 3, 3, '2023-06-16', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('Cardiology', '12', 219.04761904761904, 600.0)
('Cardiology', '01', 120.0, 500.0)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/