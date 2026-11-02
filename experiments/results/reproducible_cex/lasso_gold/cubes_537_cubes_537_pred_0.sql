-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1014, 'Daniel Wagner', 1015);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1017, 'Cristian Santos', 1018);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1016, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1019, NULL, NULL);
INSERT INTO "likes" ("student_id", "liked_id") VALUES (1014, 1016);
INSERT INTO "likes" ("student_id", "liked_id") VALUES (1017, 1019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM likes GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Cristian Santos', 1)
('Daniel Wagner', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
('Daniel Wagner', 1)
('Cristian Santos', 1)
*/