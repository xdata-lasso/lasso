-- Schema DDL
CREATE TABLE "STUDENT" (
    "ID" INT,
    "NAME" TEXT,
    "GRADE" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "FRIEND" (
    "STUDENT_ID" INT,
    "FRIEND_ID" INT,
    PRIMARY KEY ("STUDENT_ID", "FRIEND_ID"),
    FOREIGN KEY ("STUDENT_ID") REFERENCES "STUDENT"("ID"),
    FOREIGN KEY ("FRIEND_ID") REFERENCES "STUDENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (1, 11, 0);
INSERT INTO STUDENT VALUES (0, 12, 5);
INSERT INTO FRIEND VALUES (0, 0);
INSERT INTO FRIEND VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n FROM (SELECT S.id, S.name, S.grade, F.n FROM Student AS S INNER JOIN (SELECT student_id, COUNT(*) AS n FROM Friend GROUP BY student_id) AS F ON S.id = F.student_id)) WHERE n >= 2;

/*
Gold Result:
('12',)
*/

-- Prediction Query
SELECT S.name FROM Friend AS F JOIN Student AS S ON F.student_id = S.id WHERE S.grade > 5 GROUP BY F.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/