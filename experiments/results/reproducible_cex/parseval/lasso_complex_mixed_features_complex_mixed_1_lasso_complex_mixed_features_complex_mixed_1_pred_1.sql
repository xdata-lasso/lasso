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
INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (1, 'e4', 'hria2ypuzhs', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (-2147483647, 'gce376nium52', 'zbuo4nrqrof', 2);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (3, 'x58pz', 'f8jegd2', 1);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (2, 'y9uxj4', 'wb', 5);

INSERT INTO "locations" ("location_id", "city", "state", "country_id") VALUES (4, 'iztv', '6', -2147483612);

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (1, 'rmdp', 'Electronics', 227.766936, 971.82669);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (-2147483647, 'ytoo3o9', 'Electronics', 111.926013, 731.301441);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (3, 'yrk', 'Electronics', 615.222139, 203.331848);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (2, 'vck6ah0f8', 'sww', 176.824244, 842.831917);

INSERT INTO "products" ("product_id", "product_name", "category", "standard_cost", "list_price") VALUES (4, 'tb', 'Electronics', 544.766726, 990.66185);

-- Inserting into table: regions --
INSERT INTO "regions" ("region_id", "region_name") VALUES (1, 'r_s_c62006');

INSERT INTO "regions" ("region_id", "region_name") VALUES (2, 'r_s_c62006');

INSERT INTO "regions" ("region_id", "region_name") VALUES (3, 'r_s_c62006');

INSERT INTO "regions" ("region_id", "region_name") VALUES (4, 'r_s_c62006');

INSERT INTO "regions" ("region_id", "region_name") VALUES (5, 'x14ji7zwau2d');

INSERT INTO "regions" ("region_id", "region_name") VALUES (-2147483612, '1quik');

-- Inserting into table: countries --
INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483648, '5k5swwqcgs', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (1, '9n8c4pgu7v', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483646, '5u', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483645, 'w6kl', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (2, 'a9000t5c4eci', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483643, 'yrq13p', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (5, '78d99r', 4);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483641, 'l0b4y', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (3, '5qi2', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483639, '9v', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483638, 'ph2', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483637, 'jtu0d', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483636, 'i', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483635, '72fxa7ryfd', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483634, '6nijjai5dh', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483633, 'rg', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483632, 'yzt1afgog', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483631, 'tsj3ayxp1q4', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483630, 'den8c68x', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483629, 'c', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483628, 'u5', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483627, 'f77pzo72ctd', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483626, 'g6', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483625, 'v5q8qdj', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483624, 'io22785', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483623, '7cvtjpttg6b', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483622, '5zi36c4bfkfo', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483621, '7z2zezj', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483620, 'wgxd5ysxc', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483619, 'g', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483618, 'lq5lnpim', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483617, '8qs27p2r', 5);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483616, 'h2mna', 2);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483615, 'a3o', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483614, 'uttmu2ne5', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483613, 'yz7zzb', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483612, 'kv42q7', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483611, 'us3auvmkrpdj', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483610, 'w5chn9m', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483609, 'szdo2z', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483608, '0k32odwcl5a', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483607, 'dj9erhi', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483606, 'k1', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483605, 't', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483604, 'uzkb521gwnl', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483603, 'z5nxih6', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483602, 'xlyotow9', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483601, '39tajz9', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483600, 'wcgumbc3', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483599, '9603vz', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483598, '1rxe9y', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483597, 'h55y', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483596, 'u06dza', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483595, 'i2hy08ftp6', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483594, 'qxxnj', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483593, '1cj8', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483592, 'ys7dyyd', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483591, 'qta8y3a17', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483590, 'v4ygmayq3qdp', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483589, 'rhm5w', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483588, 'ic7', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483587, 'dn2np490xdm', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483586, 'sqtgelcuqb', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483585, 'i9f2ccukj', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (-2147483584, 'yhb08hl', 1);

INSERT INTO "countries" ("country_id", "country_name", "region_id") VALUES (6, 't1pqo', -2147483612);

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (1, 'rwbbp6luhvd', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (-2147483647, 'qyp5s5bbp0', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (2, 'nd', 1, 1000.01);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (3, 'nqcx5h', 3, 210.05299);

INSERT INTO "customers" ("customer_id", "name", "location_id", "credit_limit") VALUES (4, '4iz7', 4, 1000.01);

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (1, 1, '2022-01-04', 'tilbn');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483647, 1, '2024-12-15', 'eutliqa11r');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (3, 1, '2024-06-09', '9fjgq8n2f');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (2, 3, '2020-08-04', 'qv0gcb98ozk');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483644, 1, '2022-07-11', '05a9n0jxf');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483643, 1, '2024-04-20', 'eyo6');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483642, 1, '2022-08-11', 'aawg96aqb0tb');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483641, 1, '2020-12-14', '7qk');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (-2147483640, 1, '2020-01-12', 'bymzn2mfx7h3');

INSERT INTO "orders" ("order_id", "customer_id", "order_date", "status") VALUES (4, 4, '2020-01-18', 'qlud8');

-- Inserting into table: orderitems --
INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483648, 1, -1576219117, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483647, 1, 1178636309, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483646, 1, -1390245819, 763.856372);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483645, 1, -1362461264, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483644, 1, -975213201, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483643, 1, -1929953647, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483642, 1, 1575412235, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483641, 1, -155284187, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483640, 2, -566887085, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483639, 1, 564390026, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483638, 1, 1583472758, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483637, 1, -1478247928, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483636, 1, -946046410, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483635, 1, -1538707438, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483634, 2, 1774087382, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483633, 1, 1523825314, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483632, 1, -290314193, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483631, 1, 481546706, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483630, 1, -242584410, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483629, 1, -1139855872, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483628, 2, 2119806856, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483627, 1, -1171104889, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483626, 1, -1950324754, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483625, 1, 1448731351, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483624, 1, -405743609, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483623, 1, -20116244, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483622, 2, -55240145, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483621, 1, -95808609, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483620, 1, -1524425594, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483619, 1, -1428186898, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483618, 1, -1402164108, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (2, -2147483617, 1, 924693315, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483616, 2, -2060082151, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483615, 1, -1122409769, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483614, 1, 1849819405, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483613, 1, 1105964624, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483612, 1, -1165594842, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483611, 1, 270415200, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483610, 1, -2071531094, 407.368744);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483609, 1, 292557306, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483608, 1, 709097796, 270.763563);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483607, 1, -605061107, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483606, 1, -1689155697, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483605, 1, 1056589776, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483604, 1, -360096930, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483603, 1, -795975227, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483602, 1, 1294064538, 361.042997);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483601, 1, 1718516876, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483600, 1, -2076274980, 903.105468);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483599, 1, -1159083009, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483598, 1, -1589605308, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483597, 1, -251205568, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483596, 1, -1216952047, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483595, 1, -841516418, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483594, 1, 152478847, 655.746331);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483593, 1, 1147652228, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483592, 1, 1378873397, 824.293148);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483591, 1, 1964331395, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483590, 1, -1943814113, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483589, 1, 920097188, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483588, 1, 643589729, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483587, 1, -141591627, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483586, 1, 440797047, 116.944655);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483585, 1, -154207334, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483584, 1, 729449685, 942.225143);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483583, 1, -1580984044, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483582, 1, 150596046, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483581, 1, -1853955201, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483580, 1, -891525031, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483579, 1, 1728926031, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483578, 1, -63214972, 207.572242);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483577, 1, 357443379, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483576, 1, -1502591405, 32.2942);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483575, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483574, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483573, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483572, 1, NULL, NULL);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483571, -2147483647, -845136979, 857.029414);

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

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (1, -2147483560, 1, -312228770, 50000.01);

INSERT INTO "orderitems" ("order_id", "item_id", "product_id", "quantity", "unit_price") VALUES (4, -2147483559, 4, 1618264449, 881.656954);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.country_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.region_name, SUM(oi.quantity * oi.unit_price) AS total_sales FROM Regions AS r JOIN Countries AS c ON r.region_id = c.region_id JOIN Locations AS l ON c.region_id = l.country_id JOIN Customers AS cu ON l.location_id = cu.location_id JOIN Orders AS o ON cu.customer_id = o.customer_id JOIN OrderItems AS oi ON o.order_id = oi.order_id JOIN Products AS p ON oi.product_id = p.product_id WHERE cu.credit_limit > 1000 AND p.category = 'Electronics' GROUP BY r.region_name HAVING total_sales > 50000 ORDER BY total_sales DESC, r.region_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('1quik', 1426754104871.8284)
*/