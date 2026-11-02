-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE Tests (test_id INTEGER PRIMARY KEY, patient_id INTEGER, score INTEGER, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "patients" ("patient_id", "name") VALUES (0, '8c4pgu7vfe');

INSERT INTO "patients" ("patient_id", "name") VALUES (2, 'hria2ypu');

INSERT INTO "patients" ("patient_id", "name") VALUES (-1, 'hsrwbbp');

-- Inserting into table: tests --
INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (1, 1, 247012447);

INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (-1, 2, 1);

INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (0, 2, 0);

INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (-2147483645, 1, 13244799);

INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (-2147483644, 1, -1659388584);

INSERT INTO "tests" ("test_id", "patient_id", "score") VALUES (-2147483643, 1, 1526238907);
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
(1,)
*/