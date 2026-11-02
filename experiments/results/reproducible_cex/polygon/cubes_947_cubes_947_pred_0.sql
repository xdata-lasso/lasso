-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (10, NULL, NULL, 'Austin14', -2241);
INSERT INTO "Manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (7, NULL, 'Austin', 'Austin15', -2240);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (9, 7, 'Austin-2241', -2241);
INSERT INTO "Products" ("code", "manufacturer", "name", "price") VALUES (8, 7, 'Austin-2241', -2241);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "revenue" AS "sum_revenue_" FROM (SELECT "code", "name", "headquarter", "founder", "revenue", SUM("revenue") OVER () AS "sumrevenue" FROM "manufacturers") WHERE ("headquarter" = 'Austin' OR sumrevenue <= revenue) ORDER BY sum_revenue_;

/*
Gold Result:
(-2241.0,)
(-2240.0,)
*/

-- Prediction Query
SELECT SUM(revenue) FROM manufacturers WHERE headquarter = 'Austin';

/*
Prediction Result:
(-2240.0,)
*/