-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1051, 'Underwood', 'Linda');
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1059, 'Thomas', 'Donald');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1052, 'Austin Gentry', 'Montenegro');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1060, 'Kimberly Burgess', 'Japan');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1056, NULL, NULL);
INSERT INTO "papers" ("paperid", "title") VALUES (1053, 'Binders Unbound');
INSERT INTO "papers" ("paperid", "title") VALUES (1061, 'Binders Unbound');
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1051, 1052, 1053, 1054);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1051, 1056, 1053, 1058);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1059, 1060, 1061, 1062);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("title" = 'Binders Unbound') ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Thomas',)
('Underwood',)
('Underwood',)
*/

-- Prediction Query
SELECT t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t3.title = 'Binders Unbound';

/*
Prediction Result:
('Underwood',)
('Underwood',)
('Thomas',)
*/