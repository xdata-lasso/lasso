-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1063, 'Foster', 'Robin');
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1074, NULL, NULL);
INSERT INTO "inst" ("instid", "name", "country") VALUES (1064, 'Derek Wright', 'Monaco');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1074, NULL, NULL);
INSERT INTO "papers" ("paperid", "title") VALUES (1065, 'Solicitor');
INSERT INTO "papers" ("paperid", "title") VALUES (1075, NULL);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1063, 1064, 1065, 1066);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1074, 1074, 1075, 1066);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, LHS.authid AS authid, LHS.instid AS instid, LHS.authorder AS authorder FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, RHS.authid AS authid, RHS.instid AS instid, RHS.authorder AS authorder FROM papers AS LHS INNER JOIN authorship AS RHS ON (LHS.paperid = RHS.paperid)) AS LHS INNER JOIN (SELECT authid, instid, paperid, MAX(authorder) OVER () AS authorder FROM authorship) AS RHS ON (LHS.paperid = RHS.paperid AND LHS.authid = RHS.authid AND LHS.instid = RHS.instid AND LHS.authorder = RHS.authorder)) ORDER BY title;

/*
Gold Result:
(None,)
('Solicitor',)
*/

-- Prediction Query
SELECT t2.title FROM authorship AS t1 JOIN papers AS t2 ON t1.paperid = t2.paperid WHERE t1.authorder = (SELECT MAX(authorder) FROM authorship);

/*
Prediction Result:
('Solicitor',)
(None,)
*/