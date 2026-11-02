-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Alpha Phone', 128, 'Verizon', 799.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Alpha Phone', 128, 'Verizon', 799.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Zeta Phone', 64, 'T-Mobile', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Mid Phone', 512, 'AT&T', 1200.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Beta Phone', 16, 'Z-Tel', 99.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (6, 'Alpha Phone', 256, 'Verizon', 899.0);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (1, 'Downtown', 100, 15.0, 1);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (2, 'Uptown', 50, 8.0, 2);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (1, '1', 500);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (1, '4', 300);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (2, '5', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM (SELECT carrier, name, COUNT(*) AS n FROM phone GROUP BY carrier, name) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('T-Mobile',)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('Verizon',)
*/