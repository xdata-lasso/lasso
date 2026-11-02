-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO phone (phone_id, name, memory_in_g, carrier, price) VALUES (0, 'TMobile', 0, 'Sprint', 0.0), (1, 'default2', NULL, 'default1', NULL), (2, 'Sprint', 0, 'TMobile', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "phone" WHERE ("carrier" = 'Sprint' OR "carrier" = 'TMobile') ORDER BY name, phone.phone_id NULLS LAST;

/*
Gold Result:
('Sprint',)
('TMobile',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE Carrier = 'Sprint' OR Carrier = 'TMobile';

/*
Prediction Result:
('TMobile',)
('Sprint',)
*/