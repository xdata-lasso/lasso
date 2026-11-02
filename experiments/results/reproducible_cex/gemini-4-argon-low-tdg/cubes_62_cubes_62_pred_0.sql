-- Schema DDL
CREATE TABLE "045_1" ("Menu_id" INTEGER, "Name" TEXT);

CREATE TABLE "045_2" ("ID" INTEGER, "Quantity" INTEGER, "Menu_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (1, 'Taco');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (1, 'Taco');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (2, 'Taco');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (3, 'Sushi');
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (4, NULL);
INSERT INTO "045_1" ("Menu_id", "Name") VALUES (NULL, 'Pasta');
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (201, -5, 1);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (202, 5, 1);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (203, -10, 2);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (204, 7, 3);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (205, 20, 4);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (206, 30, NULL);
INSERT INTO "045_2" ("ID", "Quantity", "Menu_id") VALUES (207, 40, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS menuname, sumquantity AS quantity FROM (SELECT LHS.menu_id AS menu_id, LHS.name AS name, RHS.sumquantity AS sumquantity FROM "045_1" AS LHS LEFT JOIN (SELECT menu_id, SUM(quantity) AS sumquantity FROM "045_2" GROUP BY menu_id) AS RHS ON (LHS.menu_id = RHS.menu_id)) ORDER BY menuname, quantity NULLS LAST;

/*
Gold Result:
(None, 20)
('Pasta', None)
('Sushi', 7)
('Taco', -10)
('Taco', 0)
('Taco', 0)
*/

-- Prediction Query
SELECT menu.name, SUM(orderregel.quantity) AS quantity FROM "045_1" AS menu LEFT JOIN "045_2" AS orderregel ON menu.menu_id = orderregel.menu_id GROUP BY menu.menu_id;

/*
Prediction Result:
('Pasta', None)
('Taco', 0)
('Taco', -10)
('Sushi', 7)
(None, 20)
*/