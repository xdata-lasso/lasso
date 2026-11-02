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
-- DATASET 2
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('VALID_PM', 'Valid Match');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('RHS_PM', 'RHS Partner');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('TRAP_C1', 'Only First Conjunct');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('TRAP_C2', 'Only Second Conjunct');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('TRAP_PLHS', 'Pushed Projection LHS');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('TRAP_PBOTH', 'Pushed Projection Both');
INSERT INTO Addresses (Address_ID, Line_1, Line_2, City_Town, State_County, Other_Details) VALUES ('1', '10 Main St', 'Suite 1', 'Boston', 'MA', 'HQ');
INSERT INTO Marketing_Regions (Marketing_Region_Code, Marketing_Region_Name, Marketing_Region_Descriptrion, Other_Details) VALUES ('NA', 'North America', 'NA Region', 'None');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name, Customer_Phone, Customer_Email_Address, Other_Details) VALUES ('1', 1, 'Alice', '555-0101', 'alice@example.com', 'VIP');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name, Store_Phone, Store_Email_Address, Other_Details) VALUES ('1', 'NA', 1, 'Main Store', '555-0102', 'store@example.com', 'Open');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (101, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O101');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (102, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O102');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (201, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O201');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (202, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O202');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (301, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O301');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (302, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O302');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (401, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O401');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (402, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O402');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (601, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O601');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (602, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'O602');
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (1, 'VALID_PM', 101, 501, '1', 'Valid LHS', 102);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (2, 'RHS_PM', 102, 101, '1', 'Valid RHS', 502);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (3, 'TRAP_C1', 201, 503, '1', 'Trap C1 LHS', 999);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (4, 'RHS_PM', 202, 201, '1', 'Trap C1 RHS', 504);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (5, 'TRAP_C2', 301, 505, '1', 'Trap C2 LHS', 302);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (6, 'RHS_PM', 302, 888, '1', 'Trap C2 RHS', 506);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (7, 'TRAP_PLHS', 401, 507, '1', 'Trap Push LHS', 402);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (8, 'RHS_PM', 402, 402, '1', 'Trap Push LHS RHS', 508);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (9, 'TRAP_PBOTH', 601, 509, '1', 'Trap Push Both LHS', 602);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (10, 'RHS_PM', 602, 777, '1', 'Trap Push Both RHS', 602);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method_code FROM (SELECT order_quantity, payment_method_code, MAX(n) AS n FROM (SELECT order_quantity, payment_method_code, COUNT(*) AS n FROM (SELECT invoice_id, order_item_id AS order_id, payment_method_code, product_id, order_quantity, other_item_details, order_item_id, invoice_id_other, payment_method_code_other, order_quantity_other, other_item_details_other, order_item_id_other FROM (SELECT invoice_id, order_id, payment_method_code, order_id AS product_id, order_quantity, other_item_details, order_item_id, invoice_id_other, payment_method_code_other, order_quantity_other, other_item_details_other, order_item_id_other FROM (SELECT LHS.invoice_id AS invoice_id, LHS.order_id AS order_id, LHS.payment_method_code AS payment_method_code, LHS.product_id AS product_id, LHS.order_quantity AS order_quantity, LHS.other_item_details AS other_item_details, LHS.order_item_id AS order_item_id, RHS.invoice_id AS invoice_id_other, RHS.payment_method_code AS payment_method_code_other, RHS.order_quantity AS order_quantity_other, RHS.other_item_details AS other_item_details_other, RHS.order_item_id AS order_item_id_other FROM invoices AS LHS INNER JOIN invoices AS RHS ON (LHS.order_id = RHS.product_id AND LHS.order_item_id = RHS.order_id)))) GROUP BY order_quantity, payment_method_code) GROUP BY order_quantity, payment_method_code) ORDER BY payment_method_code;

/*
Gold Result:
('VALID_PM',)
*/

-- Prediction Query
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY COUNT(*) DESC, payment_method_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('RHS_PM',)
*/