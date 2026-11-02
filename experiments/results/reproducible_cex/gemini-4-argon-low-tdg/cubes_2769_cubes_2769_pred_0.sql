-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Phone A', 128, 'Verizon', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Phone B', 64, 'AT&T', 700.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Phone C', 64, 'Sprint', 600.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Phone D', 64, 'Sprint', 650.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Phone E', 256, 'T-Mobile', 300.0);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (10, 'Downtown', 50, 10.0, 1);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (10, '1', 100);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (10, '2', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT memory_in_g, carrier FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST;

/*
Gold Result:
(64, 'AT&T')
(64, 'Sprint')
(64, 'Sprint')
(128, 'Verizon')
(256, 'T-Mobile')
*/

-- Prediction Query
SELECT Memory_in_G, Carrier FROM phone;

/*
Prediction Result:
(128, 'Verizon')
(64, 'AT&T')
(64, 'Sprint')
(64, 'Sprint')
(256, 'T-Mobile')
*/