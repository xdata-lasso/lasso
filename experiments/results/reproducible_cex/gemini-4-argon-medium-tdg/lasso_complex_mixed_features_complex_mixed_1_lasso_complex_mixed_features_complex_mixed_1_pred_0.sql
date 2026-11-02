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
-- DATASET 2
-- Tests:
-- 1. Boundary conditions on WHERE cu.credit_limit > 1000 (tests 1000.0, 999.9, NULL, 1000.01).
-- 2. Boundary conditions on WHERE p.category = 'Electronics' (tests 'Furniture', 'electronics', NULL).
-- 3. Boundary conditions on HAVING total_sales > 50000 (tests exact 50000.0 vs 50000.01).
-- 4. Duplicate unit_price values to catch SUM(DISTINCT ...) mutations.
INSERT INTO Regions (region_id, region_name) VALUES (1, 'R_Valid_With_Filtered_Rows');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'R_Exact_50000_Boundary');
INSERT INTO Regions (region_id, region_name) VALUES (3, 'R_Case_Sensitivity');
INSERT INTO Countries (country_id, country_name, region_id) VALUES (1, 'C1', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (2, 'C2', 2);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (3, 'C3', 3);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (1, 'L1', 'S1', 1);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (2, 'L2', 'S2', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (3, 'L3', 'S3', 3);
-- Customers for Region 1
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (1, 'ValidCust', 1, 1000.01);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (2, 'BoundaryCust1000', 1, 1000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (3, 'LowCust', 1, 500.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (4, 'NullCust', 1, NULL);
-- Customers for Region 2 & 3
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (5, 'ValidCust2', 2, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (6, 'ValidCust3', 3, 5000.0);
-- Products
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (1, 'P_Elec', 'Electronics', 100.0, 200.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (2, 'P_Furn', 'Furniture', 100.0, 200.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (3, 'P_elec_lower', 'electronics', 100.0, 200.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (4, 'P_NullCat', NULL, 100.0, 200.0);
-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (1, 1, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (2, 2, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (3, 3, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (4, 4, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (5, 5, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (6, 6, '2023-01-01', 'Shipped');
-- OrderItems for Region 1:
-- Valid items: two identical items of 1 * 26000 = 26000 each -> sum = 52000 (catches SUM(DISTINCT))
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 1, 26000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 2, 1, 1, 26000.0);
-- Invalid category items for ValidCust
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 3, 2, 1, 100000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 4, 4, 1, 100000.0);
-- Invalid customer items (credit_limit = 1000, 500, NULL)
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 1, 100000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 1, 1, 1, 100000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 1, 1, 1, 100000.0);
-- OrderItems for Region 2 (Exact 50000.0 -> excluded by HAVING > 50000)
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (5, 1, 1, 5, 10000.0);
-- OrderItems for Region 3 (Category 'electronics' lowercase -> excluded; valid Electronics is only 40000)
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (6, 1, 1, 4, 10000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (6, 2, 3, 5, 10000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('R_Valid_With_Filtered_Rows', 52000.0)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id WHERE cu.credit_limit > 1000 GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('R_Valid_With_Filtered_Rows', 252000.0)
('R_Case_Sensitivity', 90000.0)
*/