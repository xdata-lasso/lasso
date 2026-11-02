-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1, '5k5swwqcgs', '9n8', '4', -734455130, '4h');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483647, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 2087640001, 'dposiie5unw');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483646, 'q_2_e55aa6', 'klfa9000t', 'c4ecigce', -1585009206, '52zb');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483645, 'q_2_e55aa6', 'uo4nrqrofqy', '5s5b', 2107872094, '02eutliqa11r');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483644, 'q_2_e55aa6', 'ytoo3o9', 'l7', 1178636309, 'ex1');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (2, 'ji7zwau2', 'dwyrq13pyu78', '9', 244829661, 'jsl');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (3, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -283454505, '9uxj4hw');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (4, 'd', 'lph2gn', 'q', -664193365, 'cx5hn');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483640, 'q_2_e55aa6', 'p', 'jtu0d', 401805964, 'gq8');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483639, 'q_2_e55aa6', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, '6vck6ah0f8js');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483638, 'q_2_e55aa6', 'wlq7xb', '72fxa7ryfd', 564390026, '6nijjai5dh');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (5, 'ogrgjd8y', 't1afgog', 'itsj3', -491938169, '1q43');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (6, '1jh3den', 'c68x8vacx', 'afu5w1of7', 76996700, 'o72ctdc');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (7, 'mfg62', '0v', 'q8qdjpe1', -1180042408, '78507cvt');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483634, 'q_2_e55aa6', 'ptt', '6b', -1171104889, '5zi36c4bfkfo');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483633, 'q_2_e55aa6', 'c', '0', 76987628, 'zezjo7wg');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (-2147483632, 'q_2_e55aa6', 'd5ysxc', 'r0oz', -870767087, 'j5');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (8, '3lq', '5lnpim5k58qs', '7p2r94gt', 1273687251, '2mnajjla3o');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (9, 'v8u', 'tmu2n', '57', -1402164108, 'yz7zzb');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (10, '8y', 'kv42q7', 'x58b4', -1122409769, 'u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, name, LOCATION, district, number_products, manager_name, AVG(number_products) OVER () AS meannumber_products FROM shop) ORDER BY number_products DESC) LIMIT 3);

/*
Gold Result:
('q_2_e55aa6',)
('ia2yp',)
('3lq',)
*/

-- Prediction Query
SELECT name FROM shop WHERE number_products > (SELECT AVG(number_products) FROM shop);

/*
Prediction Result:
('ia2yp',)
('q_2_e55aa6',)
('q_2_e55aa6',)
('q_2_e55aa6',)
('q_2_e55aa6',)
('q_2_e55aa6',)
('q_2_e55aa6',)
('ji7zwau2',)
('1jh3den',)
('3lq',)
*/