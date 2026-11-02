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
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1144, '232 Nicole Burg Apt. 563
Erikville, MS 05576');
INSERT INTO "addresses" ("address_id", "address_details") VALUES (1160, '5698 Paul Ports Apt. 406
New Saraside, TX 94798');
INSERT INTO "finances" ("finance_id", "other_details") VALUES (1145, 'town');
INSERT INTO "finances" ("finance_id", "other_details") VALUES (1161, 'yard');
INSERT INTO "locations" ("location_id", "other_details") VALUES (1146, 'many');
INSERT INTO "locations" ("location_id", "other_details") VALUES (1162, 'site');
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1147, 'doctor', 'Thomas Bailey', 1148.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1163, 'since', 'Helen Jones', 1164.5);
INSERT INTO "events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (1149, 1145, 1144, 1146, 1150, 'tend');
INSERT INTO "events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (1165, 1161, 1160, 1162, 1166, 'red');
INSERT INTO "events" ("event_id", "finance_id", "address_id", "location_id", "channel_id", "event_type_code") VALUES (1157, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1151, 1147, 1149);
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1159, 1147, 1157);
INSERT INTO "products_in_events" ("product_in_event_id", "product_id", "event_id") VALUES (1167, 1163, 1165);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT product_name, COUNT(*) AS n FROM (SELECT LHS.product_in_event_id AS product_in_event_id, LHS.event_id AS event_id, LHS.product_id AS product_id, RHS.product_type_code AS product_type_code, RHS.product_name AS product_name, RHS.product_price AS product_price FROM products_in_events AS LHS INNER JOIN products AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY product_name) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Helen Jones', 1)
('Thomas Bailey', 2)
*/

-- Prediction Query
SELECT T1.Product_Name, COUNT(*) FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID = T2.Product_ID GROUP BY T1.Product_Name ORDER BY COUNT(*) DESC, T1.Product_Name NULLS LAST;

/*
Prediction Result:
('Thomas Bailey', 2)
('Helen Jones', 1)
*/