-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: manufacturers --
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (-2147483648, 'man_8257fe', 'man_723ac8', 'man_f2e07d', 582.588439);

-- Inserting into table: products --
INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (1, -2147483648, 'pro_41fbe0', 199.99);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (-2147483647, -2147483648, 'pro_41fbe0', 199.99);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (2, -2147483648, 'pro_b2b6eb', 200.0);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (3, -2147483648, 'pro_b2b6eb', NULL);

INSERT INTO "products" ("code", "manufacturer", "name", "price") VALUES (4, -2147483648, NULL, 199.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM products WHERE (price < 200.0) ORDER BY name, products.code NULLS LAST;

/*
Gold Result:
(None,)
('pro_41fbe0',)
('pro_41fbe0',)
*/

-- Prediction Query
SELECT name FROM products WHERE price <= 200;

/*
Prediction Result:
('pro_41fbe0',)
('pro_41fbe0',)
('pro_b2b6eb',)
(None,)
*/