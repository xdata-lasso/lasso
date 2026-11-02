-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Pixel', 128, 'Verizon', 699.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'iPhone', 256, 'Verizon', 999.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Galaxy', 64, 'ATT', 499.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (10, 'Moto', 32, 'TMobile', 199.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT carrier, MAX(n) AS n FROM (SELECT carrier, n, name, memory_in_g, price, n AS phone_id FROM (SELECT LHS.carrier AS carrier, LHS.n AS n, RHS.name AS name, RHS.memory_in_g AS memory_in_g, RHS.price AS price FROM (SELECT carrier, COUNT(*) AS n FROM phone GROUP BY carrier) AS LHS INNER JOIN phone AS RHS ON (LHS.n = RHS.phone_id AND LHS.carrier = RHS.carrier))) GROUP BY carrier) ORDER BY carrier;

/*
Gold Result:
('ATT',)
('Verizon',)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('Verizon',)
*/