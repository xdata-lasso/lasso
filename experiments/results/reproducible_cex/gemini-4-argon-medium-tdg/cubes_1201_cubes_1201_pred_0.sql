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
-- Tests basic filtering, duplicate retention (SELECT vs SELECT DISTINCT), NULL handling in Product_Price, and ORDER BY (ASC vs DESC)
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (1, 'FIN', 'Trading Policy', 250.75);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (2, 'FIN', 'Trading Policy', 100.50);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (3, 'FIN', 'Trading Policy', 100.50);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (4, 'FIN', 'Trading Policy', NULL);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (5, 'INS', 'Insurance Policy', 50.00);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (6, 'FIN', NULL, 75.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_price" FROM "products" WHERE ("product_name" = 'Trading Policy') ORDER BY product_price, products.product_id NULLS LAST;

/*
Gold Result:
(None,)
(100.5,)
(100.5,)
(250.75,)
*/

-- Prediction Query
SELECT Product_Price FROM Products WHERE Product_Name = 'Dining' OR Product_Name = 'Trading Policy';

/*
Prediction Result:
(250.75,)
(100.5,)
(100.5,)
(None,)
*/