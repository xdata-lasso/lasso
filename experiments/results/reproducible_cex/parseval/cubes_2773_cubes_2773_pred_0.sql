-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1, 'pho_fc7c41', 1, 'pho_c7da11', 1.0);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483647, 'pho_0d9b26', 1, 'pho_be1ee7', 1.0);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483646, '5k5swwqcgs', 247012447, 'q_1_e1e3f1', 868.436572);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483645, 'c4pgu7vfe', -1633151678, 'q_1_e1e3f1', 134.487977);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-1, '2', -7719, 'puzhsrw', 944.247544);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (0, 'p', 0, 'luhvdltti', 182.319045);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM phone ORDER BY memory_in_g, phone.phone_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_e1e3f1',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('puzhsrw',)
*/