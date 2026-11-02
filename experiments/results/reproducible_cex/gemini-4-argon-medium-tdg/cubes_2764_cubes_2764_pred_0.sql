-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values around 32 and 64, NULL handling in WHERE, and ascending ORDER BY.
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (1, 'Phone_Z_ValidLow', 16, 'Z_Carrier', 199.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (2, 'Phone_A_Boundary64', 64, 'A_Carrier', 399.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (3, 'Phone_M_Boundary31', 31, 'M_Carrier', 249.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (4, 'Phone_B_Boundary33', 33, 'B_Carrier', 259.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (5, 'Phone_C_Excluded32', 32, 'C_Carrier', 299.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (6, 'Phone_D_Excluded65', 65, 'D_Carrier', 410.00);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (7, 'Phone_E_Excluded128', 128, 'E_Carrier', 599.99);
INSERT INTO "phone" ("Phone_ID", "Name", "Memory_in_G", "Carrier", "Price") VALUES (8, 'Phone_F_NullMem', NULL, 'F_Carrier', 150.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM phone WHERE (memory_in_g <> 32 AND memory_in_g <= 64) ORDER BY carrier;

/*
Gold Result:
('A_Carrier',)
('B_Carrier',)
('M_Carrier',)
('Z_Carrier',)
*/

-- Prediction Query
SELECT Carrier FROM phone WHERE Memory_in_G < 32 INTERSECT SELECT Carrier FROM phone WHERE Memory_in_G > 64;

/*
Prediction Result:
*/