-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483648, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 582.588439);

INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 486.033807);

-- Inserting into table: products --
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483648, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483647, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483646, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1, 1, 'pro_b2b6eb', 345.329712);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483644, 1, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483643, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483642, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483641, 1, 'pro_b2b6eb', 171.746906);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483640, -2147483648, 'pro_87a9de', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483639, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483638, 1, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483637, -2147483648, NULL, 688.4027);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483636, 1, NULL, NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483635, -2147483648, NULL, 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483634, -2147483648, NULL, 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483633, 1, 'pro_87a9de', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483632, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483631, 1, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483630, -2147483648, 'pro_87a9de', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483629, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483628, 1, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483627, 1, 'pro_87a9de', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483626, -2147483648, 'pro_87a9de', 1.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483625, 1, 'pro_87a9de', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price AS min_price_ FROM (SELECT LHS.name AS name, LHS.price AS price, RHS.code AS code, RHS.manufacturer AS manufacturer FROM (SELECT name, MIN(price) AS price FROM products GROUP BY name) AS LHS LEFT JOIN products AS RHS ON (LHS.name = RHS.name AND LHS.price = RHS.price)) ORDER BY code, name NULLS LAST, min_price_ NULLS LAST;

/*
Gold Result:
(None, None, 1.0)
(-2147483648, 'pro_87a9de', 1.0)
(-2147483647, 'pro_87a9de', 1.0)
(-2147483646, 'pro_87a9de', 1.0)
(-2147483644, 'pro_87a9de', 1.0)
(-2147483643, 'pro_87a9de', 1.0)
(-2147483642, 'pro_87a9de', 1.0)
(-2147483641, 'pro_b2b6eb', 171.746906)
(-2147483639, 'pro_87a9de', 1.0)
(-2147483638, 'pro_87a9de', 1.0)
(-2147483632, 'pro_87a9de', 1.0)
(-2147483631, 'pro_87a9de', 1.0)
(-2147483629, 'pro_87a9de', 1.0)
(-2147483628, 'pro_87a9de', 1.0)
(-2147483626, 'pro_87a9de', 1.0)
(-2147483625, 'pro_87a9de', 1.0)
*/

-- Prediction Query
SELECT code, name, MIN(price) FROM products GROUP BY name;

/*
Prediction Result:
(-2147483635, None, 1.0)
(-2147483648, 'pro_87a9de', 1.0)
(-2147483641, 'pro_b2b6eb', 171.746906)
*/