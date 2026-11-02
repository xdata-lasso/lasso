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
INSERT INTO "departments" ("dept_id", "name", "building") VALUES (1001, 'Allison Hill', 'dog');
INSERT INTO "medications" ("med_id", "name", "base_price") VALUES (1002, 'Brian Yang', 1003.5);
INSERT INTO "patients" ("patient_id", "name", "gender", "dob") VALUES (1004, 'Leslie Johnson', 'better', '1970-01-01');
INSERT INTO "admissions" ("admit_id", "patient_id", "admit_date", "discharge_date", "diagnosis") VALUES (1005, 1004, '2023-01-01', '1971-02-02', 'discover');
INSERT INTO "doctors" ("doc_id", "name", "dept_id", "specialty") VALUES (1006, 'Lance Hoffman', 1001, 'sense');
INSERT INTO "treatments" ("treat_id", "admit_id", "doc_id", "treatment_date", "cost") VALUES (1007, 1005, 1006, '1972-03-03', 1008.5);
INSERT INTO "prescriptions" ("presc_id", "treat_id", "med_id", "dosage") VALUES (1009, 1007, 1002, 'rate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE NOT a.discharge_date IS NULL AND STRFTIME('%Y', a.admit_date) = '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Gold Result:
('Allison Hill', 'Lance Hoffman', 1, 2012.0)
*/

-- Prediction Query
SELECT d.name AS dept_name, doc.name AS doctor_name, COUNT(DISTINCT a.patient_id) AS total_patients, SUM(t.cost + m.base_price) AS total_revenue FROM Departments AS d JOIN Doctors AS doc ON d.dept_id = doc.dept_id JOIN Treatments AS t ON doc.doc_id = t.doc_id JOIN Admissions AS a ON t.admit_id = a.admit_id JOIN Prescriptions AS p ON t.treat_id = p.treat_id JOIN Medications AS m ON p.med_id = m.med_id WHERE STRFTIME('%Y', a.admit_date) > '2023' GROUP BY d.name, doc.name ORDER BY total_revenue DESC, dept_name NULLS LAST, doctor_name NULLS LAST, total_patients NULLS LAST;

/*
Prediction Result:
*/