-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Model X', 128, 'Sprint', 799.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Model Z', 64, 'Verizon', 699.50);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Model A', 16, 'AT&T', 299.00);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Model M', 8, 'T-Mobile', 199.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (10, 'Model B', 64, 'AT&T', 499.00);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (11, 'Model C', 64, 'AT&T', 549.00);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (100, 'Downtown', 50, 12.0, 1);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (200, 'Uptown', 30, 8.5, 2);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (100, '1', 25);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (200, '1', 15);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (100, '2', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT memory_in_g, carrier FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST;

/*
Gold Result:
(8, 'T-Mobile')
(16, 'AT&T')
(64, 'Verizon')
(64, 'AT&T')
(64, 'AT&T')
(128, 'Sprint')
*/

-- Prediction Query
SELECT Memory_in_G, Carrier FROM phone;

/*
Prediction Result:
(128, 'Sprint')
(64, 'Verizon')
(16, 'AT&T')
(8, 'T-Mobile')
(64, 'AT&T')
(64, 'AT&T')
*/