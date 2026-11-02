-- Schema DDL
CREATE TABLE "HIGHSCHOOLER" (
    "ID" INT,
    "NAME" TEXT,
    "GRADE" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "FRIEND" (
    "STUDENT_ID" INT,
    "FRIEND_ID" INT,
    PRIMARY KEY ("STUDENT_ID", "FRIEND_ID"),
    FOREIGN KEY ("FRIEND_ID") REFERENCES "HIGHSCHOOLER"("ID"),
    FOREIGN KEY ("STUDENT_ID") REFERENCES "HIGHSCHOOLER"("ID")
);
CREATE TABLE "LIKES" (
    "STUDENT_ID" INT,
    "LIKED_ID" INT,
    PRIMARY KEY ("STUDENT_ID", "LIKED_ID"),
    FOREIGN KEY ("STUDENT_ID") REFERENCES "HIGHSCHOOLER"("ID"),
    FOREIGN KEY ("LIKED_ID") REFERENCES "HIGHSCHOOLER"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO HIGHSCHOOLER VALUES (1, 16, 6);
INSERT INTO HIGHSCHOOLER VALUES (0, 0, 5);
INSERT INTO FRIEND VALUES (0, 1);
INSERT INTO FRIEND VALUES (0, 0);
INSERT INTO LIKES VALUES (1, 0);
INSERT INTO LIKES VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id))) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.grade > 5 GROUP BY T1.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/