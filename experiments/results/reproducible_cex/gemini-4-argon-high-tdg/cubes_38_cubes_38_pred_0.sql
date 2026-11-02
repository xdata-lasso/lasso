-- Schema DDL
CREATE TABLE "i002" ("ID" INTEGER, "NAME" TEXT, "EMAIL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i002 (ID, NAME, EMAIL) VALUES (4, 'Charlie', 'c@test.com');
INSERT INTO i002 (ID, NAME, EMAIL) VALUES (4, 'Alice', 'z@test.com');
INSERT INTO i002 (ID, NAME, EMAIL) VALUES (1, 'Alice', 'a@test.com');
INSERT INTO i002 (ID, NAME, EMAIL) VALUES (2, 'Bob', 'b@test.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.email AS email, RHS.id AS id_other, RHS.email AS email_other FROM i002 AS LHS INNER JOIN (SELECT id, name, email, COUNT(*) OVER () AS n FROM i002) AS RHS ON (LHS.id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT NAME FROM (SELECT EMAIL, NAME, COUNT(*) AS n FROM i002 GROUP BY EMAIL, NAME) AS t WHERE n > 1.0;

/*
Prediction Result:
*/