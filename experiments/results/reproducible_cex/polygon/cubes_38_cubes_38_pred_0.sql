-- Schema DDL
CREATE TABLE "i002" ("ID" INTEGER, "NAME" TEXT, "EMAIL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i002" ("id", "name", "email") VALUES (13, '15', '14');
INSERT INTO "i002" ("id", "name", "email") VALUES (0, '15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.email AS email, RHS.id AS id_other, RHS.email AS email_other FROM i002 AS LHS INNER JOIN (SELECT id, name, email, COUNT(*) OVER () AS n FROM i002) AS RHS ON (LHS.id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME FROM (SELECT EMAIL, NAME, COUNT(*) AS n FROM i002 GROUP BY EMAIL, NAME) AS t WHERE n > 1.0;

/*
Prediction Result:
*/