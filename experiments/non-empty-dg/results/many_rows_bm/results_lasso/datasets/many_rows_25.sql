INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (1001, 'Allison Hill', 'ELECTRONICS');
INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (1002, 'Noah Rhodes', 'ELECTRONICS');
INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (1003, 'Angie Henderson', 'ELECTRONICS');
INSERT INTO "products" ("product_id", "category_id", "product_name", "price", "stock_quantity") VALUES (1004, 1001, 'Lance Hoffman', 1007.5, 1010);
INSERT INTO "products" ("product_id", "category_id", "product_name", "price", "stock_quantity") VALUES (1005, 1001, 'Meredith Barnes', 1016.5, 1021.0);
INSERT INTO "products" ("product_id", "category_id", "product_name", "price", "stock_quantity") VALUES (1006, 1001, 'Donald Booth', 1025.5, 1032.0);
INSERT INTO "inventory_logs" ("log_id", "product_id", "change_type", "change_amount", "log_seq") VALUES (1013, 1004, 'RESTOCK', 1016, 1019);
INSERT INTO "inventory_logs" ("log_id", "product_id", "change_type", "change_amount", "log_seq") VALUES (1014, 1004, 'RESTOCK', 1025.0, 1030.0);
INSERT INTO "inventory_logs" ("log_id", "product_id", "change_type", "change_amount", "log_seq") VALUES (1015, 1004, 'RESTOCK', 1034.0, 1041.0);
