INSERT INTO "customers" ("customer_id", "customer_name", "country", "tier", "credit_limit") VALUES (1001, 'Allison Hill', 'Antarctica (the territory South of 60 deg S)', 'BRONZE', 1004.5);
INSERT INTO "customers" ("customer_id", "customer_name", "country", "tier", "credit_limit") VALUES (1002, 'Noah Rhodes', 'Bermuda', 'BRONZE', 1015.5);
INSERT INTO "customers" ("customer_id", "customer_name", "country", "tier", "credit_limit") VALUES (1003, 'Angie Henderson', 'Cuba', 'BRONZE', 1026.5);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "total_amount") VALUES (1007, 1001, 'agreement', 'PENDING', 101.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "total_amount") VALUES (1008, 1001, 'option', 'PENDING', 101.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "total_amount") VALUES (1009, 1001, 'decide', 'PENDING', 101.0);
