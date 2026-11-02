-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Multiple students with the SAME name ('Alice') liking the SAME target (liked_id=4) -> produces count 2.
--    Distinguishes GROUP BY (liked_id, name) from GROUP BY (liked_id, student_id).
-- 2. Filtering out 'Kyle' as the liker ('name' <> 'Kyle'). Three 'Kyle's like target 4 -> count 3 should be excluded.
--    Distinguishes <> 'Kyle' from = 'Kyle' or missing WHERE clause.
-- 3. 'Kyle' as the liked target (liked_id=5), liked by 'Bob'. Since 'Bob' <> 'Kyle', count 1 is included.
--    Distinguishes joining on LHS.ID = RHS.student_id vs LHS.ID = RHS.liked_id.
-- 4. Duplicate counts (two groups yielding count 1) to test SELECT DISTINCT "n".
-- 5. Unreferenced Highschooler (ID 9) to test INNER JOIN vs LEFT JOIN.
-- 6. Insertion order yielding count 2 before count 1 to test ORDER BY count___.
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Alice', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Alice', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Bob', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Charlie', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (5, 'Kyle', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (6, 'Kyle', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (7, 'Kyle', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (8, 'David', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (9, 'Eve', 9);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (1, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (2, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (3, 5);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (8, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (5, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (6, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (7, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "liked_id", "name", COUNT(*) AS "n" FROM (SELECT "id", "name", "grade", "liked_id", "id" AS "student_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."grade" AS "grade", "RHS"."liked_id" AS "liked_id" FROM "highschooler" AS "LHS" INNER JOIN "likes" AS "RHS" ON ("LHS"."id" = "RHS"."student_id"))) GROUP BY "liked_id", "name") WHERE ("name" <> 'Kyle') ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.name = 'Kyle';

/*
Prediction Result:
(3,)
*/