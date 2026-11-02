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
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT JOIN on Prescriptions: Treatment with 1 prescription vs multiple prescriptions vs 0 prescriptions.
-- 2. SUM(t.cost + m.base_price) vs SUM(t.cost) + SUM(m.base_price) when a treatment has multiple prescriptions (t.cost is added per prescription row).
-- 3. COUNT(DISTINCT a.patient_id) vs COUNT(a.patient_id) vs COUNT(DISTINCT a.admit_id) (same patient admitted twice, and multiple prescriptions per admission).
-- 4. WHERE conditions: discharge_date IS NOT NULL vs IS NULL; admit_date in '2023' vs '2022'/'2024'; admit_date vs discharge_date vs treatment_date year checks.
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'Cardiology', 'Building A');
INSERT INTO Departments (dept_id, name, building) VALUES (2, 'Neurology', 'Building B');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (101, 'Dr. Smith', 1, 'Heart');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (102, 'Dr. Adams', 2, 'Brain');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1001, 'Alice', 'F', '1980-05-10');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1002, 'Bob', 'M', '1975-08-20');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1003, 'Charlie', 'M', '1990-01-15');
-- Valid 2023 admission 1 for Alice
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2001, 1001, '2023-01-10', '2023-01-15', 'Arrhythmia');
-- Valid 2023 admission 2 for Alice (same patient, different admission, discharge in 2024 to test year check on admit_date vs discharge_date)
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2002, 1001, '2023-12-28', '2024-01-05', 'Follow-up');
-- Invalid admission: discharge_date IS NULL
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2003, 1002, '2023-06-01', NULL, 'Ongoing');
-- Invalid admission: admit_date in 2022, even though discharge_date is in 2023
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2004, 1003, '2022-12-30', '2023-01-04', 'Stroke');
INSERT INTO Medications (med_id, name, base_price) VALUES (301, 'Aspirin', 10.5);
INSERT INTO Medications (med_id, name, base_price) VALUES (302, 'BetaBlocker', 25.0);
INSERT INTO Medications (med_id, name, base_price) VALUES (303, 'NeuroMed', 50.0);
-- Treatment for valid admission 2001, with TWO prescriptions (tests t.cost multiplication in join)
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4001, 2001, 101, '2023-01-12', 100.0);
-- Treatment for valid admission 2002, with ONE prescription (treatment_date in 2024 to distinguish from admit_date year)
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4002, 2002, 101, '2024-01-02', 200.0);
-- Treatment for valid admission 2001, with ZERO prescriptions (should be excluded by INNER JOIN Prescriptions)
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4003, 2001, 101, '2023-01-13', 500.0);
-- Treatment for invalid admission 2003 (NULL discharge_date)
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4004, 2003, 102, '2023-06-02', 300.0);
-- Treatment for invalid admission 2004 (2022 admit_date, 2023 treatment_date)
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4005, 2004, 102, '2023-01-02', 400.0);
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5001, 4001, 301, '100mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5002, 4001, 302, '50mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5003, 4002, 301, '100mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5004, 4004, 303, '10mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5005, 4005, 303, '20mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('Cardiology', 'Dr. Smith', 1, 446.0)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(a.patient_id) AS total_patients, SUM(t.cost) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
('Cardiology', 'Dr. Smith', 3, 800.0)
*/