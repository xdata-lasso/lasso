-- Schema DDL
CREATE TABLE "LIST" (
    "LASTNAME" TEXT,
    "FIRSTNAME" TEXT,
    "GRADE" INT,
    "CLASSROOM" INT,
    PRIMARY KEY ("LASTNAME", "FIRSTNAME")
);
CREATE TABLE "TEACHERS" (
    "LASTNAME" TEXT,
    "FIRSTNAME" TEXT,
    "CLASSROOM" INT,
    PRIMARY KEY ("LASTNAME", "FIRSTNAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LIST VALUES (2, 6, 5, 0);
INSERT INTO LIST VALUES (3, 7, 4, -1);
INSERT INTO TEACHERS VALUES (1, 8, -1);
INSERT INTO TEACHERS VALUES (0, 9, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 5)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY lastname;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 5;

/*
Prediction Result:
('0',)
*/