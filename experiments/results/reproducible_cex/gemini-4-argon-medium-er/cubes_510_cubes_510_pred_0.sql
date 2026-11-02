-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'A', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'B', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Z', 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, grade, COUNT(*) OVER () AS n FROM highschooler) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC, grade NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/