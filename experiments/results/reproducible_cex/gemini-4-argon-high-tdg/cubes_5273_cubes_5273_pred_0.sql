-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Moto G', 32, 'Sprint', 199.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'iPhone 12', 64, 'AT&T', 699.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'OnePlus 9', 128, 'T-Mobile', 729.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'iPhone 13', 128, 'AT&T', 799.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (6, 'Galaxy S21', 128, 'Verizon', 799.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (7, 'Galaxy S22', 256, 'Verizon', 849.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (8, 'Pixel 6', 128, 'Verizon', 599.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (9, 'Revvl 5G', 64, 'T-Mobile', 399.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (10, 'Nord N200', 64, 'T-Mobile', 239.99);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (11, 'Velvet 5G', 128, 'T-Mobile', 588.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT carrier, MAX(n) AS n FROM (SELECT carrier, n, name, memory_in_g, price, n AS phone_id FROM (SELECT LHS.carrier AS carrier, LHS.n AS n, RHS.name AS name, RHS.memory_in_g AS memory_in_g, RHS.price AS price FROM (SELECT carrier, COUNT(*) AS n FROM phone GROUP BY carrier) AS LHS INNER JOIN phone AS RHS ON (LHS.n = RHS.phone_id AND LHS.carrier = RHS.carrier))) GROUP BY carrier) ORDER BY carrier;

/*
Gold Result:
('AT&T',)
('Sprint',)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('T-Mobile',)
*/