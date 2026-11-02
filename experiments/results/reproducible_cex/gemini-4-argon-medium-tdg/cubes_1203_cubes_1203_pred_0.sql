-- Schema DDL
CREATE TABLE "Addresses" ("Address_ID" INTEGER PRIMARY KEY, "address_details" TEXT(255));

CREATE TABLE "Locations" ("Location_ID" INTEGER PRIMARY KEY, "Other_Details" TEXT(255));

CREATE TABLE "Products" ("Product_ID" INTEGER PRIMARY KEY, "Product_Type_Code" TEXT(15), "Product_Name" TEXT(255), "Product_Price" REAL(20, 4));

CREATE TABLE "Parties" ("Party_ID" INTEGER PRIMARY KEY, "Party_Details" TEXT(255));

CREATE TABLE "Assets" ("Asset_ID" INTEGER PRIMARY KEY, "Other_Details" TEXT(255));

CREATE TABLE "Channels" ("Channel_ID" INTEGER PRIMARY KEY, "Other_Details" TEXT(255));

CREATE TABLE "Finances" ("Finance_ID" INTEGER PRIMARY KEY, "Other_Details" TEXT(255));

CREATE TABLE "Events" ("Event_ID" INTEGER PRIMARY KEY, "Finance_ID" INTEGER, "Address_ID" INTEGER, "Location_ID" INTEGER, "Channel_ID" INTEGER, "Event_Type_Code" TEXT(15), FOREIGN KEY ("Finance_ID") REFERENCES "Finances" ("Finance_ID"), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"), FOREIGN KEY ("Location_ID") REFERENCES "Locations" ("Location_ID"));

CREATE TABLE "Products_in_Events" ("Product_in_Event_ID" INTEGER PRIMARY KEY, "Product_ID" INTEGER, "Event_ID" INTEGER, FOREIGN KEY ("Product_ID") REFERENCES "Products" ("Product_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"));

CREATE TABLE "Parties_in_Events" ("Party_ID" INTEGER, "Event_ID" INTEGER, "Role_Code" TEXT(15), PRIMARY KEY ("Party_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"), FOREIGN KEY ("Party_ID") REFERENCES "Parties" ("Party_ID"));

CREATE TABLE "Agreements" ("Document_ID" INTEGER PRIMARY KEY, "Event_ID" INTEGER, FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"));

CREATE TABLE "Assets_in_Events" ("Asset_ID" INTEGER, "Event_ID" INTEGER, PRIMARY KEY ("Asset_ID", "Event_ID"), FOREIGN KEY ("Event_ID") REFERENCES "Events" ("Event_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-correlation across all metrics:
-- Type 'Z_TYPE' is lexicographically highest (Gold answer), has lowest Product_ID (1), lowest Price (10.0), lowest frequency in Products (1 row), and 0 references in Products_in_Events.
-- Type 'M_TYPE' has highest frequency in Products (2 rows).
-- Type 'A_TYPE' has highest frequency in Products_in_Events (3 rows), highest Product_ID (4), and highest Price (500.0).
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (1, 'Z_TYPE', 'Alpha_Name', 10.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (2, 'M_TYPE', 'Beta_Name', 200.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (3, 'M_TYPE', 'Gamma_Name', 300.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (4, 'A_TYPE', 'Omega_Name', 500.0);
INSERT INTO "Finances" ("Finance_ID", "Other_Details") VALUES (1, 'Fin1');
INSERT INTO "Addresses" ("Address_ID", "address_details") VALUES (1, 'Addr1');
INSERT INTO "Locations" ("Location_ID", "Other_Details") VALUES (1, 'Loc1');
INSERT INTO "Channels" ("Channel_ID", "Other_Details") VALUES (1, 'Chan1');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (1, 1, 1, 1, 1, 'E1');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (2, 1, 1, 1, 1, 'E2');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (3, 1, 1, 1, 1, 'E3');
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (1, 4, 1);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (2, 4, 2);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (3, 4, 3);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (4, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT product_id, product_type_code, COUNT(*) AS n FROM products GROUP BY product_id, product_type_code) ORDER BY product_type_code DESC) LIMIT 1);

/*
Gold Result:
('Z_TYPE',)
*/

-- Prediction Query
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code ORDER BY COUNT(*) DESC, Product_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('M_TYPE',)
*/