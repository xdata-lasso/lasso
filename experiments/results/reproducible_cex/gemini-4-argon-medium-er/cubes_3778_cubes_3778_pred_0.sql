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
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (1, 'TypeA', 'ProductA', 100.0);
INSERT INTO "Products" ("Product_ID", "Product_Type_Code", "Product_Name", "Product_Price") VALUES (2, 'TypeB', 'ProductB', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_price AS product_price_other FROM products AS LHS CROSS JOIN (SELECT MAX(product_price) AS product_price FROM products) AS RHS) WHERE (product_price >= product_price_other) ORDER BY product_name;

/*
Gold Result:
('ProductA',)
('ProductB',)
*/

-- Prediction Query
SELECT Product_Name FROM Products ORDER BY Product_Price DESC, Products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('ProductA',)
*/