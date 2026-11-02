-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: highschooler --
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1, 'Kyle', -55602865);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (-2147483647, 'Kyle', -59984348);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (2, 't3__8c15d2', -664303813);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (3, 'cgsk9', 1610062532);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (5, 'Kyle', -106629402);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (7, 'Kyle', 1871297066);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (4, 't3__7cda71', 809183447);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (6, 't3__7cda71', 89267185);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (9, 't2__a680fc', -55602865);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (8, 'swwqcgsk', 1610062532);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (11, 't2__a680fc', -106629402);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (10, 'u7', -734455130);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (13, 't2__a680fc', 1744686505);

INSERT INTO "highschooler" ("id", "name", "grade") VALUES (12, 'hria2ypu', 1644814318);

-- Inserting into table: friend --
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 2);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (1, 3);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (3, 1);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (5, 4);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (7, 6);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (9, 8);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (11, 10);

INSERT INTO "friend" ("student_id", "friend_id") VALUES (13, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "LHS"."student_id" AS "student_id", "LHS"."friend_id" AS "friend_id", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."grade" AS "grade_other", "RHS"."student_id" AS "student_id_other" FROM (SELECT "id", "name", "grade", "student_id", "id" AS "friend_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."student_id" AS "student_id" FROM "highschooler" AS "LHS" INNER JOIN "friend" AS "RHS" ON ("LHS"."id" = "RHS"."friend_id"))) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "id", "name", "grade", "student_id", "id" AS "friend_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."student_id" AS "student_id" FROM "highschooler" AS "LHS" INNER JOIN "friend" AS "RHS" ON ("LHS"."id" = "RHS"."friend_id"))) WHERE ("name" = 'Kyle')) AS RHS ON (LHS.student_id = RHS.friend_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Kyle',)
('cgsk9',)
('t3__8c15d2',)
*/

-- Prediction Query
SELECT T3.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id JOIN Highschooler AS T3 ON T1.friend_id = T3.id WHERE T2.name = 'Kyle';

/*
Prediction Result:
('Kyle',)
('t3__8c15d2',)
('cgsk9',)
('t3__7cda71',)
('t3__7cda71',)
*/