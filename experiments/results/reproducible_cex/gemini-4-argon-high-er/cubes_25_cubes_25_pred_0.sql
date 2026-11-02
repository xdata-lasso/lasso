-- Schema DDL
CREATE TABLE "i006" ("Id" INTEGER, "Name" TEXT, "Other_Columns" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (1, NULL, 'X');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (2, 'A', 'Y');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (2, 'B', 'Z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, other_columns FROM (SELECT LHS.name AS name, LHS.id AS id, RHS.other_columns AS other_columns FROM (SELECT name, MAX(id) AS id FROM i006 GROUP BY name) AS LHS LEFT JOIN i006 AS RHS ON (LHS.name = RHS.name AND LHS.id = RHS.id)) ORDER BY id, name NULLS LAST, other_columns NULLS LAST;

/*
Gold Result:
(1, None, None)
(2, 'A', 'Y')
(2, 'B', 'Z')
*/

-- Prediction Query
SELECT a.* FROM i006 AS a JOIN (SELECT name, MAX(id) AS maxid FROM i006 GROUP BY name) AS b ON a.id = b.maxid;

/*
Prediction Result:
(1, None, 'X')
(2, 'A', 'Y')
(2, 'B', 'Z')
(2, 'A', 'Y')
(2, 'B', 'Z')
*/