-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1, '5k5swwqcgs', 32, 'pho_23c94d', 171.746906);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483647, 'n8c4pgu7v', 32, 'pho_23c94d', 86.520366);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (2, '4h', 33, 'ia2yp', 718.397869);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (3, 'zhsrwb', NULL, 'p', 503.083789);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (4, 'hvdltt', 32, NULL, 125.12763);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM phone WHERE (memory_in_g <= 32) ORDER BY carrier, phone.phone_id NULLS LAST;

/*
Gold Result:
(None,)
('pho_23c94d',)
('pho_23c94d',)
*/

-- Prediction Query
SELECT DISTINCT Carrier FROM phone WHERE Memory_in_G > 32;

/*
Prediction Result:
('ia2yp',)
*/