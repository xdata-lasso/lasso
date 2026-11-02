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
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('1', '10 Main St', 'Apt 1', 'Boston', 'MA', 'HQ');
INSERT INTO "Addresses" ("Address_ID", "Line_1", "Line_2", "City_Town", "State_County", "Other_Details") VALUES ('2', '20 Oak Ave', NULL, 'Chicago', 'IL', 'Branch');
INSERT INTO "Marketing_Regions" ("Marketing_Region_Code", "Marketing_Region_Name", "Marketing_Region_Descriptrion", "Other_Details") VALUES ('US-E', 'US East', 'Eastern Region', NULL);
INSERT INTO "Marketing_Regions" ("Marketing_Region_Code", "Marketing_Region_Name", "Marketing_Region_Descriptrion", "Other_Details") VALUES ('US-MW', 'US Midwest', 'Midwest Region', NULL);
INSERT INTO "Clients" ("Client_ID", "Address_ID", "Customer_Email_Address", "Customer_Name", "Customer_Phone", "Other_Details") VALUES (1, 1, 'alice@client.com', 'Alice Smith', '555-0101', 'VIP');
INSERT INTO "Clients" ("Client_ID", "Address_ID", "Customer_Email_Address", "Customer_Name", "Customer_Phone", "Other_Details") VALUES (2, 2, 'bob@client.com', 'Bob Jones', '555-0102', 'Regular');
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (1, 1, 'USD', 'US-E', 'East Drama Group', '555-0201', 'east@drama.com', NULL);
INSERT INTO "Drama_Workshop_Groups" ("Workshop_Group_ID", "Address_ID", "Currency_Code", "Marketing_Region_Code", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES (2, 2, 'USD', 'US-MW', 'Midwest Drama Group', '555-0202', 'mw@drama.com', NULL);
INSERT INTO "Stores" ("Store_ID", "Marketing_Region_Code", "Address_ID", "Store_Name", "Store_Phone", "Store_Email_Address", "Other_Details") VALUES ('1', 'US-E', 1, 'Boston Store', '555-0301', 'boston@store.com', NULL);
INSERT INTO "Customers" ("Customer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES ('1', 1, 'Charlie Brown', '555-0401', 'charlie@cust.com', NULL);
INSERT INTO "Performers" ("Performer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES (1, 1, 'actor One', '555-0501', 'a1@perf.com', NULL);
INSERT INTO "Performers" ("Performer_ID", "Address_ID", "Customer_Name", "Customer_Phone", "Customer_Email_Address", "Other_Details") VALUES (2, 2, 'Actor Two', '555-0502', 'a2@perf.com', NULL);
INSERT INTO "Ref_Service_Types" ("Service_Type_Code", "Parent_Service_Type_Code", "Service_Type_Description") VALUES ('S1', NULL, 'Stage Lighting');
INSERT INTO "Services" ("Service_ID", "Service_Type_Code", "Workshop_Group_ID", "Product_Description", "Product_Name", "Product_Price", "Other_Product_Service_Details") VALUES (1, 'S1', 1, 'Full stage lighting', 'Lighting Pack', 250.0, NULL);
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (1, '1', 1, 'Confirmed', 1, '2023-05-15', '2023-01-10', '2023-09-01', 'First booking');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (2, '2', 2, 'Pending', 1, '2023-02-10', '2023-06-20', '2023-03-15', 'Second booking');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (3, '1', 2, 'Cancelled', 1, '2023-08-22', '2023-04-05', '2023-01-20', 'Third booking');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (4, '2', 1, 'Confirmed', 1, '2023-02-10', '2023-02-28', '2023-07-11', 'Duplicate order date');
INSERT INTO "Bookings" ("Booking_ID", "Workshop_Group_ID", "Customer_ID", "Status_Code", "Store_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (5, '1', 1, 'Confirmed', 1, '2023-01-05', '2023-12-01', '2023-05-05', 'Earliest order date');
INSERT INTO "Performers_in_Bookings" ("Order_ID", "Performer_ID") VALUES (1, 1);
INSERT INTO "Performers_in_Bookings" ("Order_ID", "Performer_ID") VALUES (1, 2);
INSERT INTO "Performers_in_Bookings" ("Order_ID", "Performer_ID") VALUES (2, 1);
INSERT INTO "Bookings_Services" ("Order_ID", "Product_ID") VALUES (1, 1);
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (1, 1, 1, '2020-10-10', '2020-10-15', '2020-10-16', 'Customer order 1');
INSERT INTO "Customer_Orders" ("Order_ID", "Store_ID", "Customer_ID", "Order_Date", "Planned_Delivery_Date", "Actual_Delivery_Date", "Other_Order_Details") VALUES (2, 1, 1, '2020-05-05', '2020-05-10', '2020-05-12', 'Customer order 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_date FROM bookings ORDER BY order_date, bookings.booking_id NULLS LAST;

/*
Gold Result:
('2023-01-05',)
('2023-02-10',)
('2023-02-10',)
('2023-05-15',)
('2023-08-22',)
*/

-- Prediction Query
SELECT Order_Date FROM BOOKINGS;

/*
Prediction Result:
('2023-05-15',)
('2023-02-10',)
('2023-08-22',)
('2023-02-10',)
('2023-01-05',)
*/