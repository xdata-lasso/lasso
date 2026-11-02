-- Schema DDL
CREATE TABLE "Manufacturers" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(255), "Headquarter" TEXT(255), "Founder" TEXT(255), "Revenue" REAL);

CREATE TABLE "Products" ("Code" INTEGER PRIMARY KEY, "Manufacturer" INTEGER, "Name" TEXT(255), "Price" REAL, FOREIGN KEY ("Manufacturer") REFERENCES "Manufacturers" ("Code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (1, 'OmniCorp', 'Detroit', 'Richard Jones', 150.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (2, 'OmniCorp', 'Detroit', 'Bob Morton', 420.75);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (3, 'OmniCorp', 'Detroit', 'Danbo', 280.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (4, 'Cyberdyne', 'Sunnyvale', 'Miles Dyson', -80.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (5, 'Cyberdyne', 'Sunnyvale', 'Sarah Connor', -25.5);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (6, 'Initech', 'Austin', 'Bill Lumbergh', 300.0);
INSERT INTO Manufacturers (Code, Name, Headquarter, Founder, Revenue) VALUES (7, 'Initech', 'Austin', 'Bill Lumbergh', 300.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (101, 1, 'ED-209', 1000.0);
INSERT INTO Products (Code, Manufacturer, Name, Price) VALUES (102, 1, 'RoboCop', 2500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, revenue AS max_revenue_, headquarter FROM (SELECT headquarter, name, MAX(revenue) AS revenue FROM manufacturers GROUP BY headquarter, name) ORDER BY name, max_revenue_ NULLS LAST, headquarter NULLS LAST;

/*
Gold Result:
('Cyberdyne', -25.5, 'Sunnyvale')
('Initech', 300.0, 'Austin')
('OmniCorp', 420.75, 'Detroit')
*/

-- Prediction Query
SELECT name, MAX(revenue), Headquarter FROM manufacturers GROUP BY Headquarter;

/*
Prediction Result:
('Initech', 300.0, 'Austin')
('OmniCorp', 420.75, 'Detroit')
('Cyberdyne', -25.5, 'Sunnyvale')
*/