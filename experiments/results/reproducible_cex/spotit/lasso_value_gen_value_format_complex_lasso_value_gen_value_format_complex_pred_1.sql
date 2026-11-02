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
INSERT INTO COURSE VALUES (-1, 0, '2023-01-02', 31);
INSERT INTO COURSE VALUES (0, 0, '2023-01-02', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01/01/2023' AND enrollment > 30;

/*
Prediction Result:
('0',)
('0',)
*/