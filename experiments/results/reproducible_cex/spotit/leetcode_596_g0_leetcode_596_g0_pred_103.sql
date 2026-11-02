-- Schema DDL
CREATE TABLE "COURSES" (
    "STUDENT" TEXT,
    "CLASS" TEXT,
    PRIMARY KEY ("STUDENT"),
    UNIQUE ("STUDENT", "CLASS")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COURSES VALUES (2, 4);
INSERT INTO COURSES VALUES (3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) > 1;

/*
Prediction Result:
('4',)
*/