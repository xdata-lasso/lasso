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
-- Tests:
-- 1. HAVING COUNT(t.treat_id) > 20 vs >= 20 (Group 1 has 21 rows, Group 2 has 20 rows).
-- 2. Date boundaries: '2023-01-01' and '2023-12-31' (inclusive) vs '2022-12-31' and '2024-01-01' (excluded).
-- 3. Gender filter: 'F' vs 'M' and NULL.
-- 4. Aggregation: AVG vs SUM, MAX vs MIN, COUNT(treat_id) vs COUNT(DISTINCT doc_id/admit_id/cost), NULL handling in cost.
-- 5. Grouping by admit_month vs treatment_date month or full admit_date.
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'Dept A', 'B1');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES
(1, 'Doc 1', 1, 'Cardiology'),
(2, 'Doc 2', 1, 'Cardiology'),
(3, 'Doc 3', 1, 'Neurology');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES
(1, 'Pat F1', 'F', '1980-01-01'),
(2, 'Pat F2', 'F', '1985-05-05'),
(3, 'Pat M1', 'M', '1990-10-10'),
(4, 'Pat Null', NULL, '1995-12-12');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES
(1, 1, '2023-01-01', '2023-01-05', 'Diag 1'),
(2, 2, '2023-01-15', '2023-01-20', 'Diag 2'),
(3, 3, '2023-01-10', '2023-01-12', 'Diag 3'),
(4, 1, '2022-12-31', '2023-01-02', 'Diag 4'),
(5, 1, '2024-01-01', '2024-01-05', 'Diag 5'),
(6, 4, '2023-01-10', '2023-01-15', 'Diag 6'),
(7, 1, '2023-12-31', '2024-01-05', 'Diag 7');
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES
-- Group 1: ('Cardiology', '01') - 21 valid rows (10 from Admit 1, 11 from Admit 2)
(1, 1, 1, '2023-01-02', 100.0),
(2, 1, 1, '2023-01-02', 200.0),
(3, 1, 1, '2023-01-02', 300.0),
(4, 1, 1, '2023-01-03', 100.0),
(5, 1, 1, '2023-01-03', 100.0),
(6, 1, 1, '2023-01-03', 100.0),
(7, 1, 1, '2023-01-04', 100.0),
(8, 1, 1, '2023-01-04', 100.0),
(9, 1, 1, '2023-01-04', 100.0),
(10, 1, 1, '2023-01-04', NULL),
(11, 2, 2, '2023-02-01', 100.0),
(12, 2, 2, '2023-02-01', 100.0),
(13, 2, 2, '2023-02-01', 100.0),
(14, 2, 2, '2023-02-01', 100.0),
(15, 2, 2, '2023-02-01', 100.0),
(16, 2, 2, '2023-02-01', 100.0),
(17, 2, 2, '2023-02-01', 100.0),
(18, 2, 2, '2023-02-01', 100.0),
(19, 2, 2, '2023-02-01', 100.0),
(20, 2, 2, '2023-02-01', 100.0),
(21, 2, 2, '2023-02-01', 500.0),
-- Group 2: ('Neurology', '12') - 20 valid rows on '2023-12-31' (Boundary test for HAVING > 20 vs >= 20)
(22, 7, 3, '2023-12-31', 50.0),
(23, 7, 3, '2023-12-31', 50.0),
(24, 7, 3, '2023-12-31', 50.0),
(25, 7, 3, '2023-12-31', 50.0),
(26, 7, 3, '2023-12-31', 50.0),
(27, 7, 3, '2023-12-31', 50.0),
(28, 7, 3, '2023-12-31', 50.0),
(29, 7, 3, '2023-12-31', 50.0),
(30, 7, 3, '2023-12-31', 50.0),
(31, 7, 3, '2023-12-31', 50.0),
(32, 7, 3, '2023-12-31', 50.0),
(33, 7, 3, '2023-12-31', 50.0),
(34, 7, 3, '2023-12-31', 50.0),
(35, 7, 3, '2023-12-31', 50.0),
(36, 7, 3, '2023-12-31', 50.0),
(37, 7, 3, '2023-12-31', 50.0),
(38, 7, 3, '2023-12-31', 50.0),
(39, 7, 3, '2023-12-31', 50.0),
(40, 7, 3, '2023-12-31', 50.0),
(41, 7, 3, '2023-12-31', 150.0),
-- Invalid rows for Group 2: If date or gender filters are mutated/omitted, Group 2 will exceed 20 rows and appear in output!
(42, 4, 3, '2022-12-31', 999.0),
(43, 5, 3, '2024-01-01', 999.0),
(44, 3, 3, '2023-12-31', 999.0),
(45, 6, 3, '2023-12-31', 999.0),
-- Invalid rows for Group 1: If included, changes AVG and MAX of Group 1
(46, 3, 1, '2023-01-10', 9999.0),
(47, 4, 1, '2023-01-01', 9999.0),
(48, 5, 1, '2023-01-01', 9999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('Cardiology', '01', 135.0, 500.0)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/