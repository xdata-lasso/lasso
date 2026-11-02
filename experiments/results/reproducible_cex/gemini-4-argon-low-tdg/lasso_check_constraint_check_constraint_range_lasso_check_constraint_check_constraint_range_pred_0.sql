-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Exams (exam_id, subject, score) VALUES (1, 'History', 49.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (2, 'Math', 50.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (3, 'Physics', 50.5);
INSERT INTO Exams (exam_id, subject, score) VALUES (4, 'Chemistry', 51.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (5, 'Biology', 79.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (6, 'English', 79.5);
INSERT INTO Exams (exam_id, subject, score) VALUES (7, 'Art', 80.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (8, 'Music', 81.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
('Physics',)
('Chemistry',)
('Biology',)
('English',)
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score > 50 AND score = 80;

/*
Prediction Result:
('Art',)
*/