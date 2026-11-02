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
-- Core dataset: Tests basic projection, primary sorting on Product_Name, secondary sorting on Product_ID (tie-breakers), DISTINCT/GROUP BY mutations, and join mutations (via unreferenced products and products referenced multiple times).
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (10, 'Type_Z', 'Alpha', 50.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (2, 'Type_A', 'Alpha', 100.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (5, 'Type_A', 'Alpha', 10.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (1, 'Type_B', 'Beta', 200.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (20, 'Type_C', 'Gamma', 5.0);
INSERT INTO "Finances" ("Finance_ID", "Other_Details") VALUES (1, 'Fin1');
INSERT INTO "Addresses" ("Address_ID", "address_details") VALUES (1, 'Addr1');
INSERT INTO "Locations" ("Location_ID", "Other_Details") VALUES (1, 'Loc1');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (100, 1, 1, 1, 1, 'Evt1');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (101, 1, 1, 1, 1, 'Evt2');
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (1, 1, 100);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (2, 1, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_type_code FROM products ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Type_A')
('Alpha', 'Type_A')
('Alpha', 'Type_Z')
('Beta', 'Type_B')
('Gamma', 'Type_C')
*/

-- Prediction Query
SELECT Product_Name, Product_Type_Code FROM Products;

/*
Prediction Result:
('Beta', 'Type_B')
('Alpha', 'Type_A')
('Alpha', 'Type_A')
('Alpha', 'Type_Z')
('Gamma', 'Type_C')
*/