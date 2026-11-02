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
-- Core anti-join, ordering, duplicate product names, and ID confusion traps (Product_ID vs Event_ID vs Product_in_Event_ID)
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (1, 'TYPE_A', 'Zebra', 10.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (2, 'TYPE_B', 'Apple', 20.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (3, 'TYPE_A', 'Apple', 30.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (4, 'TYPE_C', 'Mango', 40.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (5, 'TYPE_B', 'Banana', 50.0);
INSERT INTO "Addresses" ("Address_ID", "address_details") VALUES (10, '123 Main St');
INSERT INTO "Locations" ("Location_ID", "Other_Details") VALUES (20, 'Room 1');
INSERT INTO "Finances" ("Finance_ID", "Other_Details") VALUES (30, 'Fin 1');
INSERT INTO "Channels" ("Channel_ID", "Other_Details") VALUES (40, 'Web');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (1, 30, 10, 20, 40, 'EVT_1');
INSERT INTO "Events" ("Event_ID", "Finance_ID", "Address_ID", "Location_ID", "Channel_ID", "Event_Type_Code") VALUES (2, 30, 10, 20, 40, 'EVT_2');
-- Product 4 is in Event 1 and Event 2 (Product_in_Event_ID 1 and 2 match Product_IDs 1 and 2 to trap wrong column joins)
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (1, 4, 1);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (2, 4, 2);
-- Product 5 is in Event 1
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (3, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT * FROM products AS LHS WHERE NOT EXISTS(SELECT 1 FROM products_in_events AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY product_name;

/*
Gold Result:
('Apple',)
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT Product_Name FROM Products WHERE NOT Product_ID IN (SELECT Product_ID FROM Products_in_Events);

/*
Prediction Result:
('Zebra',)
('Apple',)
('Apple',)
*/