-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Tests (test_id INTEGER PRIMARY KEY, patient_id INTEGER, score INTEGER, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Patients (patient_id, name) VALUES (1, 'Alice');
INSERT INTO Patients (patient_id, name) VALUES (2, 'Bob');
INSERT INTO Tests (test_id, patient_id, score) VALUES (1, 1, 10);
INSERT INTO Tests (test_id, patient_id, score) VALUES (2, 2, 50);
INSERT INTO Tests (test_id, patient_id, score) VALUES (3, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST, t.test_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/