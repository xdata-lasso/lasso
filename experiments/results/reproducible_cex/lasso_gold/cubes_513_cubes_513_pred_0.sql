-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1038, 'Ryan Munoz', 1041);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1039, 'Monica Herrera', 1048.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1040, 'Jamie Arnold', 1055.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1047, 'Lisa Hensley', 1050);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1048, 'Michele Williams', 1057.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1049, 'Dylan Miller', 1064.0);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1044, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1045, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1046, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1053, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1054, NULL, NULL);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1055, NULL, NULL);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1038, 1044);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1038, 1045);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1038, 1046);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1047, 1053);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1047, 1054);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1047, 1055);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id))) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Lisa Hensley',)
('Ryan Munoz',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.grade > 5 GROUP BY T1.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Ryan Munoz',)
('Lisa Hensley',)
*/