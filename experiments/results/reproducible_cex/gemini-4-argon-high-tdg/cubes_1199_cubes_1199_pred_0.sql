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
INSERT INTO Finances (Finance_ID, Other_Details) VALUES (1, 'Corp');
INSERT INTO Channels (Channel_ID, Other_Details) VALUES (1, 'Web');
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (1, 'T1', 'Zeta', 10.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (2, 'T2', 'Alpha', 50.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (3, 'T3', 'Beta', 30.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (4, 'T4', 'Gamma', 20.0);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (5, 'T5', 'Delta', 40.0);
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (10, 1, 1, 1, 1, 'E_A');
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (20, 1, 1, 1, 1, 'E_B');
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (101, 1, 10);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (102, 1, 10);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (103, 2, 20);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (104, 2, 20);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (105, 3, 10);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (106, 3, 10);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (107, 4, 10);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (108, 5, 20);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (109, 5, 20);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (110, 5, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT event_id, product_name, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_in_event_id AS product_in_event_id, RHS.event_id AS event_id FROM products AS LHS INNER JOIN products_in_events AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY event_id, product_name) WHERE (n = 2) ORDER BY product_name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T1.Product_Name FROM Products AS T1 JOIN Products_in_Events AS T2 ON T1.Product_ID = T2.Product_ID GROUP BY T1.Product_Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Alpha',)
('Beta',)
('Delta',)
('Zeta',)
*/