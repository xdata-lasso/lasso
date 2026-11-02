-- Schema DDL
CREATE TABLE "i006" ("Id" INTEGER, "Name" TEXT, "Other_Columns" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (1, 'Alice', 'first');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (10, 'Alice', 'latest_alice');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (5, 'Alice', 'middle');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (8, 'Bob', 'latest_bob');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (2, 'Bob', 'old_bob');
INSERT INTO i006 (Id, Name, Other_Columns) VALUES (20, 'Charlie', 'only_charlie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, other_columns FROM (SELECT LHS.name AS name, LHS.id AS id, RHS.other_columns AS other_columns FROM (SELECT name, MAX(id) AS id FROM i006 GROUP BY name) AS LHS LEFT JOIN i006 AS RHS ON (LHS.name = RHS.name AND LHS.id = RHS.id)) ORDER BY id, name NULLS LAST, other_columns NULLS LAST;

/*
Gold Result:
(8, 'Bob', 'latest_bob')
(10, 'Alice', 'latest_alice')
(20, 'Charlie', 'only_charlie')
*/

-- Prediction Query
SELECT a.* FROM i006 AS a JOIN (SELECT name, MAX(id) AS maxid FROM i006 GROUP BY name) AS b ON a.id = b.maxid;

/*
Prediction Result:
(10, 'Alice', 'latest_alice')
(8, 'Bob', 'latest_bob')
(20, 'Charlie', 'only_charlie')
*/