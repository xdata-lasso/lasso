-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, City TEXT, Enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (id, City, Enrollment) VALUES (1, 'Boston', 300);
INSERT INTO schools (id, City, Enrollment) VALUES (2, 'Boston', 300);
INSERT INTO schools (id, City, Enrollment) VALUES (3, 'Austin', 400);
INSERT INTO schools (id, City, Enrollment) VALUES (4, 'Chicago', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (5, 'Chicago', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (6, 'Chicago', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT City FROM schools GROUP BY City ORDER BY SUM(Enrollment) ASC, City NULLS LAST;

/*
Gold Result:
('Chicago',)
('Austin',)
('Boston',)
*/

-- Prediction Query
SELECT City FROM schools ORDER BY Enrollment ASC, schools.id NULLS LAST;

/*
Prediction Result:
('Chicago',)
('Chicago',)
('Chicago',)
('Boston',)
('Boston',)
('Austin',)
*/