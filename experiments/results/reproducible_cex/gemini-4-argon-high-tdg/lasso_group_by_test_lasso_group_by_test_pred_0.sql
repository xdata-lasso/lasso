-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, City TEXT, Enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (id, City, Enrollment) VALUES (1, 'A', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (2, 'A', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (3, 'A', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (4, 'B', 250);
INSERT INTO schools (id, City, Enrollment) VALUES (5, 'C', 50);
INSERT INTO schools (id, City, Enrollment) VALUES (6, 'C', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT City FROM schools GROUP BY City ORDER BY SUM(Enrollment) ASC, City NULLS LAST;

/*
Gold Result:
('C',)
('B',)
('A',)
*/

-- Prediction Query
SELECT City FROM schools ORDER BY Enrollment ASC, schools.id NULLS LAST;

/*
Prediction Result:
('C',)
('A',)
('A',)
('A',)
('C',)
('B',)
*/