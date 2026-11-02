-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Tests (test_id INTEGER PRIMARY KEY, patient_id INTEGER, score INTEGER, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO patients (patient_id, name) VALUES (2, NULL), (0, 'default2'), (1, 'default2'), (3, 'default2'), (4, NULL), (5, NULL), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, 'default2');
INSERT INTO tests (test_id, patient_id, score) VALUES (1, 1, 0), (0, 3, 0), (2, 4, NULL), (3, 1, NULL), (4, 4, 2), (5, 0, NULL), (6, 4, 1), (7, 0, 2), (8, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST, t.test_id NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/