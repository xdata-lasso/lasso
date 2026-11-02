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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('34123 Andrea Estate
South Shannonfort, LA 04779', 'each', 'fight', 'Jacquelinemouth', 'California', 'right');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('274 Perry Orchard
Sanchezside, FL 50778', 'each', 'fight', 'Jacquelinemouth', 'California', 'right');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('east', 'Rachel Weber', 'recently', 'summer');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('while', 'Rachel Weber', 'recently', 'summer');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('world', 'Different chance enter central arrive society organization.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('decade', 'Tv keep light fight I evening music.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('large', 'Ball always it focus economy before.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('building', 'Onto again share start office several compare.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('thought', 'Onto again share start office several compare.');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('natural', '34123 Andrea Estate
South Shannonfort, LA 04779', 'Sydney White', '001-367-417-5655', 'robert74@example.net', 'you');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('will', '34123 Andrea Estate
South Shannonfort, LA 04779', 'Sydney White', '001-367-417-5655', 'robert74@example.net', 'you');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('institution', 'east', '34123 Andrea Estate
South Shannonfort, LA 04779', 'Krista Gibson', '945-916-8087x60385', 'harrisandrea@example.com', 'left');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('cut', 'east', '34123 Andrea Estate
South Shannonfort, LA 04779', 'Krista Gibson', '945-916-8087x60385', 'harrisandrea@example.com', 'left');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1110, 'institution', 'natural', '1987-10-07', '1991-03-11', '1995-07-15', 'politics');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1111, 'institution', 'natural', '1987-10-08', '1991-03-12', '1995-07-16', 'successful');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1112, 'institution', 'natural', '1987-10-09', '1991-03-13', '1995-07-17', 'education');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1113, 'institution', 'natural', '1987-10-10', '1991-03-14', '1995-07-18', 'security');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1126, 'institution', 'natural', '1987-10-10', '1991-03-14', '1995-07-18', 'security');
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1114, 'world', 1110, 1118, 'cold', 'old', 1122);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1115, 'world', 1110, 1127.0, 'foreign', 'involve', 1137.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1116, 'world', 1110, 1136.0, 'ok', 'better', 1152.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1117, 'world', 1110, 1145.0, 'address', 'down', 1167.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1127, 'world', 1110, 1145.0, 'address', 'down', 1167.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id FROM (SELECT * FROM (SELECT * FROM (SELECT invoice_id, order_id, payment_method_code, product_id, order_quantity, other_item_details, order_item_id, COUNT(*) OVER () AS n FROM invoices) ORDER BY n) LIMIT 1);

/*
Gold Result:
(1118,)
*/

-- Prediction Query
SELECT Product_ID FROM INVOICES GROUP BY Product_ID ORDER BY COUNT(*) DESC, Product_ID NULLS LAST LIMIT 1;

/*
Prediction Result:
(1145,)
*/