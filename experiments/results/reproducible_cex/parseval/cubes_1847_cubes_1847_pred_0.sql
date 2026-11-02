-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, '9n8', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (-2147483647, 'gu7v', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (3, 'bnp', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (2, 'mdpos', 'ie5');

INSERT INTO "inst" ("instid", "name", "country") VALUES (4, '9n8', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (5, 'e4', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (6, 'tti', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (7, 'ie5', 'Japan');

INSERT INTO "inst" ("instid", "name", "country") VALUES (8, 'gce376nium52', 'Japan');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1, 'Ohori', '5k5swwqcgs');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483647, 'Ohori', '4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (3, 'Ohori', 'e4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (2, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (4, NULL, '4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (5, 'Ohori', 'hria2ypuzhs');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (6, 't1__3312af', 'bnp');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (7, NULL, 'nw6klf');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (8, 'Ohori', 'zbuo4nrqrof');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (1, 't3__fe2b71');

INSERT INTO "papers" ("paperid", "title") VALUES (2, 't3__fe2b71');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483647, 't3__fe2b71');

INSERT INTO "papers" ("paperid", "title") VALUES (3, 'tti');

INSERT INTO "papers" ("paperid", "title") VALUES (4, '5k5swwqcgs');

INSERT INTO "papers" ("paperid", "title") VALUES (5, 'gu7v');

INSERT INTO "papers" ("paperid", "title") VALUES (6, 'rwbbp6luhvd');

INSERT INTO "papers" ("paperid", "title") VALUES (7, 'mdpos');

INSERT INTO "papers" ("paperid", "title") VALUES (8, 'a9000t5c4eci');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 1, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 2, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, 1, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 3, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 2, 1, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (4, 4, 4, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (5, 5, 5, 2);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (6, 6, 6, 2);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (7, 7, 7, 2);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (8, 8, 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM "inst" AS "LHS" CROSS JOIN "authors" AS "RHS") AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("country" = 'Japan' AND "lname" = 'Ohori') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('a9000t5c4eci',)
('gu7v',)
('t3__fe2b71',)
('t3__fe2b71',)
('tti',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid JOIN inst AS t4 ON t2.instid = t4.instid WHERE t4.country = 'Japan' AND t2.authorder = 1 AND t1.lname = 'Ohori';

/*
Prediction Result:
('t3__fe2b71',)
('t3__fe2b71',)
('tti',)
*/