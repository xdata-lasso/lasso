-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Sony', 'Tokyo', 'Morita', 8500.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Nintendo', 'Kyoto', 'Yamauchi', 5000.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Sony', 'Tokyo', 'Ibuka', 9200.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'PlayStation', 499.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'Walkman', 199.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (103, 2, 'Switch', 299.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founder" FROM "manufacturers" WHERE ("name" = 'Sony') ORDER BY founder, manufacturers.code NULLS LAST;

/*
Gold Result:
('Ibuka',)
('Morita',)
*/

-- Prediction Query
SELECT founder FROM manufacturers WHERE name = 'Sony';

/*
Prediction Result:
('Morita',)
('Ibuka',)
*/