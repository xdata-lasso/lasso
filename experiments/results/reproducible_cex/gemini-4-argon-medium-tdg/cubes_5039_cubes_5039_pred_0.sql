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
-- Tests standard grouping with multiple products, ties for maximum count, and a lower count.
-- Also tests confusion between Invoices and Order_Items / Invoice_Items / Products.
-- Also tests COUNT(*) vs SUM(Order_Quantity).
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price") VALUES ('10', 'Prod A', 10.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price") VALUES ('20', 'Prod B', 20.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price") VALUES ('30', 'Prod C', 30.0);
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price") VALUES ('40', 'Prod D', 40.0);
INSERT INTO "Customer_Orders" ("Order_ID", "Order_Date") VALUES (1, '2023-01-01');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity") VALUES (1, 40, 1, '1');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity") VALUES (2, 40, 1, '1');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity") VALUES (3, 40, 1, '1');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity") VALUES (4, 40, 1, '1');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity") VALUES (5, 40, 1, '1');
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (1, 1, 10, '5', 1);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (2, 1, 10, '5', 1);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (3, 1, 10, '5', 2);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (4, 1, 20, '2', 3);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (5, 1, 20, '2', 4);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (6, 1, 20, '2', 5);
INSERT INTO "Invoices" ("Invoice_ID", "Order_ID", "Product_ID", "Order_Quantity", "Order_Item_ID") VALUES (7, 1, 30, '100', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(n) OVER () AS product_id FROM (SELECT product_id, COUNT(*) AS n FROM invoices GROUP BY product_id) ORDER BY product_id;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT Product_ID FROM INVOICES GROUP BY Product_ID ORDER BY COUNT(*) DESC, Product_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/