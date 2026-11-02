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
-- DATASET 3
-- Tests:
-- 1. Fan-out trap / Unnecessary Joins: Inventories and Warehouses are in the schema and connected to Locations and Products, but NOT in the Reference Query. If a mutant joins Inventories or Warehouses, sums will multiply or rows will be dropped.
-- 2. Orphan/Unmatched rows and NULL foreign keys across the join chain.
-- 3. HAVING total_sales > 50000 vs WHERE (oi.quantity * oi.unit_price) > 50000 (individual items < 50000, sum > 50000).
-- 4. Multiple Countries, Locations, Customers, and Orders aggregating into a single Region.
INSERT INTO Regions (region_id, region_name) VALUES (1, 'North_America');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'Europe');
INSERT INTO Countries (country_id, country_name, region_id) VALUES (1, 'USA', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (2, 'Canada', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (3, 'OrphanCountry', NULL);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (4, 'UK', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (1, 'NY', 'NY', 1);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (2, 'Toronto', 'ON', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (3, 'Nowhere', 'NW', 3);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (4, 'London', 'LDN', 4);
-- Warehouses and Inventories (Trap for mutants joining extra tables)
-- Location 1 has 2 warehouses; Product 1 is in both. Product 2 has NO inventory at all.
INSERT INTO Warehouses (warehouse_id, location_id, warehouse_name) VALUES (1, 1, 'WH_NY_1');
INSERT INTO Warehouses (warehouse_id, location_id, warehouse_name) VALUES (2, 1, 'WH_NY_2');
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (1, 'Phone', 'Electronics', 500.0, 800.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (2, 'Tablet', 'Electronics', 300.0, 600.0);
INSERT INTO Inventories (product_id, warehouse_id, quantity) VALUES (1, 1, 100);
INSERT INTO Inventories (product_id, warehouse_id, quantity) VALUES (1, 2, 200);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (1, 'C_USA', 1, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (2, 'C_CAN', 2, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (3, 'C_OrphanCountry', 3, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (4, 'C_NullLoc', NULL, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (5, 'C_UK', 4, 5000.0);
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (1, 1, '2023-05-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (2, 2, '2023-05-02', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (3, 3, '2023-05-03', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (4, 4, '2023-05-04', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (5, NULL, '2023-05-05', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (6, 5, '2023-05-06', 'Shipped');
-- North_America: Order 1 (USA) has 30000, Order 2 (Canada) has 25000 -> Total = 55000 (> 50000, though each item < 50000)
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 30, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 25, 1000.0);
-- Unmatched/NULL FK orders (each > 50000, would appear if LEFT JOINs were used or cross joins occurred)
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 1, 1, 100, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 1, 1, 100, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (5, 1, 1, 100, 1000.0);
-- Europe: Uses Product 2 (which has 0 rows in Inventories). Total = 60000.
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (6, 1, 2, 60, 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('Europe', 60000.0)
('North_America', 55000.0)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.region_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('North_America', 60000.0)
*/