-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering, duplicate Headquarters (kills DISTINCT), secondary sort on Code, NULLS LAST on Code, and INNER JOIN vs single table (via unreferenced and multi-referenced Manufacturers).
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (3, 'Alpha', 'Tokyo', 'Ken', 100.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (1, 'Beta', 'Austin', 'Bob', 200.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (2, 'Gamma', 'Berlin', 'Alice', 300.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (4, 'Delta', 'Berlin', 'Dave', 150.0);
INSERT INTO "Manufacturers" ("Code", "Name", "Headquarter", "Founder", "Revenue") VALUES (NULL, 'Epsilon', 'Berlin', 'Eve', 50.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (101, 1, 'Widget A', 10.0);
INSERT INTO "Products" ("Code", "Manufacturer", "Name", "Price") VALUES (102, 1, 'Widget B', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarter FROM manufacturers ORDER BY headquarter, manufacturers.code NULLS LAST;

/*
Gold Result:
('Austin',)
('Berlin',)
('Berlin',)
('Berlin',)
('Tokyo',)
*/

-- Prediction Query
SELECT DISTINCT headquarter FROM manufacturers;

/*
Prediction Result:
('Austin',)
('Berlin',)
('Tokyo',)
*/