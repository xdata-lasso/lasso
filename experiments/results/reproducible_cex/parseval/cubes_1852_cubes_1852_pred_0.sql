-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, 'Google', '5k5swwqcgs');

INSERT INTO "inst" ("instid", "name", "country") VALUES (2, 'Google', 'p');

INSERT INTO "inst" ("instid", "name", "country") VALUES (3, 'uhv', 'l');

INSERT INTO "inst" ("instid", "name", "country") VALUES (4, 'bnp', 'mdpos');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (2, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (3, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483646, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483645, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483644, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483643, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483641, 't1__d82a24', 't1__fddf91');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483640, 't1__d82a24', 't1__fddf91');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (-2147483648, '9n8');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483647, 'gu7v');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483646, 'ypuzhsrw');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483645, 'unw6klfa');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483644, 'ecigce376n');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483643, '52zb');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483642, 'qy');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483641, 'bbp02eut');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483640, 'hl72klex1');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483639, 'yrq13p');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483638, 'd99rljsl0');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483637, 'p5qi2rkf9v');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483636, 'd21vy9uxj4hw');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483635, 'nd');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483634, 'cx5hn');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483633, 'z');

INSERT INTO "papers" ("paperid", "title") VALUES (-2147483632, '8n2f3');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483648, 1610062532);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483647, -1865039888);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483648, -992890117);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483646, 1908028688);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 3, -2147483646, -845863578);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 4, -2147483648, -1576219117);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483645, 1419861592);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483644, 1313172851);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 3, -2147483643, 757448742);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 4, -2147483647, 902887186);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483643, -967741825);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (3, 1, -2147483642, -1106983592);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 3, -2147483641, -1347802441);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 4, -2147483644, -2118135981);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483642, 274769912);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483644, 1898504886);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483645, 1644911394);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483640, -74849714);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483646, -453362185);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483648, 2123196517);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483639, -533293970);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483638, -2031361952);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483637, 556727997);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483641, 1836127587);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483642, 836513442);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483637, -1529584866);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483636, -2050247126);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483643, 1581736075);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, -2147483635, -1052964641);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483634, -1106350634);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483646, -841004020);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483633, -1748371085);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (2, 1, -2147483632, 806170397);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'Google')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
('t1__fddf91', 't1__d82a24')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Google';

/*
Prediction Result:
('t1__fddf91', 't1__d82a24')
*/