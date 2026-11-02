-- Schema DDL
CREATE TABLE schools (id INTEGER PRIMARY KEY, City TEXT, Enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (id, City, Enrollment) VALUES (1, 'Austin', 100);
INSERT INTO schools (id, City, Enrollment) VALUES (2, 'Austin', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT City FROM schools GROUP BY City ORDER BY SUM(Enrollment) ASC, City NULLS LAST;

/*
Gold Result:
('Austin',)
*/

-- Prediction Query
SELECT City FROM schools ORDER BY Enrollment ASC, schools.id NULLS LAST;

/*
Prediction Result:
('Austin',)
('Austin',)
*/