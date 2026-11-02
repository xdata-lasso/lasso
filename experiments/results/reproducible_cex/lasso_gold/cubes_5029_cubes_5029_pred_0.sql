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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('808 Huynh Cove Apt. 411
West Juan, IL 94559', 'gun', 'Democrat', 'Williamview', 'Arkansas', 'best');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('5414 May Locks
Sheilaville, FM 34738', 'could', 'partner', 'Benjaminchester', 'Minnesota', 'shoulder');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('protect', 'Donald Smith', 'spend', 'case');
INSERT INTO "marketing_regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('stop', 'Larry Dixon', 'image', 'we');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('public', 'Claim kind relationship night born.');
INSERT INTO "ref_payment_methods" ("payment_method_code", "payment_method_description") VALUES ('part', 'Effort remember ability understand Mrs.');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('you', '808 Huynh Cove Apt. 411
West Juan, IL 94559', 'Stephanie Gardner', '(598)326-2045x053', 'kimberly69@example.net', 'clear');
INSERT INTO "customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('serve', '5414 May Locks
Sheilaville, FM 34738', 'Nancy Gonzalez', '(415)595-1484x65648', 'yortega@example.net', 'smile');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('wish', 'protect', '808 Huynh Cove Apt. 411
West Juan, IL 94559', 'Sharon Cherry', '(360)825-6342', 'garrisonjeffrey@example.com', 'hard');
INSERT INTO "stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('weight', 'stop', '5414 May Locks
Sheilaville, FM 34738', 'Keith Sullivan', '9449369957', 'williamleon@example.net', 'condition');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1026, 'wish', 'you', '1982-02-13', '1983-03-14', '1984-04-15', 'focus');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1032, 'weight', 'serve', '1985-05-16', '1986-06-17', '1987-07-18', 'reason');
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1029, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "customer_orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (1035, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1027, 'public', 1026, 1028, 'tend', 'stuff', 1029);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1030, 'public', 1029, 1026, 'try', 'drive', 1031);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1033, 'part', 1032, 1034, 'become', 'federal', 1035);
INSERT INTO "invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (1036, 'part', 1035, 1032, 'myself', 'record', 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method_code FROM (SELECT order_quantity, payment_method_code, MAX(n) AS n FROM (SELECT order_quantity, payment_method_code, COUNT(*) AS n FROM (SELECT invoice_id, order_item_id AS order_id, payment_method_code, product_id, order_quantity, other_item_details, order_item_id, invoice_id_other, payment_method_code_other, order_quantity_other, other_item_details_other, order_item_id_other FROM (SELECT invoice_id, order_id, payment_method_code, order_id AS product_id, order_quantity, other_item_details, order_item_id, invoice_id_other, payment_method_code_other, order_quantity_other, other_item_details_other, order_item_id_other FROM (SELECT LHS.invoice_id AS invoice_id, LHS.order_id AS order_id, LHS.payment_method_code AS payment_method_code, LHS.product_id AS product_id, LHS.order_quantity AS order_quantity, LHS.other_item_details AS other_item_details, LHS.order_item_id AS order_item_id, RHS.invoice_id AS invoice_id_other, RHS.payment_method_code AS payment_method_code_other, RHS.order_quantity AS order_quantity_other, RHS.other_item_details AS other_item_details_other, RHS.order_item_id AS order_item_id_other FROM invoices AS LHS INNER JOIN invoices AS RHS ON (LHS.order_id = RHS.product_id AND LHS.order_item_id = RHS.order_id)))) GROUP BY order_quantity, payment_method_code) GROUP BY order_quantity, payment_method_code) ORDER BY payment_method_code;

/*
Gold Result:
('part',)
('public',)
*/

-- Prediction Query
SELECT payment_method_code FROM INVOICES GROUP BY payment_method_code ORDER BY COUNT(*) DESC, payment_method_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('part',)
*/