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
INSERT INTO Departments (dept_id, name, building) VALUES (1, 'Cardiology', 'Wing A');
INSERT INTO Departments (dept_id, name, building) VALUES (2, 'Neurology', 'Wing B');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (1, 'Dr. Alice', 1, 'Heart Surgery');
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (2, 'Dr. Bob', 2, 'Stroke Care');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (1, 'John Doe', 'M', '1980-05-15');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (2, 'Jane Roe', 'F', '1992-08-20');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (3, 'Sam Smith', 'M', '1975-11-02');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (1, 1, '2023-02-10', '2023-02-15', 'Arrhythmia');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (2, 1, '2023-07-01', '2023-07-05', 'Follow-up Arrhythmia');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (3, 2, '2023-03-12', '2023-03-20', 'Migraine');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (4, 3, '2023-09-01', '2023-09-10', 'Vertigo');
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (1, 1, 1, '2023-02-11', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (2, 1, 1, '2023-02-12', 50.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (3, 2, 1, '2023-07-02', 80.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4, 3, 2, '2023-03-14', 200.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (5, 4, 2, '2023-09-03', 150.0);
INSERT INTO Medications (med_id, name, base_price) VALUES (1, 'Aspirin', 10.0);
INSERT INTO Medications (med_id, name, base_price) VALUES (2, 'BetaBlocker', 20.0);
INSERT INTO Medications (med_id, name, base_price) VALUES (3, 'NeuroMed', 30.0);
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (1, 1, 1, '100mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (2, 1, 2, '50mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (3, 2, 1, '100mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (4, 3, 2, '50mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (5, 4, 3, '25mg');
INSERT INTO Prescriptions (presc_id, treat_id, med_id, dosage) VALUES (6, 5, 3, '25mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('Neurology', 'Dr. Bob', 2, 410.0)
('Cardiology', 'Dr. Alice', 1, 390.0)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE STRFTIME('%Y', a.admit_date) > '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
*/