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
INSERT INTO medications (med_id, name, base_price) VALUES (1, 'default1', NULL), (0, 'default2', 1.0), (2, 'default1', 1.0), (3, '2023', 1.0), (4, 'default2', NULL), (5, '%Y', 1.0);
INSERT INTO patients (patient_id, name, gender, dob) VALUES (0, 'default2', '%Y', NULL), (1, 'default2', '2023', '2023-10-27');
INSERT INTO admissions (admit_id, patient_id, admit_date, discharge_date, diagnosis) VALUES (1, 0, NULL, NULL, 'default1'), (0, NULL, '2023-01-02', '2023-01-01', NULL), (2, 0, '2023-10-27', '2023-01-02', '%Y'), (3, 0, '2023-10-27', '2023-10-27', 'default2'), (4, 1, NULL, '2023-01-01', '%Y'), (5, 1, '2023-01-01', '2023-01-01', 'default1'), (6, NULL, NULL, '2023-10-27', '2023');
INSERT INTO departments (dept_id, name, building) VALUES (1, 'default1', 'default2'), (0, NULL, '%Y'), (2, 'default2', 'default2');
INSERT INTO doctors (doc_id, dept_id, name, specialty) VALUES (1, 2, '2023', '2023'), (0, 0, NULL, NULL), (2, 2, '2023', '%Y'), (3, NULL, '%Y', 'default2'), (4, NULL, '2023', 'default2');
INSERT INTO treatments (treat_id, doc_id, admit_id, treatment_date, cost) VALUES (1, 0, 2, '2023-01-02', NULL), (0, 1, 0, NULL, 1.0), (2, NULL, 0, '2023-01-01', 0.0);
INSERT INTO prescriptions (presc_id, med_id, treat_id, dosage) VALUES (0, 4, NULL, '%Y'), (1, 3, NULL, 'default2'), (2, 1, 2, '2023'), (3, 4, 2, '%Y'), (4, 3, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(a.patient_id) AS total_patients, SUM(t.cost) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
('default2', '2023', 0, 1.0)
(None, None, 1, None)
*/