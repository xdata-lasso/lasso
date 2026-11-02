-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'Sony', 'Tokyo', 'Masaru Ibuka', 80.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'Sony', 'Tokyo', 'Akio Morita', 80.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'Sony', 'Tokyo', 'Akio Morita', 90.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Sony', 'Tokyo', NULL, 50.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Panasonic', 'Osaka', 'Konosuke Matsushita', 65.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'sony', 'Tokyo', 'Lower Case', 10.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'Sony Corporation', 'Tokyo', 'Substring Test', 10.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (8, NULL, 'Sony', 'Sony', 10.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'PlayStation 5', 499.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'Walkman', 199.99);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (103, 5, 'Toughbook', 1200.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founder" FROM "manufacturers" WHERE ("name" = 'Sony') ORDER BY founder, manufacturers.code NULLS LAST;

/*
Gold Result:
(None,)
('Akio Morita',)
('Akio Morita',)
('Masaru Ibuka',)
*/

-- Prediction Query
SELECT founder FROM manufacturers WHERE name = 'Sony';

/*
Prediction Result:
('Masaru Ibuka',)
('Akio Morita',)
('Akio Morita',)
(None,)
*/