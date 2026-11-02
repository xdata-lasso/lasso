-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 582.588439);

-- Inserting into table: products --
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1, 1, 'pro_53cc5b', 60.01);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (2, 1, 'pro_b2b6eb', 120.01);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (3, 1, 'pro_b2b6eb', 60.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (4, 1, 'pro_b2b6eb', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (5, 1, 'pro_b2b6eb', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT code, name, price, manufacturer FROM products WHERE (price > 60.0 AND price <= 120.0) ORDER BY code;

/*
Gold Result:
(1, 'pro_53cc5b', 60.01, 1)
*/

-- Prediction Query
SELECT * FROM products WHERE price BETWEEN 60 AND 120;

/*
Prediction Result:
(1, 1, 'pro_53cc5b', 60.01)
(3, 1, 'pro_b2b6eb', 60.0)
*/