-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, 'Indiana University', '5k5swwqcgs');

INSERT INTO "inst" ("instid", "name", "country") VALUES (2, 'Indiana University', 'w6kl');

INSERT INTO "inst" ("instid", "name", "country") VALUES (3, 'a9', '00t5c4e');

INSERT INTO "inst" ("instid", "name", "country") VALUES (4, 'gce', '76nium52');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483648, '9n8', '4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483647, 'hria2ypu', 'hsrwbbp');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483646, 'rmdp', 'siie');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483645, 'o4nrqr', 'fqyp');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483644, 'p', '02eutliqa11r');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483643, '9hl7', 'klex14ji');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483642, 'u', '2dwyrq13pyu7');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483641, 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483640, 'y9uxj4', 'wb');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483639, 'h2gn', 'q');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483638, 'rjtu', 'dz79fjg');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483637, 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483636, 'vck6ah0f8', 'sww');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483635, 'xb72fxa7ryfd', 'z16ni');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483634, 'i', 'dh5ogrgj');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483633, 'afgogri', 'tsj3ayxp1q4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483632, 'e', '8c68');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483631, 'x7afu5w1of77', 'zo72');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483630, 't', 'mfg62g0v5q8q');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483629, 'io22785', '7cvtjpt');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (1, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483648, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (2, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483646, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (3, 'hvdltt');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483643, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483642, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483641, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483640, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483639, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483638, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483637, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483636, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483635, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483634, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483633, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483632, 't1__a9ddbf');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483631, 't1__a9ddbf');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483648, 1, 1, -734455130);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483647, 1, 1, 13244799);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483648, 1, 3, -1364429300);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 1, 3, -45536098);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 3, 1, 1274489983);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 4, 1, -443340271);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483645, 1, 3, -921187550);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483644, 1, 3, 2137741668);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483644, 3, 1, -525979501);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483647, 4, 1, 624571013);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483643, 1, 3, -453362185);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483642, 1, 3, 244829661);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483647, 3, 1, 1661181156);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483641, 4, 1, 1836127587);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483642, 1, 1, 836513442);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 1, 1, -1937207087);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483640, 1, 1, -1929953647);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483639, 1, 1, -664193365);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483644, 1, 1, -1660358170);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483638, 1, 1, -1255130038);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483637, 1, 1, 638024588);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483636, 1, 1, -1388029300);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483635, 1, 1, 2011234363);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483634, 1, 1, -458359144);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483633, 1, 1, -1538707438);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483632, 1, 1, -683007527);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483631, 1, 1, -1957268147);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483630, 1, 1, -1488156735);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483629, 1, 1, 453836040);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483645, 1, 1, -2033879835);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483641, 1, 1, 944975670);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'Indiana University') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('hvdltt',)
('hvdltt',)
('hvdltt',)
('hvdltt',)
('hvdltt',)
('hvdltt',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
('t1__a9ddbf',)
*/

-- Prediction Query
SELECT DISTINCT t1.title FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Indiana University';

/*
Prediction Result:
('t1__a9ddbf',)
('hvdltt',)
*/