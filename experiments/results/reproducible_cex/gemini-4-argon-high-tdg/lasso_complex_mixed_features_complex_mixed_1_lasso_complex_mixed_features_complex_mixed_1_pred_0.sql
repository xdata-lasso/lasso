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
-- DATASET 4
INSERT INTO Regions (region_id, region_name) VALUES (1, 'Exact50k');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'CreditBoundary');
INSERT INTO Regions (region_id, region_name) VALUES (3, 'CategoryMix');
INSERT INTO Regions (region_id, region_name) VALUES (4, 'LowCreditOnly');
INSERT INTO Countries (country_id, country_name, region_id) VALUES (1, 'Country1', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (2, 'Country2', 2);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (3, 'Country3', 3);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (4, 'Country4', 4);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (1, 'City1', 'ST1', 1);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (2, 'City2', 'ST2', 2);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (3, 'City3', 'ST3', 3);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (4, 'City4', 'ST4', 4);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (1, 'TV', 'Electronics', 400.0, 1000.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (2, 'Desk', 'Furniture', 200.0, 500.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (3, 'Radio', 'electronics', 50.0, 100.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (4, 'Cables', NULL, 10.0, 25.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (1, 'CustExact50k', 1, 2000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (2, 'CustLimit1000', 2, 1000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (3, 'CustLimit1000_01', 2, 1000.01);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (4, 'CustCatMix', 3, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (5, 'CustLimit999', 4, 999.99);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (6, 'CustLimitNull', 4, NULL);
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (1, 1, '2023-01-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (2, 2, '2023-01-02', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (3, 3, '2023-01-03', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (4, 4, '2023-01-04', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (5, 5, '2023-01-05', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (6, 6, '2023-01-06', 'Shipped');
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 50, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (2, 1, 1, 40, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (3, 1, 1, 50, 1000.02);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 1, 1, 55, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 2, 2, 30, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 3, 3, 20, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (4, 4, 4, 10, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (5, 1, 1, 80, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (6, 1, 1, 90, 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('CategoryMix', 55000.0)
('CreditBoundary', 50001.0)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id WHERE cu.credit_limit > 1000 GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('CategoryMix', 115000.0)
('CreditBoundary', 50001.0)
*/