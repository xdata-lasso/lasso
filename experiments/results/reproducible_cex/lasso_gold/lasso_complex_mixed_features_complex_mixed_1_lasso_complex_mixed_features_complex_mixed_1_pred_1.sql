-- Schema DDL
CREATE TABLE Regions (region_id INTEGER PRIMARY KEY, region_name TEXT);

CREATE TABLE Countries (country_id INTEGER PRIMARY KEY, country_name TEXT, region_id INTEGER, FOREIGN KEY (region_id) REFERENCES Regions (region_id));

CREATE TABLE Locations (location_id INTEGER PRIMARY KEY, city TEXT, state TEXT, country_id INTEGER, FOREIGN KEY (country_id) REFERENCES Countries (country_id));

CREATE TABLE Warehouses (warehouse_id INTEGER PRIMARY KEY, location_id INTEGER, warehouse_name TEXT, FOREIGN KEY (location_id) REFERENCES Locations (location_id));

CREATE TABLE Products (product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, standard_cost REAL, list_price REAL);

CREATE TABLE Inventories (product_id INTEGER, warehouse_id INTEGER, quantity INTEGER, PRIMARY KEY (product_id, warehouse_id), FOREIGN KEY (warehouse_id) REFERENCES Warehouses (warehouse_id), FOREIGN KEY (product_id) REFERENCES Products (product_id));

CREATE TABLE Customers (customer_id INTEGER PRIMARY KEY, name TEXT, location_id INTEGER, credit_limit REAL, FOREIGN KEY (location_id) REFERENCES Locations (location_id));

CREATE TABLE Orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER, order_date DATE, status TEXT, FOREIGN KEY (customer_id) REFERENCES Customers (customer_id));

CREATE TABLE OrderItems (order_id INTEGER, item_id INTEGER, product_id INTEGER, quantity INTEGER, unit_price REAL, PRIMARY KEY (order_id, item_id), FOREIGN KEY (order_id) REFERENCES Orders (order_id), FOREIGN KEY (product_id) REFERENCES Products (product_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1001, 'Allison Hill', 'Electronics', 1007.5, 1013.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1002, 'Noah Rhodes', 'Electronics', 1016.5, 1024.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1003, 'Angie Henderson', 'Electronics', 1025.5, 1035.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1004, 'Daniel Wagner', 'Electronics', 1034.5, 1046.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1005, 'Cristian Santos', 'Electronics', 1043.5, 1057.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1006, 'Connie Lawrence', 'Electronics', 1052.5, 1068.5);
INSERT INTO "regions" ("region_id", "region_name") VALUES (1019, 'Abigail Shaffer');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1020, 'Abigail Shaffer');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1021, 'Abigail Shaffer');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1022, 'Abigail Shaffer');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1023, 'Abigail Shaffer');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1024, 'Abigail Shaffer');
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1025, 'Qatar', 1019);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1026, 'Jamaica', 1019);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1027, 'Guam', 1019);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1028, 'Fiji', 1019);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1029, 'Cape Verde', 1019);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1030, 'Cuba', 1019);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1031, 'Curtisfurt', 'Colorado', 1025);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1032, 'West Melanieview', 'Iowa', 1025);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1033, 'Lake Stephenville', 'Connecticut', 1025);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1034, 'Millerport', 'Missouri', 1025);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1035, 'Barbaraland', 'Louisiana', 1025);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1036, 'Lake Jeremyport', 'New Jersey', 1025);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1037, 'Holly Wood', 1031, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1038, 'Derek Zuniga', 1031, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1039, 'Lisa Jackson', 1031, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1040, 'Carla Gray', 1031, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1041, 'Margaret Hawkins DDS', 1031, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1042, 'Patty Perez', 1031, 1001.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1043, 1037, '1970-01-01', 'almost');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1044, 1037, '1970-01-02', 'support');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1045, 1037, '1970-01-03', 'four');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1046, 1037, '1970-01-04', 'institution');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1047, 1037, '1970-01-05', 'executive');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1048, 1037, '1970-01-06', 'attorney');
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1049, 1001, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1050, 1002, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1051, 1003, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1052, 1004, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1053, 1005, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1043, 1054, 1006, 50001, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('Abigail Shaffer', 300006.0)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.region_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
*/