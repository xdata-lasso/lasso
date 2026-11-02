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
-- Tests basic ordering by Product_Name (ASC vs DESC), tie-breaking by Product_ID (where Product_Type_Code differs on the tie), and SELECT DISTINCT mutations (exact duplicate output rows with different Product_IDs).
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (3, 'Electronics', 'Laptop', 999.99);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (1, 'Computers', 'Laptop', 1200.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (2, 'Computers', 'Laptop', 1200.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (4, 'Audio', 'Headphones', 150.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (5, 'Accessories', 'Mouse', 25.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_type_code FROM products ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Headphones', 'Audio')
('Laptop', 'Computers')
('Laptop', 'Computers')
('Laptop', 'Electronics')
('Mouse', 'Accessories')
*/

-- Prediction Query
SELECT Product_Name, Product_Type_Code FROM Products;

/*
Prediction Result:
('Laptop', 'Computers')
('Laptop', 'Computers')
('Laptop', 'Electronics')
('Headphones', 'Audio')
('Mouse', 'Accessories')
*/