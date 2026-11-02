-- Schema DDL
CREATE TABLE Exams (exam_id INTEGER PRIMARY KEY, subject TEXT(20) NOT NULL, score REAL(4, 0) CHECK (score > 0 AND score < 100));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: exams --
INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (-2147483648, 'exa_c566e0', 80.0);

INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (2, 'exa_c566e0', 80.0);

INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (3, 'exa_c566e0', 80.0);

INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (-2147483645, 'exa_c566e0', 50.0);

INSERT INTO "exams" ("exam_id", "subject", "score") VALUES (-2147483644, 'exa_c566e0', 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score > 50 AND score = 80;

/*
Prediction Result:
('exa_c566e0',)
('exa_c566e0',)
('exa_c566e0',)
('exa_c566e0',)
*/