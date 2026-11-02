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
-- Tests WHERE clause filtering (NULL discharge_date, admit_date year boundaries, treatment_date vs admit_date confusion)
-- and INNER JOIN vs LEFT JOIN behavior (unmatched Departments, Doctors, Admissions, Treatments, Medications).
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'Cardiology', 'A');
INSERT INTO Departments (dept_id, name, building) VALUES (2, 'EmptyDept', 'B');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (1, 'Dr. Smith', 1, 'Cardio');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (2, 'Dr. NoTreat', 1, 'Cardio');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (3, 'Dr. NoDept', NULL, 'General');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1, 'Alice', 'F', '1980-01-01');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (2, 'Bob', 'M', '1985-05-05');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (1, 1, '2023-01-01', '2023-01-05', 'Flu');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2, 1, '2023-12-31', '2024-01-05', 'Cold');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (3, 1, '2023-06-15', NULL, 'Ongoing');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (4, 2, '2022-12-31', '2023-01-02', 'Injury');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (5, 2, '2024-01-01', '2024-01-05', 'Checkup');
INSERT INTO Medications (med_id, name, base_price) VALUES (1, 'MedA', 10.5);
INSERT INTO Medications (med_id, name, base_price) VALUES (2, 'UnusedMed', 99.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (1, 1, 1, '2023-01-02', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (2, 2, 1, '2024-01-01', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (3, 3, 1, '2023-06-16', 300.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4, 4, 1, '2023-01-01', 400.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (5, 5, 1, '2023-12-31', 500.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (6, 1, 1, '2023-01-03', 600.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (7, 1, 3, '2023-01-02', 700.0);
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (1, 1, 1, '10mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (2, 2, 1, '20mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (3, 3, 1, '30mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (4, 4, 1, '40mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5, 5, 1, '50mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (7, 7, 1, '70mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('Cardiology', 'Dr. Smith', 1, 321.0)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(a.patient_id) AS total_patients, SUM(t.cost) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
('Cardiology', 'Dr. Smith', 3, 900.0)
*/