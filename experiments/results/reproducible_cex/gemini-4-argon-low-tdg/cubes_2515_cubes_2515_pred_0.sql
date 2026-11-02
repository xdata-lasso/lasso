-- Schema DDL
CREATE TABLE "Ref_Payment_Methods" ("payment_method_code" TEXT(10) PRIMARY KEY, "payment_method_description" TEXT(80));

CREATE TABLE "Ref_Service_Types" ("Service_Type_Code" TEXT(15) PRIMARY KEY, "Parent_Service_Type_Code" TEXT(15), "Service_Type_Description" TEXT(255));

CREATE TABLE "Addresses" ("Address_ID" TEXT(100) PRIMARY KEY, "Line_1" TEXT(255), "Line_2" TEXT(255), "City_Town" TEXT(255), "State_County" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Products" ("Product_ID" TEXT(100) PRIMARY KEY, "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Product_Description" TEXT(255), "Other_Product_Service_Details" TEXT(255));

CREATE TABLE "Marketing_Regions" ("Marketing_Region_Code" TEXT(15) PRIMARY KEY, "Marketing_Region_Name" TEXT(255), "Marketing_Region_Descriptrion" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Clients" ("Client_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Email_Address" TEXT(255), "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Drama_Workshop_Groups" ("Workshop_Group_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Currency_Code" TEXT(15), "Marketing_Region_Code" TEXT(15), "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Performers" ("Performer_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Customers" ("Customer_ID" TEXT(100) PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Stores" ("Store_ID" TEXT(100) PRIMARY KEY, "Marketing_Region_Code" TEXT(15), "Address_ID" INTEGER, "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Marketing_Region_Code") REFERENCES "Marketing_Regions" ("Marketing_Region_Code"), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Bookings" ("Booking_ID" INTEGER PRIMARY KEY, "Workshop_Group_ID" TEXT(100), "Customer_ID" INTEGER, "Status_Code" TEXT(15), "Store_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Clients" ("Client_ID"));

CREATE TABLE "Performers_in_Bookings" ("Order_ID" INTEGER, "Performer_ID" INTEGER, PRIMARY KEY ("Order_ID", "Performer_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"), FOREIGN KEY ("Performer_ID") REFERENCES "Performers" ("Performer_ID"));

CREATE TABLE "Customer_Orders" ("Order_ID" INTEGER PRIMARY KEY, "Store_ID" INTEGER, "Customer_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Store_ID") REFERENCES "Stores" ("Store_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Order_Items" ("Order_Item_ID" INTEGER PRIMARY KEY, "Product_ID" INTEGER, "Order_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), FOREIGN KEY ("Product_ID") REFERENCES "Products" ("Product_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Invoices" ("Invoice_ID" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "Order_ID" INTEGER, "Product_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), "Order_Item_ID" INTEGER, FOREIGN KEY ("payment_method_code") REFERENCES "Ref_Payment_Methods" ("payment_method_code"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15), "Workshop_Group_ID" INTEGER, "Product_Description" TEXT(255), "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Other_Product_Service_Details" TEXT(255), FOREIGN KEY ("Service_Type_Code") REFERENCES "Ref_Service_Types" ("Service_Type_Code"), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"));

CREATE TABLE "Bookings_Services" ("Order_ID" INTEGER UNIQUE, "Product_ID" INTEGER UNIQUE, PRIMARY KEY ("Order_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Services" ("Service_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"));

CREATE TABLE "Invoice_Items" ("Invoice_Item_ID" INTEGER PRIMARY KEY, "Order_ID" INTEGER, "Product_ID" INTEGER, "Invoice_ID" INTEGER, "Order_Item_ID" INTEGER, "Order_Quantity" INTEGER, "Other_Item_Details" TEXT(255), FOREIGN KEY ("Order_ID") REFERENCES "Bookings_Services" ("Order_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Bookings_Services" ("Product_ID"), FOREIGN KEY ("Invoice_ID") REFERENCES "Invoices" ("Invoice_ID"), FOREIGN KEY ("Order_Item_ID") REFERENCES "Order_Items" ("Order_Item_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard composite GROUP BY (product_description, product_name), AVG calculation (vs SUM/MIN/MAX/COUNT), and two-level ORDER BY (product_name, avg_product_price_).
-- Also ensures Services table has different data to kill mutants querying the wrong table.
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P1', 'Spotlight', 100.0, 'LED', 'Det1');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P2', 'Spotlight', 200.0, 'LED', 'Det2');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P3', 'Spotlight', 50.0, 'Halogen', 'Det3');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P4', 'Cable', 300.0, 'XLR', 'Det4');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P5', 'Cable', 10.0, 'DMX', 'Det5');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('P6', 'Mic', 400.0, 'XLR', 'Det6');
INSERT INTO "Addresses" ("Address_ID", "Line_1") VALUES ('A1', '123 Main St');
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Service_Type_Description") VALUES ('S1', 'Lighting');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Store_Name") VALUES (1, 'A1', 'Group 1');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price") VALUES (1, 'S1', 1, 'ServiceDesc', 'ServiceProd', 999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, meanproduct_price AS avg_product_price_ FROM (SELECT product_description, product_name, AVG(product_price) AS meanproduct_price FROM products GROUP BY product_description, product_name) ORDER BY product_name, avg_product_price_ NULLS LAST;

/*
Gold Result:
('Cable', 10.0)
('Cable', 300.0)
('Mic', 400.0)
('Spotlight', 50.0)
('Spotlight', 150.0)
*/

-- Prediction Query
SELECT Product_Name, AVG(Product_Price) FROM PRODUCTS GROUP BY Product_Name;

/*
Prediction Result:
('Cable', 155.0)
('Mic', 400.0)
('Spotlight', 116.66666666666667)
*/