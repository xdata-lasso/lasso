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
INSERT INTO products (product_id, product_name, category, standard_cost, list_price) VALUES (999, 'default2', 'default1', 2.0, 50000.0), (49999, 'Electronics', 'default2', 1001.0, 1.0), (50001, NULL, 'Electronics', 999.0, 1000.0), (1000, NULL, 'default1', 999.0, 0.0), (2, 'default1', 'Electronics', 50000.0, 1000.0), (0, NULL, NULL, 1001.0, 1.0), (50000, 'Electronics', 'default1', 1.0, 50001.0), (3, 'default1', 'default2', 49999.0, 999.0), (1001, NULL, 'Electronics', 1001.0, NULL), (4, NULL, 'default2', 49999.0, 3.0), (1, 'default2', 'Electronics', 4.0, 1.0), (5, NULL, 'default1', 50001.0, 4.0), (6, 'Electronics', 'default1', 1.0, 50001.0), (7, 'default2', 'default1', 1.0, 999.0), (8, 'default2', 'default2', 3.0, 1001.0), (9, 'default2', 'default2', 1001.0, 999.0), (10, 'default1', 'Electronics', 49999.0, 49999.0), (11, 'default1', NULL, 50000.0, 50000.0), (12, NULL, 'default2', 4.0, NULL), (13, NULL, 'default1', 1000.0, 50000.0), (14, 'default1', 'Electronics', 2.0, 0.0);
INSERT INTO regions (region_id, region_name) VALUES (1000, NULL), (0, 'default2'), (3, 'default2'), (4, 'default1'), (1, 'default1'), (49999, 'Electronics'), (50001, 'default1'), (2, NULL), (1001, 'default1'), (999, 'default1'), (50000, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'Electronics'), (8, NULL), (9, NULL), (10, 'default2'), (11, 'Electronics');
INSERT INTO countries (country_id, region_id, country_name) VALUES (50000, 3, 'Electronics'), (0, 7, 'default2'), (4, 2, 'default1'), (1000, NULL, 'Electronics'), (1001, 6, 'Electronics'), (999, 999, 'default2'), (3, 7, 'Electronics'), (2, 2, 'Electronics'), (49999, 2, 'default2'), (50001, 0, 'Electronics'), (1, 1001, 'Electronics'), (5, 5, 'default2'), (6, 5, 'Electronics'), (7, 1000, 'Electronics'), (8, 1001, 'default1'), (9, 1, 'default1'), (10, 1000, NULL), (11, NULL, 'default2'), (12, 50000, 'default1'), (13, 1, NULL), (14, 4, 'default2');
INSERT INTO locations (location_id, country_id, city, state) VALUES (4, 1, 'default2', NULL), (50000, 8, 'Electronics', NULL), (0, 12, 'Electronics', 'default1'), (3, 9, NULL, 'default1'), (2, 1000, NULL, 'default2'), (50001, 0, NULL, 'default1'), (49999, 6, 'Electronics', 'default1'), (1000, 999, NULL, 'default1'), (999, 7, 'Electronics', NULL), (1001, 50000, 'default2', 'default2'), (1, 10, NULL, 'default2'), (5, 2, 'Electronics', 'default2');
INSERT INTO customers (customer_id, location_id, name, credit_limit) VALUES (3, 2, 'default1', 1.0), (4, 49999, 'default2', 50001.0), (1000, 999, 'default1', 0.0), (1001, NULL, 'Electronics', NULL), (999, 1001, 'Electronics', 1001.0), (49999, 1, NULL, 1000.0), (0, 0, NULL, 999.0), (1, 2, 'Electronics', 0.0), (50001, 999, 'default2', 0.0), (50000, 1, 'Electronics', 4.0), (2, 50001, 'default2', 49999.0), (5, 999, 'default2', 49999.0), (6, 50001, NULL, 49999.0), (7, 0, 'default1', 4.0), (8, 3, 'Electronics', 50001.0), (9, 1001, NULL, 1001.0), (10, 999, 'default2', 4.0), (11, 1001, 'default2', 2.0), (12, 1000, NULL, 999.0), (13, 1000, NULL, 999.0), (14, 49999, 'default2', 1001.0), (15, 1, NULL, 50001.0);
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES (999, 0, NULL, 'default2'), (0, 1, '2023-01-01', 'Electronics'), (3, 50000, '2023-01-01', 'default2'), (1001, 999, '2023-01-01', 'default2'), (1000, 9, '2023-01-02', 'default1'), (50000, 4, '2023-01-01', 'Electronics'), (49999, 1000, '2023-01-02', NULL), (4, 13, '2023-01-01', NULL), (50001, 1, '2023-01-02', 'default1'), (2, 7, NULL, NULL), (1, 10, '2023-01-02', 'default2'), (5, 15, '2023-01-01', 'default1'), (6, 0, '2023-01-01', 'default1'), (7, 1, '2023-01-02', 'default1'), (8, 5, NULL, 'Electronics'), (9, 999, '2023-01-01', 'default1'), (10, 1001, '2023-01-02', 'default1'), (11, 5, NULL, 'Electronics'), (12, 4, NULL, NULL), (13, 12, '2023-01-02', 'default2'), (14, 9, '2023-01-02', 'default1'), (15, 10, '2023-01-02', 'default1'), (16, 0, '2023-01-01', 'default1'), (17, 1000, '2023-01-02', 'default2');
INSERT INTO orderitems (order_id, item_id, product_id, quantity, unit_price) VALUES (10, 1001, 12, 1000, 999.0), (49999, 49999, 50000, 50000, 1000.0), (50001, 999, 50000, 50000, 4.0), (10, 3, 49999, 50001, 1.0), (1001, 1000, 1, 49999, 3.0), (17, 1000, 1001, 50001, NULL), (1000, 3, 5, 50001, 3.0), (7, 50001, 50001, 0, 49999.0), (6, 999, 4, 50000, 1.0), (49999, 0, 4, 1, 4.0), (15, 4, 3, 0, 1000.0), (16, 3, 3, 2, 0.0), (50001, 3, 14, 4, 1001.0), (5, 1000, 1, 2, 50001.0), (12, 2, 50001, 0, 49999.0), (10, 999, 9, 1, 2.0), (17, 1, 14, 50001, NULL), (1001, 50001, 6, 2, 0.0), (13, 0, 999, 0, 50000.0), (1000, 49999, 11, 999, 4.0), (12, 999, 1000, 3, 3.0), (1000, 999, 1001, 49999, 999.0), (999, 50000, 9, 50000, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('default2', 50098998.0)
(None, 100002.0)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.region_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('default2', 50098998.0)
*/