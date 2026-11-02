-- Schema DDL
CREATE TABLE "045_1" ("Menu_id" INTEGER, "Name" TEXT);

CREATE TABLE "045_2" ("ID" INTEGER, "Quantity" INTEGER, "Menu_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (10, 'Soda');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (20, 'Soda');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (30, 'Soda');
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (201, 15, 10);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (202, 5, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS menuname, sumquantity AS quantity FROM (SELECT LHS.menu_id AS menu_id, LHS.name AS name, RHS.sumquantity AS sumquantity FROM "045_1" AS LHS LEFT JOIN (SELECT menu_id, SUM(quantity) AS sumquantity FROM "045_2" GROUP BY menu_id) AS RHS ON (LHS.menu_id = RHS.menu_id)) ORDER BY menuname, quantity NULLS LAST;

/*
Gold Result:
('Soda', 5)
('Soda', 15)
('Soda', None)
*/

-- Prediction Query
SELECT menu.name, SUM(orderregel.quantity) AS quantity FROM "045_1" AS menu LEFT JOIN "045_2" AS orderregel ON menu.menu_id = orderregel.menu_id GROUP BY menu.menu_id;

/*
Prediction Result:
('Soda', 15)
('Soda', 5)
('Soda', None)
*/