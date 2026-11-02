-- Schema DDL
CREATE TABLE "COURSE" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ENROLLMENT" (
    "COURSE_ID" INT,
    "GRADE" FLOAT,
    FOREIGN KEY ("COURSE_ID") REFERENCES "COURSE"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COURSE VALUES (-2147483648, 8);
INSERT INTO COURSE VALUES (-2147483647, 8);
INSERT INTO ENROLLMENT VALUES (-2147483648, 1);
INSERT INTO ENROLLMENT VALUES (-2147483647, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name;

/*
Prediction Result:
('8', 0.0)
*/