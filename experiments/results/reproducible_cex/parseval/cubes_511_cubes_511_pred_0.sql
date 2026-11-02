-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483648, '5k5swwqcgs', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483647, '9n8', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483646, '4', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, 'lhs_0c6c5d', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483644, 'gu7v', NULL);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483643, 'e4', NULL);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, 'hria2ypuzhs', NULL);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483641, NULL, 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483640, NULL, 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483639, NULL, 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483638, 'rwbbp6luhvd', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483637, 'tti', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483636, 'bnp', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS LEFT JOIN (SELECT grade, COUNT(*) AS n FROM highschooler GROUP BY grade) AS RHS ON (LHS.grade = RHS.grade)) ORDER BY grade;

/*
Gold Result:
(None,)
(1,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4;

/*
Prediction Result:
(1,)
*/