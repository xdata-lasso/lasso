-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'Phone_Z', 64, 'Carrier_A', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'Phone_A', 128, 'Carrier_B', 300.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (3, 'Phone_M', 256, 'Carrier_C', 500.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (4, 'Phone_B', 64, 'Carrier_D', 300.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (5, 'Phone_Unused', 512, 'Carrier_E', 900.0);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (1, 'Central', 100, 10.0, 1);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (2, 'North', 80, 8.0, 2);
INSERT INTO market (Market_ID, District, Num_of_employees, Num_of_shops, Ranking) VALUES (3, 'South', 50, 5.0, 3);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (1, '2', 10);
INSERT INTO phone_market (Market_ID, Phone_ID, Num_of_stock) VALUES (2, '1', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price, RHS.phone_id AS phone_id_other, RHS.num_of_stock AS num_of_stock, RHS.name AS name_other, RHS.phone_id_other AS phone_id_other_other, RHS.memory_in_g AS memory_in_g_other, RHS.carrier AS carrier_other FROM phone AS LHS INNER JOIN (SELECT * FROM (SELECT LHS.market_id AS market_id, LHS.phone_id AS phone_id, LHS.num_of_stock AS num_of_stock, RHS.name AS name, RHS.phone_id AS phone_id_other, RHS.memory_in_g AS memory_in_g, RHS.carrier AS carrier, RHS.price AS price FROM phone_market AS LHS CROSS JOIN phone AS RHS) WHERE (phone_id <= phone_id_other AND phone_id <> phone_id_other)) AS RHS ON (LHS.phone_id = RHS.market_id AND LHS.price = RHS.price)) ORDER BY name;

/*
Gold Result:
('Phone_A',)
('Phone_A',)
('Phone_Z',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE NOT Phone_id IN (SELECT Phone_ID FROM phone_market);

/*
Prediction Result:
('Phone_M',)
('Phone_B',)
('Phone_Unused',)
*/