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
INSERT INTO HIGHSCHOOLER VALUES (1, 12, 0);
INSERT INTO HIGHSCHOOLER VALUES (0, 13, 0);
INSERT INTO FRIEND VALUES (0, 0);
INSERT INTO FRIEND VALUES (0, 1);
INSERT INTO LIKES VALUES (0, 0);
INSERT INTO LIKES VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM highschooler AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, grade, friend_id, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.friend_id AS friend_id FROM highschooler AS LHS INNER JOIN friend AS RHS ON (LHS.id = RHS.student_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
('12',)
*/

-- Prediction Query
SELECT name FROM Highschooler EXCEPT SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id;

/*
Prediction Result:
('12',)
*/