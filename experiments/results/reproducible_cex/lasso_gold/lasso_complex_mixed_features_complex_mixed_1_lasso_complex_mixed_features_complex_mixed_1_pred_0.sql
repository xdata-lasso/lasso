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
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1598, 'Electronics', 'high', 1604.5, 1610.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1599, 'Electronics', 'high', 1613.5, 1621.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1600, 'Electronics', 'high', 1622.5, 1632.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1601, 'Electronics', 'high', 1631.5, 1643.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1602, 'Electronics', 'high', 1640.5, 1654.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1603, 'Electronics', 'high', 1649.5, 1665.5);
INSERT INTO "regions" ("region_id", "region_name") VALUES (1616, 'Kathleen Ramos');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1617, 'Kathleen Ramos');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1618, 'Kathleen Ramos');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1619, 'Kathleen Ramos');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1620, 'Kathleen Ramos');
INSERT INTO "regions" ("region_id", "region_name") VALUES (1621, 'Kathleen Ramos');
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1622, 'Austria', 1616);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1623, 'Costa Rica', 1616);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1624, 'Ethiopia', 1616);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1625, 'Mexico', 1616);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1626, 'Bulgaria', 1616);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1627, 'Vanuatu', 1616);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1628, 'Samuelfort', 'North Carolina', 1622);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1629, 'North Teresabury', 'Virginia', 1622);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1630, 'West Andrea', 'Louisiana', 1622);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1631, 'Davisville', 'Nebraska', 1622);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1632, 'Valentineberg', 'Kansas', 1622);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1633, 'Cantuport', 'New Jersey', 1622);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1634, 'Janet Weeks', 1628, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1635, 'Sherry Shields', 1628, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1636, 'Richard Perry', 1628, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1637, 'Katie Hoover', 1628, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1638, 'Edwin Matthews', 1628, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1639, 'Mrs. Brittany Ryan MD', 1628, 1001.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1640, 1634, '1978-01-21', 'old');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1641, 1634, '1978-01-22', 'source');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1642, 1634, '1978-01-23', 'of');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1643, 1634, '1978-01-24', 'huge');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1644, 1634, '1978-01-25', 'lose');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1645, 1634, '1978-01-26', 'worker');
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1646, 1598, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1647, 1599, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1648, 1600, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1649, 1601, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1650, 1602, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1640, 1651, 1603, 50001, 1.0);
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
('Kathleen Ramos', 300006.0)
*/