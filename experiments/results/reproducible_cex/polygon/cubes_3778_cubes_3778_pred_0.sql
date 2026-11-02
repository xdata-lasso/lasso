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
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (19, '-543');
INSERT INTO "Locations" ("location_id", "other_details") VALUES (20, '-543');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (36, NULL, NULL, -544);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (39, '40', NULL, -543);
INSERT INTO "Parties" ("party_id", "party_details") VALUES (21, '-543');
INSERT INTO "Assets" ("asset_id", "other_details") VALUES (23, '-543');
INSERT INTO "Assets" ("asset_id", "other_details") VALUES (22, '-543');
INSERT INTO "Channels" ("channel_id", "other_details") VALUES (25, '-543');
INSERT INTO "Channels" ("channel_id", "other_details") VALUES (24, '-543');
INSERT INTO "Finances" ("finance_id", "other_details") VALUES (27, '-543');
INSERT INTO "Finances" ("finance_id", "other_details") VALUES (26, '-543');
INSERT INTO "Events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (28, 26, 19, 20, -543, '-543');
INSERT INTO "Products_in_Events" ("product_in_event_id", "product_id", "event_id") VALUES (-543, 39, 28);
INSERT INTO "Parties_in_Events" ("party_id", "event_id", "role_code") VALUES (21, 28, '-543');
INSERT INTO "Agreements" ("document_id", "event_id") VALUES (31, 28);
INSERT INTO "Agreements" ("document_id", "event_id") VALUES (30, 28);
INSERT INTO "Assets_in_Events" ("asset_id", "event_id") VALUES (-543, 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_price AS product_price_other FROM products AS LHS CROSS JOIN (SELECT MAX(product_price) AS product_price FROM products) AS RHS) WHERE (product_price >= product_price_other) ORDER BY product_name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Product_Name FROM Products ORDER BY Product_Price DESC, Products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/