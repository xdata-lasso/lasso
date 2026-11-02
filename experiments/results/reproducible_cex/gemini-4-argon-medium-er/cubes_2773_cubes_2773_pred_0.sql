-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (1, 'PhoneA', 16, 'CarrierA', 100.0);
INSERT INTO phone (Phone_ID, Name, Memory_in_G, Carrier, Price) VALUES (2, 'PhoneB', 64, 'CarrierB', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('CarrierA',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('CarrierB',)
*/