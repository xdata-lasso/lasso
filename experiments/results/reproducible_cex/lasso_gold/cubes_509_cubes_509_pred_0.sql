-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1006, 'Cristian Santos', 1007);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1008, 'Angie Henderson', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, grade FROM highschooler ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
('Angie Henderson', 1008)
('Cristian Santos', 1007)
*/

-- Prediction Query
SELECT name, grade FROM Highschooler;

/*
Prediction Result:
('Cristian Santos', 1007)
('Angie Henderson', 1008)
*/