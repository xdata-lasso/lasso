-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1034, 'Valerie Gray', 1036, 'Sprint', 1038.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1035, 'Sandra Montgomery', 1043.0, 'TMobile', 1049.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1040, 'Laura Bush', 1042, 'Sprint', 1044.5);
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (1041, 'Darren Roberts', 1049.0, 'TMobile', 1055.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "phone" WHERE ("carrier" = 'Sprint' OR "carrier" = 'TMobile') ORDER BY name, phone.phone_id NULLS LAST;

/*
Gold Result:
('Darren Roberts',)
('Laura Bush',)
('Sandra Montgomery',)
('Valerie Gray',)
*/

-- Prediction Query
SELECT Name FROM phone WHERE Carrier = 'Sprint' OR Carrier = 'TMobile';

/*
Prediction Result:
('Valerie Gray',)
('Sandra Montgomery',)
('Laura Bush',)
('Darren Roberts',)
*/