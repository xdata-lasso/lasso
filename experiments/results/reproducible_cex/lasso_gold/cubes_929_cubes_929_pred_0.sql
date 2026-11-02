-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1001, 'Allison Hill', 'table', 'save', 1007.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1002, 'Noah Rhodes', 'true', 'knowledge', 1018.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1003, 'Angie Henderson', 'according', 'grow', 1029.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1004, 'Daniel Wagner', 'song', 'fall', 1040.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1005, 'Cristian Santos', 'sure', 'clearly', 1051.5);
INSERT INTO "manufacturers" ("code", "name", "headquarter", "founder", "revenue") VALUES (1006, 'Connie Lawrence', 'collection', 'dinner', 1062.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT code, name, headquarter, founder, revenue, AVG(revenue) OVER () AS meanrevenue FROM manufacturers) ORDER BY revenue DESC) LIMIT 3);

/*
Gold Result:
('Connie Lawrence',)
('Cristian Santos',)
('Daniel Wagner',)
*/

-- Prediction Query
SELECT name FROM manufacturers WHERE revenue > (SELECT AVG(revenue) FROM manufacturers);

/*
Prediction Result:
('Daniel Wagner',)
('Cristian Santos',)
('Connie Lawrence',)
*/