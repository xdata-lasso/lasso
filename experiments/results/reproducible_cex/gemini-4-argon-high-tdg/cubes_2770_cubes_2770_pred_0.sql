-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'Zenfone', 64, 'Verizon', 299.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'Alpha', 256, 'AT&T', 899.50);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (3, 'Pixel', 128, 'T-Mobile', 699.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (4, 'Alpha', 16, 'Sprint', 199.00);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (10, 'Downtown', 50, 12.0, 1);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (20, 'Uptown', 30, 8.5, 2);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (10, '1', 100);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (20, '1', 50);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (10, '2', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM phone ORDER BY name, phone.phone_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Pixel',)
('Zenfone',)
*/

-- Prediction Query
SELECT Name FROM phone ORDER BY Price ASC, phone.phone_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Zenfone',)
('Pixel',)
('Alpha',)
*/