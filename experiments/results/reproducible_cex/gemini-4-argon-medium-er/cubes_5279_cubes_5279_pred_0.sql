-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'Phone A', 64, 'Carrier X', 1000.0);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'Phone B', 64, 'Carrier Y', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price FROM phone AS LHS INNER JOIN (SELECT MAX(price) AS price FROM phone) AS RHS ON (LHS.price = RHS.price)) ORDER BY carrier;

/*
Gold Result:
('Carrier X',)
('Carrier Y',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Carrier X',)
*/