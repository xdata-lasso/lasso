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
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('PM1', 'Credit Card');
INSERT INTO Ref_Payment_Methods (payment_method_code, payment_method_description) VALUES ('PM2', 'Bank Transfer');
INSERT INTO Addresses (Address_ID, Line_1, Line_2, City_Town, State_County, Other_Details) VALUES ('1', '10 Main St', 'Apt 1', 'Metropolis', 'Metro', 'None');
INSERT INTO Marketing_Regions (Marketing_Region_Code, Marketing_Region_Name, Marketing_Region_Descriptrion, Other_Details) VALUES ('MR1', 'North', 'Northern Region', 'None');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name, Customer_Phone, Customer_Email_Address, Other_Details) VALUES ('1', 1, 'Alice Smith', '555-0101', 'alice@example.com', 'None');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name, Store_Phone, Store_Email_Address, Other_Details) VALUES ('1', 'MR1', 1, 'Main Store', '555-0202', 'store@example.com', 'None');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('101', 'Stage Light', 150.0, 'LED Stage Light', 'None');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('102', 'Microphone', 80.0, 'Wireless Mic', 'None');
INSERT INTO Products (Product_ID, Product_Name, Product_Price, Product_Description, Other_Product_Service_Details) VALUES ('103', 'Costume Prop', 45.0, 'Vintage Hat', 'None');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (1, 1, 1, '2023-01-01', '2023-01-05', '2023-01-04', 'First Order');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (2, 1, 1, '2023-01-02', '2023-01-06', '2023-01-06', 'Second Order');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (1, 101, 1, '10', 'Item 1');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (2, 102, 1, '20', 'Item 2');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (3, 103, 2, '30', 'Item 3');
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (1, 'PM1', 1, 101, '10', 'Inv 1', 1);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (2, 'PM1', 1, 102, '15', 'Inv 2', 2);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (3, 'PM2', 1, 102, '25', 'Inv 3', 2);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (4, 'PM1', 2, 102, '35', 'Inv 4', 2);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (5, 'PM2', 2, 102, '45', 'Inv 5', 2);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (6, 'PM1', 2, 103, '50', 'Inv 6', 3);
INSERT INTO Invoices (Invoice_ID, payment_method_code, Order_ID, Product_ID, Order_Quantity, Other_Item_Details, Order_Item_ID) VALUES (7, 'PM2', 2, 103, '60', 'Inv 7', 3);
INSERT INTO Ref_Service_Types (Service_Type_Code, Parent_Service_Type_Code, Service_Type_Description) VALUES ('ST1', 'ST1', 'Coaching');
INSERT INTO Clients (Client_ID, Address_ID, Customer_Email_Address, Customer_Name, Customer_Phone, Other_Details) VALUES (1, 1, 'client@example.com', 'Bob Client', '555-0303', 'None');
INSERT INTO Drama_Workshop_Groups (Workshop_Group_ID, Address_ID, Currency_Code, Marketing_Region_Code, Store_Name, Store_Phone, Store_Email_Address, Other_Details) VALUES (1, 1, 'USD', 'MR1', 'Workshop A', '555-0404', 'ws@example.com', 'None');
INSERT INTO Bookings (Booking_ID, Workshop_Group_ID, Customer_ID, Status_Code, Store_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (1, '1', 1, 'CONF', 1, '2023-01-01', '2023-01-10', '2023-01-10', 'Booking 1');
INSERT INTO Services (Service_ID, Service_Type_Code, Workshop_Group_ID, Product_Description, Product_Name, Product_Price, Other_Product_Service_Details) VALUES (201, 'ST1', 1, 'Acting Service', 'Acting', 200.0, 'None');
INSERT INTO Bookings_Services (Order_ID, Product_ID) VALUES (1, 201);
INSERT INTO Invoice_Items (Invoice_Item_ID, Order_ID, Product_ID, Invoice_ID, Order_Item_ID, Order_Quantity, Other_Item_Details) VALUES (1, 1, 201, 1, 1, 5, 'II 1');
INSERT INTO Invoice_Items (Invoice_Item_ID, Order_ID, Product_ID, Invoice_ID, Order_Item_ID, Order_Quantity, Other_Item_Details) VALUES (2, 1, 201, 2, 2, 5, 'II 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(n) OVER () AS product_id FROM (SELECT product_id, COUNT(*) AS n FROM invoices GROUP BY product_id) ORDER BY product_id;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT Product_ID FROM INVOICES GROUP BY Product_ID ORDER BY COUNT(*) DESC, Product_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(102,)
*/