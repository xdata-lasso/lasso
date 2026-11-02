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
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('DEBIT', 'Debit Card');
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('CASH', 'Cash Payment');
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('CREDIT', 'Credit Card');
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('1', '10 Main St', 'Apt 1', 'Boston', 'MA', 'None');
INSERT INTO "Marketing_Regions" ("Marketing_Region_Code", "Marketing_Region_Name", "Marketing_Region_Descriptrion", "Other_Details") VALUES ('US-E', 'US East', 'Eastern Region', 'None');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('1', 1, 'Alice', '111-2222', 'alice@example.com', 'Regular');
INSERT INTO "Stores" ("Store_ID", "Marketing_Region_Code", "Address_ID", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES ('1', 'US-E', 1, 'East Store', '333-4444', 'store@example.com', 'Main');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (10, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'First');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (20, 1, 1, '2023-01-02', '2023-01-06', '2023-01-05', 'Middle');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (30, 1, 1, '2023-01-03', '2023-01-07', '2023-01-06', 'Last');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('10', 'A_Product', 5.00, 'Low ID', 'None');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('20', 'B_Product', 999.00, 'High Price', 'None');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('50', 'C_Product', 25.00, 'Mid ID', 'None');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('80', 'Z_Product', 500.00, 'Lexicographically High ID', 'None');
INSERT INTO "Products" ("Product_ID", "Product_Name", "Product_Price", "Product_Description", "Other_Product_Service_Details") VALUES ('100', 'M_Product', 50.00, 'Numerically Highest ID', 'None');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (100, 10, 10, '10', 'D1');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (200, 80, 30, '99', 'D2');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (300, 100, 20, '25', 'D3');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (400, 80, 10, '100', 'D4');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (500, 50, 20, '5', 'D5');
INSERT INTO "Order_Items" ("Order_Item_ID", "Product_ID", "Order_ID", "Order_Quantity", "Other_Item_Details") VALUES (600, 20, 30, '50', 'D6');
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (1, 'DEBIT', 10, 10, '10', 'Z_Detail', 100);
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (2, 'CASH', 30, 80, '99', 'A_Detail', 200);
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (3, 'CREDIT', 20, 100, '25', 'M_Detail', 300);
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (4, 'CASH', 10, 80, '100', 'B_Detail', 400);
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (5, 'CREDIT', 20, 50, '5', 'C_Detail', 500);
INSERT INTO "Invoices" ("Invoice_ID", "payment_method_code", "Order_ID", "Product_ID", "Order_Quantity", "Other_Item_Details", "Order_Item_ID") VALUES (6, 'CASH', 30, 20, '50', 'D_Detail', 600);
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('SVC1', 'SVC1', 'General Service');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (1, 1, 'USD', 'US-E', 'Group 1', '555-6666', 'group@example.com', 'None');
INSERT INTO "Clients" ("Client_ID", "Address_ID", "Customer_Email_Address", "Customer_Name", "Customer_Phone", "Other_Details") VALUES (1, 1, 'client@example.com', 'Client One', '777-8888', 'None');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (10, '1', 1, 'OK', 1, '2023-01-01', '2023-01-05', '2023-01-04', 'B1');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (20, '1', 1, 'OK', 1, '2023-01-02', '2023-01-06', '2023-01-05', 'B2');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (30, '1', 1, 'OK', 1, '2023-01-03', '2023-01-07', '2023-01-06', 'B3');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (10, 'SVC1', 1, 'Desc 10', 'A_Svc', 5.00, 'None');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (80, 'SVC1', 1, 'Desc 80', 'Z_Svc', 500.00, 'None');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (100, 'SVC1', 1, 'Desc 100', 'M_Svc', 50.00, 'None');
INSERT INTO "Bookings_Services" ("Order_ID", "Product_ID") VALUES (10, 10);
INSERT INTO "Bookings_Services" ("Order_ID", "Product_ID") VALUES (30, 80);
INSERT INTO "Bookings_Services" ("Order_ID", "Product_ID") VALUES (20, 100);
INSERT INTO "Invoice_Items" ("Invoice_Item_ID", "Order_ID", "Product_ID", "Invoice_ID", "Order_Item_ID", "Order_Quantity", "Other_Item_Details") VALUES (1, 10, 10, 1, 100, 10, 'II1');
INSERT INTO "Invoice_Items" ("Invoice_Item_ID", "Order_ID", "Product_ID", "Invoice_ID", "Order_Item_ID", "Order_Quantity", "Other_Item_Details") VALUES (2, 30, 80, 2, 200, 99, 'II2');
INSERT INTO "Invoice_Items" ("Invoice_Item_ID", "Order_ID", "Product_ID", "Invoice_ID", "Order_Item_ID", "Order_Quantity", "Other_Item_Details") VALUES (3, 20, 100, 3, 300, 25, 'II3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT invoice_id, order_id, payment_method_code, product_id, order_quantity, other_item_details, order_item_id, COUNT(*) OVER () AS n FROM invoices) ORDER BY product_id DESC) LIMIT 1);

/*
Gold Result:
('CREDIT',)
*/

-- Prediction Query
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY COUNT(*) DESC, payment_method_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('CASH',)
*/