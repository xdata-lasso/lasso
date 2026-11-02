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
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1017, 'sense', 'Kimberly Robinson', 1021.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1018, 'sense', 'Kimberly Robinson', 1030.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1019, 'sense', 'Kimberly Robinson', 1039.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1020, 'sense', 'Kimberly Robinson', 1048.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1025, 'perform', 'Sean Blake', 1029.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1026, 'perform', 'Sean Blake', 1038.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1027, 'perform', 'Sean Blake', 1047.5);
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1028, 'perform', 'Sean Blake', 1056.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT product_name, product_type_code, MAX(n) AS n FROM (SELECT product_name, product_type_code, COUNT(*) AS n FROM products GROUP BY product_name, product_type_code) GROUP BY product_name, product_type_code) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
('sense',)
*/

-- Prediction Query
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code ORDER BY COUNT(*) DESC, Product_Type_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('perform',)
*/