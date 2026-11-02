-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (31, 32, 33, 64, NULL), duplicate carriers (catching DISTINCT),
-- NULL carriers, and primary key vs carrier sort order.
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Phone_Z', 32, 'Verizon', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Phone_A', 31, 'AT&T', 400.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Phone_B', 16, 'AT&T', 300.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Phone_C', 33, 'Sprint', 600.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Phone_D', 64, 'T-Mobile', 700.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (6, 'Phone_E', NULL, 'Unlocked', 200.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (7, 'Phone_F', 32, NULL, 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM phone WHERE (memory_in_g <= 32) ORDER BY carrier, phone.phone_id NULLS LAST;

/*
Gold Result:
(None,)
('AT&T',)
('AT&T',)
('Verizon',)
*/

-- Prediction Query
SELECT DISTINCT Carrier FROM phone WHERE Memory_in_G > 32;

/*
Prediction Result:
('Sprint',)
('T-Mobile',)
*/