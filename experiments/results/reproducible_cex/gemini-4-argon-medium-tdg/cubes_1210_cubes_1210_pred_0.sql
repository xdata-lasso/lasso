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
-- Boundary value analysis on Product_Price (testing >, >=, <, <=, =, AND vs OR, 3000.0 vs 4500.0) and NULL prices
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (1, 'TYPE_C', 'Below 3000', 2999.99);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (2, 'TYPE_B', 'Exact 3000', 3000.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (3, 'TYPE_A', 'Between 3000 and 4500', 3500.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (4, 'TYPE_D', 'Exact 4500', 4500.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (5, 'TYPE_E', 'Just Above 4500', 4500.01);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (6, 'TYPE_B', 'Well Above 4500', 6000.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (7, 'TYPE_A', 'Null Price', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code FROM products WHERE (product_price > 4500.0 AND product_price > 3000.0) ORDER BY product_type_code, products.product_id NULLS LAST;

/*
Gold Result:
('TYPE_B',)
('TYPE_E',)
*/

-- Prediction Query
SELECT Product_Type_Code FROM Products WHERE Product_Price > 4500 INTERSECT SELECT Product_Type_Code FROM Products WHERE Product_Price < 3000;

/*
Prediction Result:
*/