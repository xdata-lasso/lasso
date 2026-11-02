-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1, 'dis_ea2efd', '5k5swwqcgs', NULL, 10.0);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (-2147483647, 'dis_ea2efd', '9n8', NULL, 10.0);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (2, '4', 'gu7v', 100000.0, 86.520366);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (3, '4h', 'ia2yp', 100000.01, 10.0);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (4, 'uzhsrwbbp6lu', 'hvdlttilbnpr', 100000.0, 9.99);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (5, 'dpos', 'ie5', 100000.01, 9.99);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (6, 'nw6klf', 'a9000t5c4eci', NULL, 9.99);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (7, 'gce376nium52', 'zbuo4nrqrof', 100000.0, NULL);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (8, 'qyp5s5bbp0', '2eutliqa11r', 100000.01, NULL);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (9, 'ytoo3o9', 'l7', NULL, NULL);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (10, NULL, 'klex14ji', NULL, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district WHERE (city_area >= 10.0 OR city_population <= 100000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
(None,)
('4',)
('4h',)
('dis_ea2efd',)
('dis_ea2efd',)
('gce376nium52',)
('uzhsrwbbp6lu',)
*/

-- Prediction Query
SELECT district_name FROM district WHERE city_area > 10 OR City_Population > 100000;

/*
Prediction Result:
('4',)
('4h',)
('dpos',)
('qyp5s5bbp0',)
*/