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
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3394, 'Joseph Jimenez', 'Electronics', 3397.5, 3400.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3395, 'Lisa Morris', 'Electronics', 3406.5, 3411.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3396, 'Ashley Mills', 'Electronics', 3415.5, 3422.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3448, 'William Nguyen', 'Electronics', 3451.5, 3454.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3449, 'Phillip Jordan', 'Electronics', 3460.5, 3465.5);
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3450, 'Lisa Hart', 'Electronics', 3469.5, 3476.5);
INSERT INTO "regions" ("region_id", "region_name") VALUES (3403, 'Russell Anderson');
INSERT INTO "regions" ("region_id", "region_name") VALUES (3404, 'Russell Anderson');
INSERT INTO "regions" ("region_id", "region_name") VALUES (3405, 'Russell Anderson');
INSERT INTO "regions" ("region_id", "region_name") VALUES (3457, 'Ralph Howe');
INSERT INTO "regions" ("region_id", "region_name") VALUES (3458, 'Ralph Howe');
INSERT INTO "regions" ("region_id", "region_name") VALUES (3459, 'Ralph Howe');
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3406, 'Tunisia', 3403);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3407, 'Antigua and Barbuda', 3403);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3408, 'Cook Islands', 3403);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3460, 'Equatorial Guinea', 3457);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3461, 'Guyana', 3457);
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3462, 'Korea', 3457);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3409, 'South Jameston', 'Rhode Island', 3406);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3410, 'Barretthaven', 'Virginia', 3406);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3411, 'Brandonbury', 'California', 3406);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3463, 'Moyertown', 'Iowa', 3460);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3464, 'West Caitlinhaven', 'Indiana', 3460);
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3465, 'West Adam', 'Massachusetts', 3460);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3412, 'Thomas Rios', 3409, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3413, 'Sandra Mcdonald', 3409, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3414, 'Heather Paul', 3409, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3466, 'Rodney Norris', 3463, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3467, 'Juan Hawkins', 3463, 1001.0);
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3468, 'Brittney Johnson', 3463, 1001.0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3415, 3412, '1996-06-06', 'voice');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3416, 3412, '1996-06-07', 'just');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3417, 3412, '1996-06-08', 'term');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3469, 3466, '1973-01-12', 'heart');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3470, 3466, '1973-01-13', 'clearly');
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3471, 3466, '1973-01-14', 'certainly');
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3415, 3418, 3394, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3415, 3419, 3395, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3415, 3420, 3396, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3415, 3445, 3394, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3469, 3472, 3448, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3469, 3473, 3449, 50001, 1.0);
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3469, 3474, 3450, 50001, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('Russell Anderson', 200004.0)
('Ralph Howe', 150003.0)
*/

-- Prediction Query
SELECT region_name, total_sales FROM (SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales, ROW_NUMBER() OVER (PARTITION BY r.region_name ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS rn FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000) WHERE rn <= 3;

/*
Prediction Result:
('Ralph Howe', 150003.0)
('Russell Anderson', 200004.0)
*/