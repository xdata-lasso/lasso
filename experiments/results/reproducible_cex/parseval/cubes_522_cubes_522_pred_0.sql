-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, 't2__0325c5', -55602865);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483647, 't2__0325c5', -664303813);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483646, 'sk', 1610062532);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483645, 'u7', -734455130);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483644, 't2__9e08af', 1744686505);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (2, 't2__b187af', -1633151678);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, 'a2ypuzhsrwbb', 1072996612);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (3, 'vd', -1377057208);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483640, 'n', 462974032);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483639, 'ie5', -1209887326);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483638, 'fa9', 1620389964);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483637, '0t5c4ecigc', 528680845);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483636, 'ium5', 742285925);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483635, 'uo4nrqrofqy', -1106983592);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483634, 'bbp02eut', -1347802441);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483633, 'a11ry', -525979501);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483632, 'hl72klex1', -74849714);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483631, '7zwau2dwyr', -1021749117);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483630, 'yu78', 244829661);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483629, 'l0b4y', -1116181514);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483628, '2rk', -705985602);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483627, '58pz0f', 176555546);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483626, 'd2', 1675430660);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483625, '9uxj4hw', -2050247126);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483624, 'h2gn', 1968874827);

-- Inserting into table: friend --
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483647);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483646);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483642);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483644);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, 2);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, -2147483646);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483645);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483639);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, -2147483638);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483637);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483640);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483636);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483634);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483633);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 3);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483631);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483629);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483628);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483627);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483638);

-- Inserting into table: likes --
INSERT INTO "likes" ("student_id", "liked_id") VALUES (1, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483647, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483645, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483647, 2);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483646, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483644, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483640, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483645, 2);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483640, 2);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483638, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (3, 2);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483635, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (3, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483634, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483632, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483630, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (2, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483629, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483626, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483625, 1);

INSERT INTO "likes" ("student_id", "liked_id") VALUES (-2147483624, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, LHS.student_id AS student_id, LHS.friend_id AS friend_id, RHS.student_id AS student_id_other FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.student_id AS student_id, RHS.friend_id AS friend_id FROM highschooler AS LHS CROSS JOIN friend AS RHS) AS LHS INNER JOIN likes AS RHS ON (LHS.id = RHS.liked_id)) ORDER BY name;

/*
Gold Result:
('t2__0325c5',)
('t2__b187af',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id INTERSECT SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.liked_id = T2.id;

/*
Prediction Result:
('t2__0325c5',)
*/