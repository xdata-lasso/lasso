-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Tests (test_id INTEGER PRIMARY KEY, patient_id INTEGER, score INTEGER, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patients" ("patient_id", "name") VALUES (1013, 'Cristian Santos');
INSERT INTO "patients" ("patient_id", "name") VALUES (1037, 'Lisa Hensley');
INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (1017, 1013, 10);
INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (1029, 1013, 100);
INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (1041, 1037, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST, t.test_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1013,)
*/

-- Prediction Query
SELECT DISTINCT p.patient_id FROM Patients AS p JOIN Tests AS t ON p.patient_id = t.patient_id ORDER BY t.score DESC, p.patient_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1037,)
*/