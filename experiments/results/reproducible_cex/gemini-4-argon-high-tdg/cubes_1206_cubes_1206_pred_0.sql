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
INSERT INTO Addresses (Address_ID, address_details) VALUES (1, '100 Main St');
INSERT INTO Locations (Location_ID, Other_Details) VALUES (1, 'North Hall');
INSERT INTO Channels (Channel_ID, Other_Details) VALUES (1, 'Online');
INSERT INTO Finances (Finance_ID, Other_Details) VALUES (1, 'Q1 Budget');
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (20, 'TYPE_C', 'Monitor', 150.0000);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (10, 'TYPE_D', 'Keyboard', 400.0000);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (40, 'TYPE_A', 'Adapter', 250.0000);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (30, 'TYPE_B', 'Laptop', 50.0000);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (50, 'TYPE_E', 'Keyboard', 300.0000);
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (101, 1, 1, 1, 1, 'CONF');
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (102, 1, 1, 1, 1, 'EXPO');
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (1, 40, 101);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (2, 40, 102);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (3, 10, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM products ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Adapter',)
('Keyboard',)
('Keyboard',)
('Laptop',)
('Monitor',)
*/

-- Prediction Query
SELECT Product_Name FROM Products ORDER BY Product_Price ASC, Products.product_id NULLS LAST;

/*
Prediction Result:
('Laptop',)
('Monitor',)
('Adapter',)
('Keyboard',)
('Keyboard',)
*/