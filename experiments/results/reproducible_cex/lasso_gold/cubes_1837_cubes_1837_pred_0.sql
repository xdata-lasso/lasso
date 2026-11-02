-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1067, 'Gibbons', 'Jeremy');
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1075, 'Gibbons', 'Jeremy');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1068, 'Latoya Robbins', 'Croatia');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1076, 'Justin Baker', 'Myanmar');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1072, NULL, NULL);
INSERT INTO "papers" ("paperid", "title") VALUES (1069, 'Restaurant manager');
INSERT INTO "papers" ("paperid", "title") VALUES (1077, 'Phytotherapist');
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1067, 1068, 1069, 1070);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1067, 1072, 1069, 1074);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1075, 1076, 1077, 1078);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Jeremy' AND "lname" = 'Gibbons') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Phytotherapist',)
('Restaurant manager',)
('Restaurant manager',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Jeremy' AND t1.lname = 'Gibbons';

/*
Prediction Result:
('Restaurant manager',)
('Restaurant manager',)
('Phytotherapist',)
*/