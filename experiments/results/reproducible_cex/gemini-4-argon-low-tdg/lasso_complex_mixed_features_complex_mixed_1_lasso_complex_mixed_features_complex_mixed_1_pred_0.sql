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
-- Tests boundary conditions for WHERE (credit_limit > 1000, category = 'Electronics') and HAVING (total_sales > 50000).
-- Also tests that WHERE filters before GROUP BY/HAVING.
INSERT INTO Regions (region_id, region_name) VALUES (1, 'BoundCredit');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'BoundCategory');
INSERT INTO Regions (region_id, region_name) VALUES (3, 'BoundHaving');
INSERT INTO Regions (region_id, region_name) VALUES (4, 'ValidRegion');
INSERT INTO Countries (country_id, country_name, region_id) VALUES (1, 'C1', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (2, 'C2', 2);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (3, 'C3', 3);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (4, 'C4', 4);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (1, 'L1', 'S1', 1);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (2, 'L2', 'S2', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (3, 'L3', 'S3', 3);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (4, 'L4', 'S4', 4);
-- Customer 1 has exact boundary credit_limit = 1000.0 (should be excluded)
-- Customer 2 has valid credit_limit = 1000.01 (should be included)
-- Customer 5 has NULL credit_limit (should be excluded)
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (1, 'Cust1_Low', 1, 1000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (2, 'Cust1_High', 1, 1000.01);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (3, 'Cust2', 2, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (4, 'Cust3', 3, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (5, 'Cust4_Null', 4, NULL);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (6, 'Cust4_Valid', 4, 2000.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (1, 'Elec', 'Electronics', 10.0, 20.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (2, 'NonElec', 'Clothing', 10.0, 20.0);
INSERT INTO Products (product_id, product_id, product_name, category, standard_cost, list_price) VALUES (3, 3, 'NullCat', NULL, 10.0, 20.0);
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (1, 1, '2023-01-01', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (2, 2, '2023-01-01', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (3, 3, '2023-01-01', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (4, 4, '2023-01-01', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (5, 5, '2023-01-01', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (6, 6, '2023-01-01', 'Pending');
-- Region 1 (BoundCredit): Cust1_Low has 40,000, Cust1_High has 30,000. Valid sum = 30,000 (fails HAVING). If >= 1000 used, sum = 70,000 (passes HAVING).
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 40, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 30, 1000.0);
-- Region 2 (BoundCategory): Elec has 30,000, Clothing has 40,000, NullCat has 40,000. Valid sum = 30,000 (fails HAVING). If category filter broken, passes HAVING.
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 1, 1, 30, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 2, 2, 40, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 3, 3, 40, 1000.0);
-- Region 3 (BoundHaving): Valid sum = 50,000 exactly (fails HAVING > 50000; would pass if >= 50000).
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 1, 1, 50, 1000.0);
-- Region 4 (ValidRegion): Cust4_Null has 50,000, Cust4_Valid has 50,000.01 (passes HAVING).
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (5, 1, 1, 50, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (6, 1, 1, 1, 50000.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('ValidRegion', 50000.01)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id WHERE cu.credit_limit > 1000 GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('BoundCategory', 110000.0)
('ValidRegion', 50000.01)
*/