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
INSERT INTO products (product_id, product_name, category, standard_cost, list_price) VALUES (0, 'Electronics', 'default2', 1000.0, 1001.0), (50001, 'default1', 'Electronics', 1001.0, 4.0), (50000, 'default2', 'default1', NULL, 2.0), (999, NULL, NULL, 1000.0, 0.0), (1000, 'default1', 'Electronics', 2.0, 999.0), (49999, 'Electronics', 'Electronics', NULL, 1000.0);
INSERT INTO regions (region_id, region_name) VALUES (4, 'Electronics'), (50000, 'default1'), (1000, NULL), (1, 'default1'), (50001, 'default1'), (49999, NULL), (999, 'Electronics'), (1001, 'Electronics');
INSERT INTO countries (country_id, region_id, country_name) VALUES (1001, NULL, 'Electronics'), (50001, 50001, 'default1');
INSERT INTO locations (location_id, country_id, city, state) VALUES (50001, 50001, 'default2', 'Electronics'), (4, 1001, 'default2', 'default2'), (50000, 50001, NULL, 'Electronics'), (49999, NULL, 'default2', NULL), (1000, NULL, NULL, 'Electronics');
INSERT INTO customers (customer_id, location_id, name, credit_limit) VALUES (50001, 50000, 'default2', 3.0), (3, 50001, NULL, 50000.0), (999, NULL, 'default2', 1.0);
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES (50001, NULL, '2023-01-01', NULL), (3, 999, '2023-01-01', 'default2'), (1000, 999, '2023-01-01', 'default2'), (2, 3, '2023-01-02', 'default2'), (1001, 3, '2023-01-01', 'default1'), (4, NULL, '2023-01-01', 'default1'), (50000, 999, '2023-01-01', 'default2'), (49999, 999, NULL, 'default2'), (999, 50001, '2023-01-02', 'default2'), (0, NULL, NULL, 'default1');
INSERT INTO orderitems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 49999, NULL, 49999, 999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id WHERE cu.credit_limit > 1000 GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('default1', 49949001.0)
*/