-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1008, 'Javier Johnson', 1010, 'discover', 1010.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1011, 'Lance Hoffman', 1009, 'sense', 1011.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT memory_in_g, carrier FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST;

/*
Gold Result:
(1009, 'sense')
(1010, 'discover')
*/

-- Prediction Query
SELECT Memory_in_G, Carrier FROM phone;

/*
Prediction Result:
(1010, 'discover')
(1009, 'sense')
*/