-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (2, '5k5swwqcgs', 'sho_c4d701', '9n8', 1610062532, 'pgu7vfe4');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (3, 'hria2ypuzhs', 'sho_c4d701', 'rwbbp6luhvd', -1377057208, 'ilbnp');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (4, 'mdpos', 'ie5', 'nw6klf', 1038707349, '9000t5c4ec');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (5, 'gce', '76nium52', 'zbuo4nrqrof', 373262291, 'p5s5bbp');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (6, '02eutliqa11r', 'ytoo3o9', 'l7', 1178636309, 'ex1');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (7, 'ji7zwau2', 'dwyrq13pyu78', '9', 244829661, 'jsl');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (8, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', -283454505, '9uxj4hw');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (9, 'd', 'lph2gn', 'q', -664193365, 'cx5hn');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (10, 'p', 'jtu0d', '79fjgq8', -1255130038, '3d');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (11, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -658391922, 'q7x');

INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (12, '7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 'rg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_location_ FROM (SELECT COUNT(*) AS n FROM shop) ORDER BY count_distinct_location_;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LOCATION) FROM shop;

/*
Prediction Result:
(10,)
*/