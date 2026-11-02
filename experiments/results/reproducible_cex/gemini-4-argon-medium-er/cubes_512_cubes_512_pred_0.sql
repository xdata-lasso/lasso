-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Kyle', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 9);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "liked_id", "name", COUNT(*) AS "n" FROM (SELECT "id", "name", "grade", "liked_id", "id" AS "student_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."liked_id" AS "liked_id" FROM "highschooler" AS "LHS" INNER JOIN "likes" AS "RHS" ON ("LHS"."id" = "RHS"."student_id"))) GROUP BY "liked_id", "name") WHERE ("name" <> 'Kyle') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.name = 'Kyle';

/*
Prediction Result:
(1,)
*/