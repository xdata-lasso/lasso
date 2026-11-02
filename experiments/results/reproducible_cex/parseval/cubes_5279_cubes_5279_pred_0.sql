-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1, '5k5swwqcgs', 247012447, 'pho_dcbbff', 868.436572);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (2, 'c4pgu7vfe', -1633151678, 'pho_dcbbff', 134.487977);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (3, '2', 1219478689, 'pho_dcbbff', 718.397869);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-1, 'zhsrwb', 2122220075, 'pho_dcbbff', 0.5);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (0, 'p6luhvdlttil', 429706943, 'pho_1b355e', 0.0);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (4, '5k5swwqcgs', 247012447, NULL, 868.436572);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT LHS.name AS name, LHS.phone_id AS phone_id, LHS.memory_in_g AS memory_in_g, LHS.carrier AS carrier, LHS.price AS price FROM phone AS LHS INNER JOIN (SELECT MAX(price) AS price FROM phone) AS RHS ON (LHS.price = RHS.price)) ORDER BY carrier;

/*
Gold Result:
(None,)
('pho_dcbbff',)
*/

-- Prediction Query
SELECT Carrier FROM phone ORDER BY Price DESC, phone.phone_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('pho_dcbbff',)
*/