-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1001, 'Allison Hill', 1005);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1002, 'Noah Rhodes', 1012.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1003, 'Angie Henderson', 1019.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1004, 'Daniel Wagner', 1026.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, grade, COUNT(*) OVER () AS n FROM highschooler) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(1012,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC, grade NULLS LAST LIMIT 1;

/*
Prediction Result:
(1005,)
*/