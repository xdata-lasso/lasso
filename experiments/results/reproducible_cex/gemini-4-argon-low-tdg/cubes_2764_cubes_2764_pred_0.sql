-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Phone_16', 16, 'Carrier_Valid_16', 100.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Phone_31', 31, 'Carrier_Valid_31', 150.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Phone_32', 32, 'Carrier_Excluded_32', 200.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Phone_33', 33, 'Carrier_Valid_33', 250.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Phone_63', 63, 'Carrier_Valid_63', 300.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (6, 'Phone_64', 64, 'Carrier_Valid_64', 350.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (7, 'Phone_65', 65, 'Carrier_Excluded_65', 400.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (8, 'Phone_128', 128, 'Carrier_Excluded_128', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM phone WHERE (memory_in_g <> 32 AND memory_in_g <= 64) ORDER BY carrier;

/*
Gold Result:
('Carrier_Valid_16',)
('Carrier_Valid_31',)
('Carrier_Valid_33',)
('Carrier_Valid_63',)
('Carrier_Valid_64',)
*/

-- Prediction Query
SELECT Carrier FROM phone WHERE Memory_in_G < 32 INTERSECT SELECT Carrier FROM phone WHERE Memory_in_G > 64;

/*
Prediction Result:
*/