INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (1001, 'Allison Hill', 'ELECTRONICS');
INSERT INTO "customers" ("customer_id", "customer_name", "country", "tier", "credit_limit") VALUES (1002, 'Brian Yang', 'Mayotte', 'BRONZE', 1003.5);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "total_amount") VALUES (1004, 1002, 'performance', 'PENDING', 1005.5);
INSERT INTO "products" ("product_id", "category_id", "product_name", "price", "stock_quantity") VALUES (1006, 1001, 'Brandon Hall', 1007.5, 1008);
INSERT INTO "order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price", "discount") VALUES (1009, 1004, 1006, 1, 1010.5, 0);
