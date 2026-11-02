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
INSERT INTO HIGHSCHOOLER VALUES (0, 0, 0);
INSERT INTO HIGHSCHOOLER VALUES (1, 2, 0);
INSERT INTO FRIEND VALUES (1, 0);
INSERT INTO FRIEND VALUES (1, 1);
INSERT INTO LIKES VALUES (0, 1);
INSERT INTO LIKES VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, LHS.student_id AS student_id, LHS.friend_id AS friend_id, RHS.student_id AS student_id_other FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.student_id AS student_id, RHS.friend_id AS friend_id FROM highschooler AS LHS CROSS JOIN friend AS RHS) AS LHS INNER JOIN likes AS RHS ON (LHS.id = RHS.liked_id)) ORDER BY name;

/*
Gold Result:
('0',)
('2',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id INTERSECT SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.liked_id = T2.id;

/*
Prediction Result:
('2',)
*/