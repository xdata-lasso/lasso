-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (10, 'Galaxy S20', 128, 'Sprint', 799.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'iPhone 12', 64, 'TMobile', 699.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (5, 'Pixel 5', 128, 'Verizon', 599.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (8, 'Galaxy S20', 256, 'TMobile', 899.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'OnePlus 8', 128, NULL, 499.00);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (1, 'Downtown', 50, 10.0, 1);
INSERT INTO "market" ("Market_ID", "District", "Num_of_employees", "Num_of_shops", "Ranking") VALUES (2, 'Uptown', 30, 5.0, 2);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (1, '2', 100);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (2, '2', 50);
INSERT INTO "phone_market" ("Market_ID", "Phone_ID", "Num_of_stock") VALUES (1, '5', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "phone" WHERE ("carrier" = 'Sprint' OR "carrier" = 'TMobile') ORDER BY name, phone.phone_id NULLS LAST;

/*
Gold Result:
('Galaxy S20',)
('Galaxy S20',)
('iPhone 12',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE Carrier = 'Sprint' OR Carrier = 'TMobile';

/*
Prediction Result:
('iPhone 12',)
('Galaxy S20',)
('Galaxy S20',)
*/