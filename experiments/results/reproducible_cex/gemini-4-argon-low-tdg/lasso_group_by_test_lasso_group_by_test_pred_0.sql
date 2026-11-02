-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, City TEXT, Enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SUM vs AVG vs COUNT vs MAX vs MIN by creating conflicting rank orders across aggregate functions
INSERT INTO schools (id, City, Enrollment) VALUES (1, 'Alpha', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (2, 'Alpha', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (3, 'Alpha', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (4, 'Beta', 400);
INSERT INTO schools (id, City, Enrollment) VALUES (5, 'Gamma', 250);
INSERT INTO schools (id, City, Enrollment) VALUES (6, 'Gamma', 250);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT City FROM schools GROUP BY City ORDER BY SUM(Enrollment) ASC, City NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT City FROM schools ORDER BY Enrollment ASC, schools.id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Alpha',)
('Alpha',)
('Gamma',)
('Gamma',)
('Beta',)
*/