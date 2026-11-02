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
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'Heart Center', 'Building A');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (101, 'Dr. Smith', 1, 'Cardiology');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (102, 'Dr. Jones', NULL, 'Cardiology');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (103, 'Dr. Adams', 1, 'Neurology');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (104, 'Dr. Baker', 1, 'Orthopedics');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (201, 'Alice', 'F', '1985-04-12');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (202, 'Beth', 'F', '1990-08-22');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (301, 201, '2023-01-01', '2023-01-10', 'Arrhythmia');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (302, 202, '2023-01-15', '2023-01-25', 'Hypertension');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (303, 201, '2023-12-31', '2024-01-05', 'Migraine');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (304, 202, '2023-06-10', '2023-06-20', 'Fracture');
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (1, 301, 101, '2023-01-01', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (2, 301, 101, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (3, 301, 101, '2023-01-03', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4, 301, 101, '2023-01-04', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (5, 301, 101, '2023-01-05', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (6, 301, 101, '2023-01-06', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (7, 301, 101, '2023-01-07', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (8, 301, 101, '2023-01-08', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (9, 301, 101, '2023-01-09', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (10, 301, 101, '2023-01-10', 300.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (11, 301, 101, '2023-01-10', NULL);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (12, 302, 102, '2023-01-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (13, 302, 102, '2023-01-16', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (14, 302, 102, '2023-01-17', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (15, 302, 102, '2023-01-18', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (16, 302, 102, '2023-01-19', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (17, 302, 102, '2023-01-20', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (18, 302, 102, '2023-01-21', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (19, 302, 102, '2023-01-22', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (20, 302, 102, '2023-01-23', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (21, 302, 102, '2023-01-24', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (22, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (23, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (24, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (25, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (26, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (27, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (28, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (29, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (30, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (31, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (32, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (33, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (34, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (35, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (36, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (37, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (38, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (39, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (40, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (41, 303, 103, '2023-12-31', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (42, 303, 103, '2023-12-31', 260.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (43, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (44, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (45, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (46, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (47, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (48, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (49, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (50, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (51, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (52, 304, 104, '2023-06-11', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (53, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (54, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (55, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (56, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (57, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (58, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (59, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (60, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (61, 304, 104, '2023-06-12', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (62, 304, 104, '2023-06-12', 80.0);
INSERT INTO Medications (med_id, name, base_price) VALUES (401, 'Aspirin', 10.0);
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (501, 43, 401, '100mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (502, 43, 401, '200mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('Cardiology', '01', 110.0, 300.0)
('Neurology', '12', 60.0, 260.0)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/