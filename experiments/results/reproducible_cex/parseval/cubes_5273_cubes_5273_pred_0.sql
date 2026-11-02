-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1, '5k5swwqcgs', 247012447, 'pho_ff8500', 868.436572);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483647, 'c4pgu7vfe', -1633151678, 'pho_ff8500', 134.487977);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (2, '2', 1219478689, 'uzhsrwbbp6lu', 737.440743);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (3, 'dlttil', 429706943, 'rmdp', 227.766936);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (4, 'iie5u', 1861536320, '6klfa9', 877.276439);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (5, '00t5c4ecigc', 528680845, '76nium52', 816.814398);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (6, 'buo4nrq', 418417917, 'fqyp', 488.977171);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (7, '5bbp0', 743312762, 'eutliqa11r', 997.73177);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (8, 'ytoo3o9hl7', 1178636309, 'ex1', 482.572691);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (9, '7zw', 481163439, '2dwyrq', 433.533777);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (10, 'pyu78d99', -977635379, 'sl0', 27.036693);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (11, 'p5qi2rk', -705985602, 'x58pz0f8je', 755.698226);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT carrier, MAX(n) AS n FROM (SELECT carrier, n, name, memory_in_g, price, n AS phone_id FROM (SELECT LHS.carrier AS carrier, LHS.n AS n, RHS.name AS name, RHS.memory_in_g AS memory_in_g, RHS.price AS price FROM (SELECT carrier, COUNT(*) AS n FROM phone GROUP BY carrier) AS LHS INNER JOIN phone AS RHS ON (LHS.n = RHS.phone_id AND LHS.carrier = RHS.carrier))) GROUP BY carrier) ORDER BY carrier;

/*
Gold Result:
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('pho_ff8500',)
*/