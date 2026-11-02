-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests divergence between ordering by Name DESC vs ordering by COUNT(*), Price, Memory_in_G, Phone_ID, or Carrier.
-- Also tests missing INNER/LEFT JOIN with phone_market (the target phone 'Zeta' is intentionally not in phone_market).
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Alpha', 64, 'Verizon', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Alpha', 128, 'Verizon', 600.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Alpha', 256, 'Verizon', 700.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Beta', 512, 'Sprint', 1200.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Zeta', 16, 'AT&T', 100.0);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (10, 'Downtown', 50, 10.0, 1);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (10, '1', 100);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (10, '4', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM (SELECT carrier, name, COUNT(*) AS n FROM phone GROUP BY carrier, name) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('AT&T',)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('Verizon',)
*/