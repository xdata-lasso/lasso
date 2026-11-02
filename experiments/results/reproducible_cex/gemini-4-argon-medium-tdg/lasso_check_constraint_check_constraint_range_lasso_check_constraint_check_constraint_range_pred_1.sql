-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Exams (exam_id, subject, score) VALUES (1, 'History', 10.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (2, 'Biology', 49.9);
INSERT INTO Exams (exam_id, subject, score) VALUES (3, 'Math', 50.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (4, 'Physics', 50.1);
INSERT INTO Exams (exam_id, subject, score) VALUES (5, 'Chemistry', 51.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (6, 'Art', 65.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (7, 'Music', 79.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (8, 'Literature', 79.9);
INSERT INTO Exams (exam_id, subject, score) VALUES (9, 'Geography', 80.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (10, 'Economics', 80.1);
INSERT INTO Exams (exam_id, subject, score) VALUES (11, 'Philosophy', 95.0);
INSERT INTO Exams (exam_id, subject, score) VALUES (12, 'Sociology', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
('Physics',)
('Chemistry',)
('Art',)
('Music',)
('Literature',)
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score < 80;

/*
Prediction Result:
('History',)
('Biology',)
('Math',)
('Physics',)
('Chemistry',)
('Art',)
('Music',)
('Literature',)
*/