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

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (2, 'gu7v', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (3, 'e4', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483645, 'hria2ypuzhs', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, 'rwbbp6luhvd', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483641, 'tti', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483640, 'bnp', 3);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483639, 'mdpos', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483638, 'ie5', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483637, 'nw6klf', 3);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483636, 'a9000t5c4eci', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483635, 'gce376nium52', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483634, 'zbuo4nrqrof', 3);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483633, 'qyp5s5bbp0', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483632, '2eutliqa11r', 2);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483631, 'ytoo3o9', 3);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483630, 'l7', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483629, 'klex14ji', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483628, '7zwau2dwyr', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483627, '13pyu', NULL);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483626, '8d99rljsl', NULL);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483625, 'b4yp5qi', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, grade, COUNT(*) OVER () AS n FROM highschooler) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC, grade NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/