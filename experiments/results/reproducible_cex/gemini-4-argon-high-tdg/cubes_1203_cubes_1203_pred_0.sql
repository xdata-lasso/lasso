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
INSERT INTO Locations (Location_ID, Other_Details) VALUES (1, 'North Wing');
INSERT INTO Channels (Channel_ID, Other_Details) VALUES (1, 'Online');
INSERT INTO Finances (Finance_ID, Other_Details) VALUES (1, 'Standard');
INSERT INTO Parties (Party_ID, Party_Details) VALUES (1, 'John Doe');
INSERT INTO Assets (Asset_ID, Other_Details) VALUES (1, 'Projector');
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (1, 'A_TYPE', 'Alpha', 999.99);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (2, 'A_TYPE', 'Beta', 100.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (3, 'B_TYPE', 'Gamma', 200.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (4, 'B_TYPE', 'Delta', 200.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (5, 'C_TYPE', 'Epsilon', 1.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (6, 'Z_TYPE', 'Item6', 50.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (7, 'Z_TYPE', 'Item7', 50.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (8, 'Z_TYPE', 'Item8', 50.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (9, 'B_TYPE', 'Theta', 200.00);
INSERT INTO Products (Product_ID, Product_Type_Code, Product_Name, Product_Price) VALUES (10, 'B_TYPE', 'Zeta', 200.00);
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (1, 1, 1, 1, 1, 'EVT_X');
INSERT INTO Events (Event_ID, Finance_ID, Address_ID, Location_ID, Channel_ID, Event_Type_Code) VALUES (2, 1, 1, 1, 1, 'EVT_Y');
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (1, 1, 1);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (2, 1, 2);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (3, 2, 1);
INSERT INTO Products_in_Events (Product_in_Event_ID, Product_ID, Event_ID) VALUES (4, 3, 1);
INSERT INTO Parties_in_Events (Party_ID, Event_ID, Role_Code) VALUES (1, 1, 'ROLE_W');
INSERT INTO Agreements (Document_ID, Event_ID) VALUES (1, 1);
INSERT INTO Assets_in_Events (Asset_ID, Event_ID) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT product_id, product_type_code, COUNT(*) AS n FROM products GROUP BY product_id, product_type_code) ORDER BY product_type_code DESC) LIMIT 1);

/*
Gold Result:
('Z_TYPE',)
*/

-- Prediction Query
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code ORDER BY COUNT(*) DESC, Product_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('B_TYPE',)
*/