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
-- DATASET 1
-- Tests LIMIT 3 (5 qualifying groups), ORDER BY total_sales DESC, ORDER BY r.region_name ASC tie-breaking, and NULLS LAST handling.
INSERT INTO Regions (region_id, region_name) VALUES (1, 'North');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'South');
INSERT INTO Regions (region_id, region_name) VALUES (3, 'East');
INSERT INTO Regions (region_id, region_name) VALUES (4, 'West');
INSERT INTO Regions (region_id, region_name) VALUES (5, NULL);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (1, 'C1', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (2, 'C2', 2);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (3, 'C3', 3);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (4, 'C4', 4);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (5, 'C5', 5);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (1, 'City1', 'S1', 1);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (2, 'City2', 'S2', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (3, 'City3', 'S3', 3);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (4, 'City4', 'S4', 4);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (5, 'City5', 'S5', 5);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (1, 'Cust1', 1, 2000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (2, 'Cust2', 2, 2000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (3, 'Cust3', 3, 2000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (4, 'Cust4', 4, 2000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (5, 'Cust5', 5, 2000.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (1, 'P1', 'Electronics', 100.0, 200.0);
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (1, 1, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (2, 2, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (3, 3, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (4, 4, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (5, 5, '2023-01-01', 'Shipped');
-- North: 90,000; South: 80,000; East: 80,000; NULL: 80,000; West: 60,000
-- Expected output: North (90000), East (80000), South (80000). NULL and West are pushed out by NULLS LAST and LIMIT 3.
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 90, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 80, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 1, 1, 80, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 1, 1, 60, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (5, 1, 1, 80, 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('North', 90000.0)
('East', 80000.0)
('South', 80000.0)
*/

-- Prediction Query
SELECT region_name, total_sales FROM (SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales, ROW_NUMBER() OVER (PARTITION BY r.region_name ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rn FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000) WHERE rn <= 3;

/*
Prediction Result:
(None, 80000.0)
('East', 80000.0)
('North', 90000.0)
('South', 80000.0)
('West', 60000.0)
*/