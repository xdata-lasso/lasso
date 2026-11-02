-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1001, 'Allison Hill', 1005, 'agreement', 1009.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1002, 'Noah Rhodes', 1012.0, 'option', 1020.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1003, 'Angie Henderson', 1019.0, 'decide', 1031.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1004, 'Daniel Wagner', 1026.0, 'sense', 1042.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('agreement',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('sense',)
*/