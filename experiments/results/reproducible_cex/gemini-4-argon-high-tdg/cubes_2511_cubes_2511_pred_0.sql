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
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('1', '10 Main St', 'Apt 1', 'Springfield', 'IL', 'Primary');
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('2', '20 Oak Ave', NULL, 'Shelbyville', 'IL', 'Secondary');
INSERT INTO "Marketing_Regions" ("Marketing_Region_Code", "Marketing_Region_Name", "Marketing_Region_Descriptrion", "Other_Details") VALUES ('US-N', 'North', 'Northern Region', NULL);
INSERT INTO "Stores" ("Store_ID", "Marketing_Region_Code", "Address_ID", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES ('1', 'US-N', 1, 'Main Store', '555-0000', 'store@example.com', NULL);
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('2', 1, 'Harold', '555-0200', 'harold_two@example.com', 'Regular');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('3', NULL, 'Harold', '555-0100', 'a_harold@example.com', 'No address or orders');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('1', 1, 'Harold', '555-0100', 'z_harold@example.com', 'Has multiple orders');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('4', 2, 'Alice', '555-0050', 'alice@example.com', 'Harold');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('5', 1, 'Harold Smith', '555-0010', 'hsmith@example.com', 'Prefix match trap');
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('6', 1, 'harold', '555-0020', 'lowercase@example.com', 'Case sensitivity trap');
INSERT INTO "Clients" ("Client_ID", "Address_ID", "Customer_Email_Address", "Customer_Name", "Customer_Phone", "Other_Details") VALUES (1, 1, 'client_harold@example.com', 'Harold', '555-9999', 'Wrong table trap');
INSERT INTO "Performers" ("Performer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES (1, 1, 'Harold', '555-8888', 'perf_harold@example.com', 'Wrong table trap');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (101, 1, 1, '2023-01-01 10:00:00', '2023-01-05 10:00:00', '2023-01-04 10:00:00', 'First order');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (102, 1, 1, '2023-01-02 10:00:00', '2023-01-06 10:00:00', '2023-01-06 10:00:00', 'Second order');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (103, 1, 2, '2023-01-03 10:00:00', '2023-01-07 10:00:00', '2023-01-07 10:00:00', 'Third order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_phone", "customer_email_address" FROM "customers" WHERE ("customer_name" = 'Harold') ORDER BY customer_phone, customers.customer_id NULLS LAST;

/*
Gold Result:
('555-0100', 'z_harold@example.com')
('555-0100', 'a_harold@example.com')
('555-0200', 'harold_two@example.com')
*/

-- Prediction Query
SELECT Customer_Phone, Customer_Email_Address FROM CUSTOMERS WHERE Customer_Name = 'Harold';

/*
Prediction Result:
('555-0200', 'harold_two@example.com')
('555-0100', 'a_harold@example.com')
('555-0100', 'z_harold@example.com')
*/