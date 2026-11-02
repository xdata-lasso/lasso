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
-- Inserting into table: locations --
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1, '9n8', '4', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (-2147483647, 'tti', 'bnp', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (2, 'uo4nrqrofqy', '5s5b', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3, '02eu', 'liqa1', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (4, '4h', 'ia2yp', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (5, 'zhsrwb', 'p', 4);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (6, '5bbp0', '2eutliqa11r', 6);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (7, 'ytoo3o9hl7', 'klex14ji', 7);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (8, '7vfe4h', 'ia2yp', 8);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (9, '000t5c4ec', 'gce', 9);

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1, 'ia2yp', 'Electronics', 718.397869, 324.940703);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (-2147483647, 'w6kl', 'Electronics', 83.204633, 5.585347);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3, '2dwyrq', 'Electronics', 433.533777, 458.991081);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (2, 'yu78', '9', 557.003843, 182.777264);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (4, 'bnp', 'Electronics', 787.938887, 986.066566);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (5, 'dposiie5unw', 'Electronics', 992.733505, 162.04354);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (6, '8d99rljsl', 'Electronics', 419.361606, 470.165282);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (7, 'p5qi2rk', 'Electronics', 811.601922, 92.834164);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (8, '4', NULL, 249.706432, 99.523333);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (9, 'nw6klf', 'p_s_2c1b78', 741.842896, 587.783596);

-- Inserting into table: regions --
INSERT INTO "regions" ("region_id", "region_name") VALUES (1, 'r_s_055c6d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (2, 'r_s_055c6d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (3, 'r_s_055c6d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (4, 'r_s_055c6d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (5, 'r_s_055c6d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (6, 'r_s_f4173a');

INSERT INTO "regions" ("region_id", "region_name") VALUES (7, 'r_s_f4173a');

INSERT INTO "regions" ("region_id", "region_name") VALUES (-2147483641, 'reg_c49626');

INSERT INTO "regions" ("region_id", "region_name") VALUES (8, 'r_s_f4173a');

INSERT INTO "regions" ("region_id", "region_name") VALUES (9, 'r_s_f4173a');

INSERT INTO "regions" ("region_id", "region_name") VALUES (-2147483638, 'reg_c49626');

INSERT INTO "regions" ("region_id", "region_name") VALUES (10, '5k5swwqcgs');

INSERT INTO "regions" ("region_id", "region_name") VALUES (11, 'mdpos');

-- Inserting into table: countries --
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1, '5k5swwqcgs', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483647, 'rwbbp6luhvd', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3, '5c4ec', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (2, 'gce376nium52', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (5, '5k5swwqcgs', 6);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (4, '9n8c4pgu7v', 3);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (7, '52zbuo4nrq', 8);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (6, 'ofqyp', 9);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (8, '9n8', 10);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (9, 'ie5', 11);

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1, 'gu7v', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483647, 'mdpos', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3, 'yytoo', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (2, '9hl7', 3, 443.457804);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483644, '0dz79f', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483643, '8ozk3zbil', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483642, '7xb72', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483641, 'ogrgjd8y', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483640, '1jh3den', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (4, 'uhv', 4, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (5, 'tti', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (6, 'au2dwy', 6, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (7, '13pyu', 4, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (8, 'uzhsrwbbp6lu', 8, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (9, '76nium52', 9, 1000.0);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1, 1, '2020-12-20', '4h');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483647, 1, '2021-06-28', 'e5u');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (2, 1, '2021-12-23', 'x1');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3, 2, '2021-08-16', '7zw');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (4, 3, '2020-12-06', 'a9000t5c4eci');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (5, 4, '2021-03-18', 'e');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (6, -2147483643, '2022-12-15', 'x58pz0f8je');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (7, 7, '2021-02-03', 'd21vy9uxj4hw');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (8, 8, '2021-04-10', 'dlttil');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (9, 9, '2024-06-13', 'u');

-- Inserting into table: orderitems --
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483648, 1, -1670923962, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483647, 1, 1620389964, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483646, 1, 546571701, 801.414196);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483645, 1, 947159877, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483644, 1, -443340271, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483643, 1, 2074205376, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483642, 1, 1178636309, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483641, 1, 481163439, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483640, 2, -904834265, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483639, 1, -346339240, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483638, 1, 1692174491, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483637, 1, -1025564911, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483636, 1, -227162283, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483635, 1, 2056419640, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483634, 2, 222415430, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483633, 1, 556727997, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483632, 1, 1178000634, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483631, 1, 1836127587, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483630, 1, -1529584866, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483629, 1, 1196308825, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483628, 2, 910894705, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483627, 1, -283454505, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483626, 1, 233994589, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483625, 1, 1442655647, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483624, 1, -87647544, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483623, 1, -629784617, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483622, 2, -1929953647, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483621, 1, 1581736075, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483620, 1, -261132974, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483619, 1, -1264842910, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483618, 1, -1052964641, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483617, 1, -1245682094, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483616, 2, -1660358170, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483615, 1, -1106350634, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483614, 1, -1509264256, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483613, 1, -1485777725, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483612, 1, -1255130038, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483611, 1, -1762857309, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483610, 1, 806170397, 656.638403);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483609, 1, 513454646, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483608, 1, -688216274, 577.256099);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483607, 1, 1382410067, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483606, 1, 1631231566, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483605, 1, 982314585, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483604, 1, 638024588, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483603, 1, -688098735, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483602, 1, 1784916884, 508.771546);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483601, 1, 834709651, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483600, 1, -348113485, 532.326819);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483599, 1, -932772113, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483598, 1, -639539893, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483597, 1, 1350414441, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483596, 1, 2094425101, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483595, 1, -961217731, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483594, 1, -1888505890, 680.944245);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483593, 1, 61479715, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483592, 1, -1496556994, 7.367195);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483591, 1, 1746373317, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483590, 1, 1360271423, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483589, 1, 1129658414, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483588, 1, 1250290042, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483587, 1, -1717646459, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483586, 1, -1696173285, 127.371696);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483585, 1, 710458518, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483584, 1, 678047687, 155.845079);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483583, 1, -491938169, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483582, 1, -106471771, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483581, 1, 357330522, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (3, -2147483580, 1, -683007527, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483579, 1, 2035306060, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483578, 1, 1523825314, 983.924121);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483577, 1, -47052816, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483576, 1, 645287482, 222.511261);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483575, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483574, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483573, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483572, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483571, 2, -1957268147, 51.002063);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483570, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483569, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483568, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483567, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483566, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483565, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483564, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483563, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483562, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483561, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (5, -2147483560, 2, -1, -1.0);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483559, 4, 0, 0.0);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483558, 1, -1585009206, 191.847248);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (6, -2147483557, 1, -1, 1.0);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (7, -2147483556, 1, -1, 0.0);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483555, 1, -736979194, 989.653112);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (8, -2147483554, 8, 429706943, 240.969194);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (9, -2147483553, 9, -1179823637, 760.580899);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
('r_s_055c6d', 440258908191530.94)
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id WHERE cu.credit_limit > 1000 GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('r_s_055c6d', 272067252509831.34)
('5k5swwqcgs', 103546135710.91394)
*/