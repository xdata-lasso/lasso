-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Exams (exam_id, subject, score) VALUES (1, 'Math', 50);
INSERT INTO Exams (exam_id, subject, score) VALUES (2, 'Physics', 50.5);
INSERT INTO Exams (exam_id, subject, score) VALUES (3, 'Chemistry', 51);
INSERT INTO Exams (exam_id, subject, score) VALUES (4, 'Biology', 65);
INSERT INTO Exams (exam_id, subject, score) VALUES (5, 'History', 79);
INSERT INTO Exams (exam_id, subject, score) VALUES (6, 'Geography', 79.5);
INSERT INTO Exams (exam_id, subject, score) VALUES (7, 'Art', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
('Physics',)
('Chemistry',)
('Biology',)
('History',)
('Geography',)
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score < 80;

/*
Prediction Result:
('Math',)
('Physics',)
('Chemistry',)
('Biology',)
('History',)
('Geography',)
*/