-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (15, '16', 17, NULL, 797);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (9, '797', 797, NULL, -635);
INSERT INTO "market" ("market_id", "district", "num_of_employees", "num_of_shops", "ranking") VALUES (11, '797', 797, 797, 797);
INSERT INTO "market" ("market_id", "district", "num_of_employees", "num_of_shops", "ranking") VALUES (10, '797', 797, 797, 797);
INSERT INTO "phone_market" ("market_id", "phone_id", "num_of_stock") VALUES (10, '15', 797);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price FROM phone AS LHS INNER JOIN (SELECT MAX(price) AS price FROM phone) AS RHS ON (LHS.price = RHS.price)) ORDER BY carrier;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/