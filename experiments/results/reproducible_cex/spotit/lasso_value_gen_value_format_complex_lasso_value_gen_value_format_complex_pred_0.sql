-- Schema DDL
CREATE TABLE "COURSE" (
    "ID" INT,
    "NAME" TEXT,
    "START_DATE" DATE,
    "ENROLLMENT" INT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COURSE VALUES (-1, 0, '2023-01-01', 31);
INSERT INTO COURSE VALUES (0, 0, '2023-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01/01/23' AND enrollment > 30;

/*
Prediction Result:
('0',)
*/