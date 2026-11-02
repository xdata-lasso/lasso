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
INSERT INTO STUDENT VALUES (0, 11);
INSERT INTO STUDENT VALUES (-1, 13);
INSERT INTO COURSE VALUES (-1, 947906617991415116, 9);
INSERT INTO COURSE VALUES (0, 10, 442252705611383084);
INSERT INTO ENROLLMENT VALUES (0, 0, 12);
INSERT INTO ENROLLMENT VALUES (0, -1, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.name = 'Database' AND NOT e.grade IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT s.name, e.grade FROM student AS s JOIN enrollment AS e ON s.id = e.student_id JOIN course AS c ON e.course_id = c.id WHERE c.dept = 'CS' AND NOT e.grade IS NULL;

/*
Prediction Result:
*/