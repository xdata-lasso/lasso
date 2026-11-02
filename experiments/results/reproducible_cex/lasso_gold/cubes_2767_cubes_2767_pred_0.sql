-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1013, 'Brian Yang', 1017, 'offer', 1021.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1014, 'Brian Yang', 1024.0, 'offer', 1032.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1015, 'Brian Yang', 1031.0, 'offer', 1043.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1016, 'Brian Yang', 1038.0, 'offer', 1054.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1025, NULL, 1029, 'discover', 1033.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1026, NULL, 1036.0, 'discover', 1044.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1027, NULL, 1043.0, 'discover', 1055.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1028, NULL, 1050.0, 'discover', 1066.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM (SELECT carrier, name, COUNT(*) AS n FROM phone GROUP BY carrier, name) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('offer',)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('discover',)
*/