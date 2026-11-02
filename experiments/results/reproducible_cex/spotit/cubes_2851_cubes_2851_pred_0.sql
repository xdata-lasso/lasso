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
INSERT INTO LIST VALUES (2, 4, 0, 1);
INSERT INTO LIST VALUES (3, 5, 1, 0);
INSERT INTO TEACHERS VALUES (0, 6, 0);
INSERT INTO TEACHERS VALUES (0, 7, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/