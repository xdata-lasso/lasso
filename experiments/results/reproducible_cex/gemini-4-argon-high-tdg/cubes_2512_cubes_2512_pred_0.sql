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
INSERT INTO Addresses (Address_ID, Line_1, City_Town) VALUES ('1', '10 Main St', 'Boston');
INSERT INTO Marketing_Regions (Marketing_Region_Code, Marketing_Region_Name) VALUES ('NA', 'North America');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name) VALUES ('1', 1, 'Alice');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name) VALUES ('2', 1, 'Bob');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name) VALUES ('3', 1, 'Charlie');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name) VALUES ('1', 'NA', 1, 'Store A');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name) VALUES ('2', 'NA', 1, 'Store B');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name) VALUES ('3', 'NA', 1, 'Store C');
INSERT INTO Products (Product_ID, Product_Name, Product_Price) VALUES ('1', 'Prod 1', 10.0);
INSERT INTO Products (Product_ID, Product_Name, Product_Price) VALUES ('2', 'Prod 2', 20.0);
INSERT INTO Products (Product_ID, Product_Name, Product_Price) VALUES ('3', 'Prod 3', 30.0);
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (1, 1, 1, '2023-01-01 00:00:00', '2023-01-02 00:00:00', '2023-09-09 00:00:00', 'Trap ID 1');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (10, 1, 2, '2023-01-03 00:00:00', '2023-01-05 00:00:00', '2023-03-10 00:00:00', 'Match C');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (20, 2, 3, '2023-01-05 00:00:00', '2023-01-08 00:00:00', '2023-01-10 00:00:00', 'Match A');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (30, 3, 1, '2023-01-01 00:00:00', '2023-02-20 00:00:00', '2023-02-10 00:00:00', 'Match B');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (40, 2, 2, '2023-01-02 00:00:00', '2023-01-04 00:00:00', '2023-01-05 00:00:00', 'Qty 0');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (50, 3, 3, '2023-01-04 00:00:00', '2023-01-06 00:00:00', '2023-04-01 00:00:00', 'Qty 10');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (1, 1, 1, '2', 'Trap item with ID 1 but qty 2');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (100, 3, 30, '1', 'Item for Match B');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (200, 1, 10, '1', 'Item for Match C');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (300, 2, 20, '1', 'Item for Match A');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (400, 2, 40, '0', 'Item with qty 0');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (500, 3, 50, '10', 'Item with qty 10');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (600, 1, 50, NULL, 'Item with NULL qty');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actual_delivery_date FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.store_id AS store_id, LHS.order_date AS order_date, LHS.planned_delivery_date AS planned_delivery_date, LHS.actual_delivery_date AS actual_delivery_date, LHS.other_order_details AS other_order_details, RHS.order_item_id AS order_item_id, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity, RHS.other_item_details AS other_item_details FROM customer_orders AS LHS INNER JOIN (SELECT * FROM order_items WHERE (order_quantity = 1)) AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY actual_delivery_date;

/*
Gold Result:
('2023-01-10 00:00:00',)
('2023-02-10 00:00:00',)
('2023-03-10 00:00:00',)
*/

-- Prediction Query
SELECT T1.Actual_Delivery_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID = T2.Order_ID WHERE T2.Order_Quantity = 1;

/*
Prediction Result:
('2023-02-10 00:00:00',)
('2023-03-10 00:00:00',)
('2023-01-10 00:00:00',)
*/