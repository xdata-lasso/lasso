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
INSERT INTO "Regions" ("region_id", "region_name") VALUES (53, 'row_number73');
INSERT INTO "Regions" ("region_id", "region_name") VALUES (51, 'row_number53');
INSERT INTO "Countries" ("country_id", "region_id", "country_name") VALUES (56, 53, NULL);
INSERT INTO "Countries" ("country_id", "region_id", "country_name") VALUES (52, 53, 'row_number75');
INSERT INTO "Locations" ("location_id", "country_id", "city", "state") VALUES (55, 56, 'Electronics78', 'row_number79');
INSERT INTO "Locations" ("location_id", "country_id", "city", "state") VALUES (54, 56, NULL, 'row_number81');
INSERT INTO "Warehouses" ("warehouse_id", "location_id", "warehouse_name") VALUES (57, NULL, 'row_number53');
INSERT INTO "Products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (68, 'row_number99', 'Electronics', 100, 101);
INSERT INTO "Products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (59, 'row_number53', 'row_number53', 53, 53);
INSERT INTO "Customers" ("customer_id", "location_id", "name", "credit_limit") VALUES (62, 55, 'Electronics84', 1001);
INSERT INTO "Customers" ("customer_id", "location_id", "name", "credit_limit") VALUES (61, 54, NULL, 86);
INSERT INTO "Orders" ("order_id", "customer_id", "order_date", "status") VALUES (64, 62, '1000-03-31', 'Electronics90');
INSERT INTO "Orders" ("order_id", "customer_id", "order_date", "status") VALUES (63, 61, NULL, 'Electronics92');
INSERT INTO "OrderItems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (63, 66, NULL, 95, 96);
INSERT INTO "OrderItems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (64, 65, 68, -1, -50001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('row_number73', 50001.0)
*/

-- Prediction Query
SELECT region_name, total_sales FROM (SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales, ROW_NUMBER() OVER (PARTITION BY r.region_name ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rn FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000) WHERE rn <= 3;

/*
Prediction Result:
('row_number73', 50001.0)
*/