INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (1001, 'Allison Hill', 'ELECTRONICS');
INSERT INTO "products" ("product_id", "category_id", "product_name", "price", "stock_quantity") VALUES (1002, 1001, 'Brian Yang', 1003.5, 1004);
INSERT INTO "inventory_logs" ("log_id", "product_id", "change_type", "change_amount", "log_seq") VALUES (1005, 1002, 'RESTOCK', 0, 1006);
