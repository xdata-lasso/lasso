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
INSERT INTO Addresses (Address_ID, Line_1, City_Town) VALUES ('1', '123 Main St', 'Metropolis');
INSERT INTO Marketing_Regions (Marketing_Region_Code, Marketing_Region_Name) VALUES ('MR1', 'North');
INSERT INTO Stores (Store_ID, Marketing_Region_Code, Address_ID, Store_Name) VALUES ('1', 'MR1', 1, 'Main Store');
INSERT INTO Customers (Customer_ID, Address_ID, Customer_Name) VALUES ('1', 1, 'Alice');
INSERT INTO Products (Product_ID, Product_Name, Product_Price) VALUES ('1', 'Widget A', 10.0), ('2', 'Widget B', 20.0);
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (10, 1, 1, '2023-05-01', '2023-05-05', '2023-05-10', 'Order 10');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (20, 1, 1, '2023-01-01', '2023-01-05', '2023-01-02', 'Order 20');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (30, 1, 1, '2023-03-01', '2023-03-05', '2023-03-15', 'Order 30');
INSERT INTO Customer_Orders (Order_ID, Store_ID, Customer_ID, Order_Date, Planned_Delivery_Date, Actual_Delivery_Date, Other_Order_Details) VALUES (40, 1, 1, '2023-04-01', '2023-04-05', '2023-04-10', 'Order 40');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (101, 1, 10, '1', 'Valid qty 1');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (102, 2, 10, '2', 'Invalid qty 2');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (103, 1, 20, '1', 'Valid qty 1 - item 1');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (104, 2, 20, '1', 'Valid qty 1 - item 2');
INSERT INTO Order_Items (Order_Item_ID, Product_ID, Order_ID, Order_Quantity, Other_Item_Details) VALUES (105, 1, 30, '0', 'Invalid qty 0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actual_delivery_date FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.store_id AS store_id, LHS.order_date AS order_date, LHS.planned_delivery_date AS planned_delivery_date, LHS.actual_delivery_date AS actual_delivery_date, LHS.other_order_details AS other_order_details, RHS.order_item_id AS order_item_id, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity, RHS.other_item_details AS other_item_details FROM customer_orders AS LHS INNER JOIN (SELECT * FROM order_items WHERE (order_quantity = 1)) AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY actual_delivery_date;

/*
Gold Result:
('2023-01-02',)
('2023-01-02',)
('2023-05-10',)
*/

-- Prediction Query
SELECT T1.Actual_Delivery_Date FROM Customer_Orders AS T1 JOIN ORDER_ITEMS AS T2 ON T1.Order_ID = T2.Order_ID WHERE T2.Order_Quantity = 1;

/*
Prediction Result:
('2023-05-10',)
('2023-01-02',)
('2023-01-02',)
*/