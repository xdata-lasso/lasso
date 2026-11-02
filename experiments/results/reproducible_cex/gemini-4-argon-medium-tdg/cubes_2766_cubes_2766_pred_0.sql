-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Phone A', 16, 'Verizon', 299.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Phone B', 31, 'AT&T', 349.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Phone C', 32, 'T-Mobile', 399.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Phone D', 33, 'Sprint', 449.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Phone E', 64, 'Unlocked', 599.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (6, 'Phone F', NULL, 'Cricket', 199.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM phone WHERE (memory_in_g <= 32) ORDER BY carrier, phone.phone_id NULLS LAST;

/*
Gold Result:
('AT&T',)
('T-Mobile',)
('Verizon',)
*/

-- Prediction Query
SELECT DISTINCT Carrier FROM phone WHERE Memory_in_G > 32;

/*
Prediction Result:
('Sprint',)
('Unlocked',)
*/