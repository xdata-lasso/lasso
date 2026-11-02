-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Multiple rows tied for the maximum price (kills `ORDER BY Price DESC LIMIT 1` mutants).
-- 2. Duplicate carriers at the maximum price (kills `SELECT DISTINCT` or `GROUP BY` mutants).
-- 3. `ORDER BY carrier` sorting vs `Phone_ID`, `Name`, or `Memory_in_G` ordering.
-- 4. Column confusion: another row has `Memory_in_G` or `Phone_ID` larger than the max `Price`, and `Carrier` / `Name` distinct values.
-- 5. Unnecessary joins with `phone_market` (some max-price phones are not in `phone_market`, others have multiple market entries).
-- 6. Presence of NULL in `Price`.
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'Zeta', 128, 'Verizon', 999.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'Alpha', 256, 'AT&T', 999.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (3, 'Beta', 64, 'Verizon', 999.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (4, 'Gamma', 2048, 'T-Mobile', 500.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (5, 'Delta', 512, 'Sprint', NULL);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (10, 'Central', 100, 20.0, 1);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (20, 'North', 50, 10.0, 2);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (10, '1', 50);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (20, '1', 30);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (10, '4', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price FROM phone AS LHS INNER JOIN (SELECT MAX(price) AS price FROM phone) AS RHS ON (LHS.price = RHS.price)) ORDER BY carrier;

/*
Gold Result:
('AT&T',)
('Verizon',)
('Verizon',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Verizon',)
*/