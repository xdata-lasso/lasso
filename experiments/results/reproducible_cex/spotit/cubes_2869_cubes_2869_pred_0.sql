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
INSERT INTO LIST VALUES (2, 5, 3, 0);
INSERT INTO LIST VALUES (4, 6, 3, 0);
INSERT INTO TEACHERS VALUES (7, 9, 1);
INSERT INTO TEACHERS VALUES (8, 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LASTNAME FROM (SELECT * FROM (SELECT * FROM LIST WHERE (LASTNAME = 'COVIN' OR grade = 3)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM teachers AS RHS WHERE (LHS.lastname = RHS.lastname AND LHS.firstname = RHS.firstname AND LHS.classroom = RHS.classroom))) ORDER BY lastname, LASTNAME NULLS LAST;

/*
Gold Result:
('2',)
('4',)
*/

-- Prediction Query
SELECT DISTINCT T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T1.grade = 3 AND T2.firstname <> 'COVIN' AND T2.lastname <> 'JEROME';

/*
Prediction Result:
('2',)
('4',)
*/