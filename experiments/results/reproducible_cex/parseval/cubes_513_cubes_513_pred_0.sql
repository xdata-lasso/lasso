-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, 'lhs_3bf24c', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483647, 'swwqcgsk', 1610062532);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483646, 'gu7v', -1865039888);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483645, 'lhs_02daf7', 1);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483644, 'ia2yp', -1670923962);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483643, 'wbbp6luhvdlt', -841692980);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, 'n', 462974032);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483641, 'posiie5unw6k', 1151980946);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483640, 'a9000t5c4eci', 1149850321);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483639, 'e376nium52', -443340271);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483638, '4nrq', 418417917);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483637, 'qy', -1106983592);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483636, 'bbp02eut', -1347802441);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483635, '1', 2074205376);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483634, 'ytoo3o9', -1666765085);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483633, '72klex14ji7z', -2081315180);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483632, 'dwyrq13pyu78', 244829661);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483631, 'sl0', -2031361952);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483630, 'p5qi2rkf9v', 556727997);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483629, 'pz0f8jegd', -283454505);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483628, '9uxj4hwbdvl', 2103044118);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483627, 'gndqwnqc', 555413010);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483626, 'hncprjtu', -361507387);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483625, '9fjgq8n2f', -1056308489);

-- Inserting into table: friend --
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483647);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483646);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483644);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483643);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483642);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483641);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483640);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483639);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483638);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483645);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483637);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483636);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483635);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483634);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483633);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483632);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483631);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483630);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483629);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483628);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483627);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483626);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483625);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id))) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('lhs_3bf24c',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.grade > 5 GROUP BY T1.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/