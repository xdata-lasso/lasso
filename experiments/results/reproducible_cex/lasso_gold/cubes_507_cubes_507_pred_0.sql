-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1056, 'Gabrielle Davis', 1057);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1058, 'Kyle', 1059);
INSERT INTO "friend" ("student_id", "friend_id") VALUES (1058, 1056);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "LHS"."student_id" AS "student_id", "LHS"."friend_id" AS "friend_id", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."grade" AS "grade_other", "RHS"."student_id" AS "student_id_other" FROM (SELECT "id", "name", "grade", "student_id", "id" AS "friend_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."student_id" AS "student_id" FROM "highschooler" AS "LHS" INNER JOIN "friend" AS "RHS" ON ("LHS"."id" = "RHS"."friend_id"))) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "id", "name", "grade", "student_id", "id" AS "friend_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."student_id" AS "student_id" FROM "highschooler" AS "LHS" INNER JOIN "friend" AS "RHS" ON ("LHS"."id" = "RHS"."friend_id"))) WHERE ("name" = 'Kyle')) AS RHS ON (LHS.student_id = RHS.friend_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id JOIN Highschooler AS T3 ON T1.friend_id = T3.id WHERE T2.name = 'Kyle';

/*
Prediction Result:
('Gabrielle Davis',)
*/