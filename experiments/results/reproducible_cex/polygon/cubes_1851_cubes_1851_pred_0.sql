-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Inst" ("instid", "name", "country") VALUES (38, 'Binders Unbound22', 'Binders Unbound22');
INSERT INTO "Inst" ("instid", "name", "country") VALUES (33, 'Binders Unbound22', 'Binders Unbound22');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (32, 'Binders Unbound30', 'Binders Unbound31');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (37, 'Binders Unbound35', 'Binders Unbound36');
INSERT INTO "Papers" ("paperid", "title") VALUES (23, 'Binders Unbound');
INSERT INTO "Papers" ("paperid", "title") VALUES (22, 'Binders Unbound');
INSERT INTO "Authorship" ("authid", "instid", "paperid", "authorder") VALUES (37, 38, 22, 39);
INSERT INTO "Authorship" ("authid", "instid", "paperid", "authorder") VALUES (32, 33, 22, 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("title" = 'Binders Unbound') ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Binders Unbound30',)
('Binders Unbound35',)
*/

-- Prediction Query
SELECT t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t3.title = 'Binders Unbound';

/*
Prediction Result:
('Binders Unbound30',)
('Binders Unbound35',)
*/