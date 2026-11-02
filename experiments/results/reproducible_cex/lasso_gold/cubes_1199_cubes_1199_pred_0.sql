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
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1017, '161 Calderon River Suite 931
Lake Jeremyport, CO 31013');
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1018, '7525 Clark Grove Apt. 928
East Steven, KY 84387');
INSERT INTO "finances" ("finance_id", "other_details") VALUES (1019, 'rise');
INSERT INTO "finances" ("finance_id", "other_details") VALUES (1020, 'onto');
INSERT INTO "locations" ("location_id", "other_details") VALUES (1021, 'discuss');
INSERT INTO "locations" ("location_id", "other_details") VALUES (1022, 'reveal');
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1023, 'garden', 'Amy Underwood', 1025.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1024, 'threat', 'Amy Underwood', 1034.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1033, 'garden', 'Amy Underwood', 1025.5);
INSERT INTO "events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (1027, 1019, 1017, 1021, 1029, 'support');
INSERT INTO "events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (1028, 1019, 1017, 1021, 1040.0, 'four');
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1031, 1023, 1027);
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1032, 1023, 1027);
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1034, 1033, 1027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT event_id, product_name, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_in_event_id AS product_in_event_id, RHS.event_id AS event_id FROM products AS LHS INNER JOIN products_in_events AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY event_id, product_name) WHERE (n = 2) ORDER BY product_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Product_Name FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID = T2.Product_ID GROUP BY T1.Product_Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Amy Underwood',)
*/