-- Schema DDL
CREATE TABLE "STUDENT" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "COURSE" (
    "ID" INT,
    "NAME" TEXT,
    "DEPT" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ENROLLMENT" (
    "STUDENT_ID" INT,
    "COURSE_ID" INT,
    "GRADE" FLOAT,
    FOREIGN KEY ("COURSE_ID") REFERENCES "COURSE"("ID"),
    FOREIGN KEY ("STUDENT_ID") REFERENCES "STUDENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (0, 13);
INSERT INTO STUDENT VALUES (-1, 15);
INSERT INTO COURSE VALUES (0, 9, NULL);
INSERT INTO COURSE VALUES (-1, NULL, NULL);
INSERT INTO ENROLLMENT VALUES (-1, 0, 14);
INSERT INTO ENROLLMENT VALUES (0, 0, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE NOT e.grade IS NULL;

/*
Prediction Result:
('15', 14.0)
('13', 16.0)
*/