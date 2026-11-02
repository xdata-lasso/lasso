-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (1004, 'brother', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score < 80;

/*
Prediction Result:
('brother',)
*/