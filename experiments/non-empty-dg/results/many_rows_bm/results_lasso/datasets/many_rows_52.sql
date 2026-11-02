INSERT INTO "customers" ("customer_id", "customer_name", "country", "tier", "credit_limit") VALUES (1001, 'Allison Hill', 'Czech Republic', 'BRONZE', 1002.5);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "total_amount") VALUES (1003, 1001, 'since', 'DELIVERED', 1004.5);
INSERT INTO "shipments" ("shipment_id", "order_id", "carrier", "tracking_status", "delivery_days") VALUES (1005, 1003, 'UPS', 'DELIVERED', 1);
