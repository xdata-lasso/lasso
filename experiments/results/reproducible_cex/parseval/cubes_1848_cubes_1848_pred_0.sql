-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, 'University of Pennsylvania', '9n8');

INSERT INTO "inst" ("instid", "name", "country") VALUES (3, 'University of Pennsylvania', 'lbn');

INSERT INTO "inst" ("instid", "name", "country") VALUES (2, 'rmdp', 'siie');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483648, '4', 'gu7v');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483647, 'fa9', '00t5c4e');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483646, 'gce376nium52', 'zbuo4nrqrof');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483645, '5s5b', 'p');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483644, '1', 'ryytoo3');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483643, '7zw', 'au2dwyrq13');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483642, 'sl0', '4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483641, '5qi2', 'kf9vq');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483640, 'f8jegd2', 'vy9uxj4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483639, 'v', 'ph2');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483638, 'wnqcx', '5hncprjtu0d');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483637, 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483636, 'vck6ah0f8', 'sww');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483635, 'xb72fxa7ryfd', 'z16ni');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483634, 'i', 'dh5ogrgj');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483633, 'afgogri', 'tsj3ayxp1q4');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483632, 'e', '8c68');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483631, 'x7afu5w1of77', 'zo72');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483630, 't', 'mfg62g0v5q8q');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483629, 'io22785', '7cvtjpt');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483628, 'bnou5zi36', '4');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (1, '5k5swwqcgs');

INSERT INTO "papers" ("paperid", "title") VALUES (3, 'hria2ypuzhs');

INSERT INTO "papers" ("paperid", "title") VALUES (2, 'rwbbp6luhvd');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483648, 1, 1, -1865039888);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483648, 1, 2, -845863578);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483648, 2, 1, -1209887326);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483647, 1, 2, 1274489983);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 2, 1, 373262291);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483645, 1, 2, 882961052);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483645, 2, 1, -1822992503);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 1, 2, -1347802441);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483644, 2, 1, -1666765085);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483644, 1, 1, 1178636309);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483647, 1, 1, -305670381);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483643, 1, 1, 2142703426);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483645, 1, 1, 244829661);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483642, 1, 1, 1649269347);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483641, 1, 1, 537874887);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483640, 1, 1, -1612443122);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483639, 1, 1, 1298861365);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483638, 1, 1, 401805964);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483646, 1, 1, -1742081330);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483637, 1, 1, 638024588);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483636, 1, 1, -1388029300);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483635, 1, 1, 2011234363);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483634, 1, 1, -458359144);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483633, 1, 1, -1538707438);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483632, 1, 1, -683007527);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483631, 1, 1, -1957268147);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483630, 1, 1, -1488156735);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483629, 1, 1, 453836040);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (-2147483628, 1, 1, -2072838897);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count_distinct_t1_title_" FROM (SELECT "authid", "paperid", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'University of Pennsylvania')) GROUP BY authid, paperid) ORDER BY count_distinct_t1_title_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t1.title) FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'University of Pennsylvania';

/*
Prediction Result:
(2,)
*/