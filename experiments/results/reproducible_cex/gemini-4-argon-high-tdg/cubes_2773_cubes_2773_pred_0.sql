-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (10, 'Phone Alpha', 128, 'Verizon', 200.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (20, 'Phone Beta', 32, 'AT&T', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (30, 'Phone Gamma', 256, 'T-Mobile', 900.0);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (1, 'Downtown', 50, 10.0, 1);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (1, 10, 100);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (1, 30, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('AT&T',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('T-Mobile',)
*/