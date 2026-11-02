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
INSERT INTO LIST VALUES (10, 11, 0, 0);
INSERT INTO LIST VALUES (10, 3, 0, 0);
INSERT INTO TEACHERS VALUES (0, 4, 0);
INSERT INTO TEACHERS VALUES (0, 5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom, n AS count___ FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) WHERE (grade = 0) ORDER BY classroom, count___ NULLS LAST;

/*
Gold Result:
(0, 2)
*/

-- Prediction Query
SELECT classroom, COUNT(*) FROM list WHERE grade = '0' GROUP BY classroom;

/*
Prediction Result:
(0, 2)
*/