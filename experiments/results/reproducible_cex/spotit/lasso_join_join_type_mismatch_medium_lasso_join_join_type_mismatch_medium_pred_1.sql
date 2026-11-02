-- Schema DDL
CREATE TABLE "CLASSES" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ENROLLMENTS" (
    "ID" INT,
    "CLASS_ID" INT,
    "STUDENT_ID" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("CLASS_ID") REFERENCES "CLASSES"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CLASSES VALUES (0, 24);
INSERT INTO CLASSES VALUES (-1, 25);
INSERT INTO ENROLLMENTS VALUES (0, 0, 0);
INSERT INTO ENROLLMENTS VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
('24', 2)
('25', 0)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c CROSS JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
('24', 2)
*/