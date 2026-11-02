-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (9, '8', NULL, '8', 8);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (8, NULL, -635, '13', NULL);
INSERT INTO "market" ("market_id", "district", "num_of_employees", "num_of_shops", "ranking") VALUES (10, '8', 8, 8, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM phone WHERE (memory_in_g <= 32) ORDER BY carrier, phone.phone_id NULLS LAST;

/*
Gold Result:
('13',)
*/

-- Prediction Query
SELECT DISTINCT Carrier FROM phone WHERE Memory_in_G > 32;

/*
Prediction Result:
*/