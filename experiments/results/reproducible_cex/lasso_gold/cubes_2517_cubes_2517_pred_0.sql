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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('3147 Karen Port Suite 507
Hunterborough, MI 34363', 'grow', 'far', 'Angelahaven', 'Illinois', 'bed');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('Unit 4990 Box 9133
DPO AA 87064', 'beat', 'close', 'East Andrea', 'Hawaii', 'able');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('effort', 'Katherine Chang', 'rock', 'maybe');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('issue', 'Kirk Carter', 'each', 'fight');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('race', 'Behavior develop reality.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('seek', 'Professional hard network gas you.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('military', 'Former reflect even edge building court build.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('line', 'Week real course school everybody operation set.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('seat', 'Reach under skin person.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('fear', 'Interesting name positive training step.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('scientist', 'Arrive society organization station.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('long', 'Keep light fight I evening.');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('picture', '3147 Karen Port Suite 507
Hunterborough, MI 34363', 'Brian Lee', '252.640.8240', 'danamullins@example.org', 'turn');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('notice', 'Unit 4990 Box 9133
DPO AA 87064', 'Bobby Williams MD', '994-601-3990x49027', 'wendygraham@example.com', 'benefit');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('actually', 'effort', '3147 Karen Port Suite 507
Hunterborough, MI 34363', 'Julie Alexander', '(204)471-1671', 'lisaavery@example.org', 'energy');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('many', 'issue', 'Unit 4990 Box 9133
DPO AA 87064', 'Gary Santiago', '(356)774-6807', 'marcus68@example.org', 'really');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1086, 'actually', 'picture', '1975-09-18', '1979-02-22', '1983-06-03', 'street');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1087, 'actually', 'picture', '1975-09-19', '1979-02-23', '1983-06-04', 'present');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1088, 'actually', 'picture', '1975-09-20', '1979-02-24', '1983-06-05', 'draw');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1089, 'actually', 'picture', '1975-09-21', '1979-02-25', '1983-06-06', 'stand');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1102, 'many', 'notice', '1987-10-07', '1991-03-11', '1995-07-15', 'national');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1103, 'many', 'notice', '1987-10-08', '1991-03-12', '1995-07-16', 'high');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1104, 'many', 'notice', '1987-10-09', '1991-03-13', '1995-07-17', 'prevent');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1105, 'many', 'notice', '1987-10-10', '1991-03-14', '1995-07-18', 'something');
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1106, 'race', 1086, 1128.0, 'necessary', 'level', 1099);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1091, 'race', 1086, 1103.0, 'husband', 'finish', 1113.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1092, 'race', 1086, 1112.0, 'little', 'trade', 1128.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1093, 'race', 1086, 1121.0, 'when', 'per', 1143.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1090, 'seat', 1102, 1137.0, 'moment', 'approach', 1098);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1107, 'seat', 1102, 1119.0, 'process', 'Democrat', 1129.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1108, 'seat', 1102, 1094, 'letter', 'example', 1144.0);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1109, 'seat', 1102, 1094, 'soon', 'often', 1159.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT * FROM (SELECT * FROM (SELECT invoice_id, order_id, payment_method_code, product_id, order_quantity, other_item_details, order_item_id, COUNT(*) OVER () AS n FROM invoices) ORDER BY product_id DESC) LIMIT 1);

/*
Gold Result:
('seat',)
*/

-- Prediction Query
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY COUNT(*) DESC, payment_method_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('race',)
*/