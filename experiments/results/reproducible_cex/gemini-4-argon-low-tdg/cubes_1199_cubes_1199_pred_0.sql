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
-- Tests basic count logic: n=1, n=2, and n=3 for different products in the same and different events, plus ordering.
INSERT INTO "Events" ("Event_ID", "Event_Type_Code") VALUES (1, 'E1');
INSERT INTO "Events" ("Event_ID", "Event_Type_Code") VALUES (2, 'E2');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Type_Code", "Product_Price") VALUES (1, 'Zebra', 'T1', 10.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Type_Code", "Product_Price") VALUES (2, 'Apple', 'T1', 20.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Type_Code", "Product_Price") VALUES (3, 'Mango', 'T1', 30.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Type_Code", "Product_Price") VALUES (4, 'Pear', 'T1', 40.0);
-- Zebra: count 2 in Event 1 (Should match)
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (1, 1, 1);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (2, 1, 1);
-- Apple: count 2 in Event 2 (Should match, and sort before Zebra)
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (3, 2, 2);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (4, 2, 2);
-- Mango: count 1 in Event 1 (Should NOT match)
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (5, 3, 1);
-- Pear: count 3 in Event 1 (Should NOT match)
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (6, 4, 1);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (7, 4, 1);
INSERT INTO "Products_in_Events" ("Product_in_Event_ID", "Product_ID", "Event_ID") VALUES (8, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT event_id, product_name, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_in_event_id AS product_in_event_id, RHS.event_id AS event_id FROM products AS LHS INNER JOIN products_in_events AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY event_id, product_name) WHERE (n = 2) ORDER BY product_name;

/*
Gold Result:
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.Product_Name FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID = T2.Product_ID GROUP BY T1.Product_Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Apple',)
('Pear',)
('Zebra',)
*/