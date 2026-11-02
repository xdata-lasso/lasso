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
INSERT INTO Locations (Location_ID, Other_Details) VALUES (1, 'HQ');
INSERT INTO Finances (Finance_ID, Other_Details) VALUES (1, 'Q1 Budget');
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (1, 'HW', 'Gamma', 50.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (2, 'SW', 'Alpha', 100.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (3, 'SV', 'Beta', 25.5);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (4, 'HW', 'Delta', 75.0);
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (1, 1, 1, 1, 1, 'SALE');
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (2, 1, 1, 1, 1, 'PROMO');
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (3, 1, 1, 1, 1, 'RETURN');
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (10, 2, 1);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (20, 2, 2);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (30, 3, 1);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (40, 3, 2);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (50, 3, 3);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (60, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT product_name, COUNT(*) AS n FROM (SELECT LHS.product_in_event_id AS product_in_event_id, LHS.event_id AS event_id, LHS.product_id AS product_id, RHS.product_type_code AS product_type_code, RHS.product_name AS product_name, RHS.product_price AS product_price FROM products_in_events AS LHS INNER JOIN products AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY product_name) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 2)
('Beta', 3)
('Gamma', 1)
*/

-- Prediction Query
SELECT T1.Product_Name, COUNT(*) FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID = T2.Product_ID GROUP BY T1.Product_Name ORDER BY COUNT(*) DESC, T1.Product_Name NULLS LAST;

/*
Prediction Result:
('Beta', 3)
('Alpha', 2)
('Gamma', 1)
*/