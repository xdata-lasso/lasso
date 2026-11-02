-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (2, '5k5swwqcgs', 64, 'pho_15c802', 171.746906);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (3, 'n8c4pgu7v', 64, 'pho_15c802', 86.520366);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (4, '4h', 65, 'ia2yp', 718.397869);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (5, '5k5swwqcgs', 32, '9n8', 874.871895);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (6, '5k5swwqcgs', NULL, '9n8', 874.871895);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (7, 'pgu7vfe4', NULL, 'hria2ypuzhs', 663.049759);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (8, 'wbbp6luhvdlt', NULL, 'ilbnp', 787.938887);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (9, 'dpos', NULL, 'ie5', 327.753528);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (10, 'w6kl', NULL, 'a9', 877.276439);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM phone WHERE (memory_in_g <> 32 AND memory_in_g <= 64) ORDER BY carrier;

/*
Gold Result:
('pho_15c802',)
*/

-- Prediction Query
SELECT Carrier FROM phone WHERE Memory_in_G < 32 INTERSECT SELECT Carrier FROM phone WHERE Memory_in_G > 64;

/*
Prediction Result:
*/