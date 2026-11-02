-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO exams (exam_id, subject, score) VALUES (0, 'default2', 81.0), (1, 'default2', 79.0), (49, 'default2', 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score > 50 AND score = 80;

/*
Prediction Result:
*/