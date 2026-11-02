-- Schema DDL
CREATE TABLE "i038" ("id" INTEGER, "name" TEXT, "city" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i038" ("id", "name", "city") VALUES (1007, 'Stephanie Miller', 'Johnsonland');
INSERT INTO "i038" ("id", "name", "city") VALUES (1010.0, 'Stephanie Miller', 'Johnsonland');
INSERT INTO "i038" ("id", "name", "city") VALUES (1013.0, 'Stephanie Miller', 'Johnsonland');
INSERT INTO "i038" ("id", "name", "city") VALUES (1016.0, 'Stephanie Miller', 'Johnsonland');
INSERT INTO "i038" ("id", "name", "city") VALUES (NULL, 'Jonathan Johnson', 'Lake Debra');
INSERT INTO "i038" ("id", "name", "city") VALUES (1019, 'Jonathan Johnson', 'Lake Debra');
INSERT INTO "i038" ("id", "name", "city") VALUES (1022.0, 'Jonathan Johnson', 'Lake Debra');
INSERT INTO "i038" ("id", "name", "city") VALUES (1025.0, 'Jonathan Johnson', 'Lake Debra');
INSERT INTO "i038" ("id", "name", "city") VALUES (1028.0, 'Jonathan Johnson', 'Lake Debra');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, city FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, RHS.n AS n FROM i038 AS LHS LEFT JOIN (SELECT city, name, COUNT(*) AS n FROM i038 GROUP BY city, name) AS RHS ON (LHS.name = RHS.name AND LHS.city = RHS.city)) WHERE (n > 1) ORDER BY id, name NULLS LAST, city NULLS LAST;

/*
Gold Result:
(None, 'Jonathan Johnson', 'Lake Debra')
(1007, 'Stephanie Miller', 'Johnsonland')
(1010, 'Stephanie Miller', 'Johnsonland')
(1013, 'Stephanie Miller', 'Johnsonland')
(1016, 'Stephanie Miller', 'Johnsonland')
(1019, 'Jonathan Johnson', 'Lake Debra')
(1022, 'Jonathan Johnson', 'Lake Debra')
(1025, 'Jonathan Johnson', 'Lake Debra')
(1028, 'Jonathan Johnson', 'Lake Debra')
*/

-- Prediction Query
SELECT s.id, t.name, t.city FROM i038 AS s JOIN (SELECT name, city, COUNT(*) AS qty FROM i038 GROUP BY name, city HAVING COUNT(*) > 1) AS t ON s.name = t.name AND s.city = t.city;

/*
Prediction Result:
(1007, 'Stephanie Miller', 'Johnsonland')
(1010, 'Stephanie Miller', 'Johnsonland')
(1013, 'Stephanie Miller', 'Johnsonland')
(1016, 'Stephanie Miller', 'Johnsonland')
(None, 'Jonathan Johnson', 'Lake Debra')
(1019, 'Jonathan Johnson', 'Lake Debra')
(1022, 'Jonathan Johnson', 'Lake Debra')
(1025, 'Jonathan Johnson', 'Lake Debra')
(1028, 'Jonathan Johnson', 'Lake Debra')
*/