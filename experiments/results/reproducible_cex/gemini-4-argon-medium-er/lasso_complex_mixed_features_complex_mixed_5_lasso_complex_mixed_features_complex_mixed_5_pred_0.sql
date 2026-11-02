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
INSERT INTO Doctors (doc_id, name, dept_id, specialty) VALUES (1, 'Dr. Smith', 1, 'Cardiology');
INSERT INTO Patients (patient_id, name, gender, dob) VALUES (100, 'Jane Doe', 'F', '1990-01-01');
INSERT INTO Admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (1, 100, '2023-05-15', '2023-05-20', 'Flu');
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (1, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (2, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (3, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (4, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (5, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (6, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (7, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (8, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (9, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (10, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (11, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (12, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (13, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (14, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (15, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (16, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (17, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (18, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (19, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (20, 1, 1, '2023-05-15', 100.0);
INSERT INTO Treatments (treat_id, admit_id, doc_id, treatment_date, cost) VALUES (21, 1, 1, '2023-05-15', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT doc.specialty, STRFTIME('%m', a.admit_date) AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Patients AS p ON a.patient_id = p.patient_id WHERE p.gender = 'F' AND a.admit_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY doc.specialty, admit_month HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Gold Result:
('Cardiology', '05', 100.0, 100.0)
*/

-- Prediction Query
SELECT doc.specialty, '01' AS admit_month, AVG(t.cost) AS avg_treatment_cost, MAX(t.cost) AS max_treatment_cost FROM Doctors AS doc JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Patients AS p ON t.treat_id = p.patient_id WHERE p.gender = 'F' GROUP BY doc.specialty HAVING COUNT(t.treat_id) > 20 ORDER BY doc.specialty ASC, max_treatment_cost DESC, admit_month NULLS LAST, avg_treatment_cost NULLS LAST;

/*
Prediction Result:
*/