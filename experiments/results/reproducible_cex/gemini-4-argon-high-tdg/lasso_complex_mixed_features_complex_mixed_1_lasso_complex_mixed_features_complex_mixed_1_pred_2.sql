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
INSERT INTO Regions (region_id, region_name) VALUES (1, 'North America');
INSERT INTO Regions (region_id, region_name) VALUES (2, 'Europe');
INSERT INTO Regions (region_id, region_name) VALUES (3, 'Asia');
INSERT INTO Regions (region_id, region_name) VALUES (4, 'South America');
INSERT INTO Regions (region_id, region_name) VALUES (5, 'Africa');
INSERT INTO Countries (country_id, country_name, region_id) VALUES (10, 'USA', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (11, 'Canada', 1);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (12, 'Germany', 2);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (13, 'Japan', 3);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (14, 'Brazil', 4);
INSERT INTO Countries (country_id, country_name, region_id) VALUES (15, 'Egypt', 5);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (20, 'New York', 'NY', 10);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (21, 'Toronto', 'ON', 11);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (22, 'Berlin', 'BE', 12);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (23, 'Tokyo', 'TK', 13);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (24, 'Sao Paulo', 'SP', 14);
INSERT INTO Locations (location_id, city, state, country_id) VALUES (25, 'Cairo', 'CA', 15);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (50, 'Laptop', 'Electronics', 500.0, 1200.0);
INSERT INTO Products (product_id, product_name, category, standard_cost, list_price) VALUES (51, 'Smartphone', 'Electronics', 300.0, 800.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (30, 'Alice', 20, 5000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (31, 'Bob', 21, 3000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (32, 'Charlie', 22, 4000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (33, 'David', 23, 6000.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (34, 'Eva', 24, 2500.0);
INSERT INTO Customers (customer_id, name, location_id, credit_limit) VALUES (35, 'Frank', 25, 2000.0);
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (40, 30, '2023-01-10', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (41, 31, '2023-01-12', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (42, 32, '2023-02-01', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (43, 33, '2023-03-05', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (44, 34, '2023-04-10', 'Shipped');
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES (45, 35, '2023-05-15', 'Shipped');
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (40, 1, 50, 30, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (41, 1, 51, 45, 1000.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (42, 1, 50, 40, 1100.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (42, 2, 51, 50, 820.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (43, 1, 50, 60, 1500.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (44, 1, 51, 70, 900.0);
INSERT INTO OrderItems (order_id, item_id, product_id, quantity, unit_price) VALUES (45, 1, 50, 45, 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('Asia', 90000.0)
('Europe', 85000.0)
('North America', 75000.0)
*/

-- Prediction Query
SELECT region_name, total_sales FROM (SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales, ROW_NUMBER() OVER (PARTITION BY r.region_name ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rn FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000) WHERE rn <= 3;

/*
Prediction Result:
('Asia', 90000.0)
('Europe', 85000.0)
('North America', 75000.0)
('South America', 63000.0)
*/