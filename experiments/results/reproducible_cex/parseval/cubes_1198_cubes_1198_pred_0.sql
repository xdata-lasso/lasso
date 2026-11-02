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
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483648, 'pro_c891a1', 'pro_1ecfa7', 0.0001);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483647, 'pro_c891a1', 'pro_1ecfa7', 0.0002);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483646, 'pro_c891a1', 'pro_1ecfa7', 0.0003);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (2, 'pro_c891a1', 'pro_1ecfa7', 0.0004);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (3, 'pro_c891a1', 'pro_1ecfa7', 0.0005);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483645, 'pro_c891a1', 'pro_1ecfa7', 0.0006);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483642, 'pro_c891a1', 'pro_1ecfa7', 0.0007);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483641, 'pro_c891a1', 'pro_1ecfa7', 0.0008);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483640, 'pro_c891a1', 'pro_1ecfa7', 0.0009);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483639, 'pro_c891a1', 'pro_1ecfa7', 0.001);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483638, 'pro_c891a1', 'pro_1ecfa7', 0.0011);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483637, 'pro_c891a1', 'pro_1ecfa7', 0.0012);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483636, NULL, 'pro_1ecfa7', 0.0013);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483635, NULL, 'pro_1ecfa7', 0.0014);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483634, NULL, 'pro_1ecfa7', 0.0015);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (5, 'pro_6dbf78', 'pro_1ecfa7', 0.0016);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (4, 'pro_6dbf78', 'pro_1ecfa7', 0.0017);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (6, 'pro_fab1c1', 'pro_1ecfa7', 0.0018);

INSERT INTO "products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (-2147483630, 'pro_9d9fd0', 'pro_1ecfa7', 0.0019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_type_code FROM (SELECT product_id, product_type_code, product_name, product_price, COUNT(*) OVER () AS n FROM products) WHERE (n >= 2) ORDER BY product_type_code;

/*
Gold Result:
(None,)
('pro_6dbf78',)
('pro_9d9fd0',)
('pro_c891a1',)
('pro_fab1c1',)
*/

-- Prediction Query
SELECT Product_Type_Code FROM Products GROUP BY Product_Type_Code HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('pro_6dbf78',)
('pro_c891a1',)
*/