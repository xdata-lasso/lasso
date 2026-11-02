-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic MAX(authOrder), multiple papers, ORDER BY title (ASC vs DESC), and papers without authorship.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'MIT', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Stanford', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Smith', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Doe', 'Jane');
INSERT INTO "Papers" ("paperID", "title") VALUES (1, 'Zebra Research');
INSERT INTO "Papers" ("paperID", "title") VALUES (2, 'Alpha Study');
INSERT INTO "Papers" ("paperID", "title") VALUES (3, 'Unauthored Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 1, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 1, 5);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 2, 2, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 2, 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, LHS.authid AS authid, LHS.instid AS instid, LHS.authorder AS authorder FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, RHS.authid AS authid, RHS.instid AS instid, RHS.authorder AS authorder FROM papers AS LHS INNER JOIN authorship AS RHS ON (LHS.paperid = RHS.paperid)) AS LHS INNER JOIN (SELECT authid, instid, paperid, MAX(authorder) OVER () AS authorder FROM authorship) AS RHS ON (LHS.paperid = RHS.paperid AND LHS.authid = RHS.authid AND LHS.instid = RHS.instid AND LHS.authorder = RHS.authorder)) ORDER BY title;

/*
Gold Result:
('Alpha Study',)
('Zebra Research',)
*/

-- Prediction Query
SELECT t2.title FROM authorship AS t1 JOIN papers AS t2 ON t1.paperid = t2.paperid WHERE t1.authorder = (SELECT MAX(authorder) FROM authorship);

/*
Prediction Result:
('Zebra Research',)
('Alpha Study',)
*/