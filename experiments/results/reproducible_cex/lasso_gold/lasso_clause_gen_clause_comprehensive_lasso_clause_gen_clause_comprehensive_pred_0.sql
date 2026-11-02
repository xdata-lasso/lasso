-- Schema DDL
CREATE TABLE Products (id INTEGER PRIMARY KEY, category TEXT, price REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("id", "category", "price") VALUES (1017, 'brother', 1025.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1018, 'brother', 1032.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1019, 'brother', 1039.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1020, 'brother', 1046.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1021, 'brother', 1053.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1022, 'brother', 1060.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1023, 'brother', 1067.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1024, 'brother', 1074.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1033, NULL, 1041.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1034, NULL, 1048.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1035, NULL, 1055.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1036, NULL, 1062.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1037, NULL, 1069.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1038, NULL, 1076.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1039, NULL, 1083.5);
INSERT INTO "products" ("id", "category", "price") VALUES (1040, NULL, 1090.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(*) FROM Products GROUP BY category ORDER BY COUNT(*) DESC, category NULLS LAST LIMIT 5;

/*
Gold Result:
('brother', 8)
(None, 8)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM Products ORDER BY COUNT(*) DESC, Products.id NULLS LAST LIMIT 5;

/*
Prediction Result:
('brother', 16)
*/