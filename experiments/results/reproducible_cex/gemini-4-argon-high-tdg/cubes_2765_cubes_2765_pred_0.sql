-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'iPhone X', 64, 'Sprint', 899.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'Galaxy S9', 128, 'TMobile', 799.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (3, 'Galaxy S9', 64, 'Sprint', 699.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (4, 'Pixel 3', 64, 'Verizon', 799.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (5, 'Moto G', 32, 'AT&T', 249.50);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (6, 'Nokia 8', 64, NULL, 399.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "phone" WHERE ("carrier" = 'Sprint' OR "carrier" = 'TMobile') ORDER BY name, phone.phone_id NULLS LAST;

/*
Gold Result:
('Galaxy S9',)
('Galaxy S9',)
('iPhone X',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE Carrier = 'Sprint' OR Carrier = 'TMobile';

/*
Prediction Result:
('iPhone X',)
('Galaxy S9',)
('Galaxy S9',)
*/