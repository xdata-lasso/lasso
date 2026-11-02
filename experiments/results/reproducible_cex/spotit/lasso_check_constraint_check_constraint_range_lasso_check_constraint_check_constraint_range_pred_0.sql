-- Schema DDL
CREATE TABLE "EXAMS" (
    "EXAM_ID" INT,
    "SUBJECT" TEXT NOT NULL,
    "SCORE" FLOAT,
    PRIMARY KEY ("EXAM_ID"),
    CHECK (score > 0 AND score < 100)
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EXAMS VALUES (-1, 0, 51);
INSERT INTO EXAMS VALUES (0, 0, 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject FROM Exams WHERE score > 50 AND score < 80;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT subject FROM Exams WHERE score > 50 AND score = 80;

/*
Prediction Result:
*/