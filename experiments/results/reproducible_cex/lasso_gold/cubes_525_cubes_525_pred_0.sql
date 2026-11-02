-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1007, NULL, 1008);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1009, NULL, 1010);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1011, NULL, NULL);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1009, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM highschooler AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, grade, friend_id, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.friend_id AS friend_id FROM highschooler AS LHS INNER JOIN friend AS RHS ON (LHS.id = RHS.student_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT name FROM Highschooler EXCEPT SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id;

/*
Prediction Result:
*/