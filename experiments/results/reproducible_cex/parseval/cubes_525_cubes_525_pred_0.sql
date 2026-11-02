-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483648, 'hig_78a844', -55602865);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, 't2__fc4948', -59984348);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (2, 'hig_78a844', 1258409369);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (3, 'hig_78a844', -1981402255);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483646, 't2__63cf0b', -890215420);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483643, '8c4p', 1871297066);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483642, 'hig_78a844', 809183447);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483641, 'hig_41e2c3', 89267185);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483640, 'hig_78a844', -1633151678);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483639, 'hig_78a844', 1914020640);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483638, 'hig_78a844', 1219478689);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483637, 'hig_78a844', 1644814318);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483636, 'rwbbp', 13244799);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483635, 'hvdlttilbnpr', 2087640001);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483634, 'hig_78a844', 907682809);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483633, 'hig_78a844', 2026480202);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483632, 'e5u', 1861536320);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483631, NULL, -1399556171);

-- Inserting into table: friend --
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483646);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483643);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (2, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, 2);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, -2147483641);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, -2147483643);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483636);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483635);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 3);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483639);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483632);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483637);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM highschooler AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT id, name, grade, friend_id, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.friend_id AS friend_id FROM highschooler AS LHS INNER JOIN friend AS RHS ON (LHS.id = RHS.student_id))) AS RHS WHERE (LHS.id = RHS.id AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
(None,)
('8c4p',)
('e5u',)
('hig_41e2c3',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hig_78a844',)
('hvdlttilbnpr',)
('rwbbp',)
('t2__63cf0b',)
*/

-- Prediction Query
SELECT name FROM Highschooler EXCEPT SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id;

/*
Prediction Result:
(None,)
('8c4p',)
('e5u',)
('hig_41e2c3',)
('hvdlttilbnpr',)
('rwbbp',)
('t2__63cf0b',)
*/