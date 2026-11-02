-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO phone (phone_id, name, memory_in_g, carrier, price) VALUES (0, NULL, 1, NULL, 2.0), (2, 'default1', 1, 'default1', 2.0), (1, NULL, 0, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/