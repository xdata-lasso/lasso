-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 475.173408);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (-1, 'u7', 'fe4hri', 710.998147, 0.5);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (0, '2', 'puzhsrw', 944.247544, 0.0);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (-2147483645, 'p', 'luhvdltti', 182.319045, 998.421621);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (2, '5k5swwqcgs', '9n8', 1.0, 874.871895);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (3, 'pgu7vfe4', 'hria2ypuzhs', 1.0, 663.049759);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (4, 'wbbp6luhvdlt', 'ilbnp', 787.938887, 986.066566);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (5, 'dposiie5unw', 'klfa9000t', 827.854302, 983.124993);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (6, '4', 'ecigce376n', 805.746877, 322.782838);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (7, '52zbuo4nrq', 'rofqyp5s5b', 22.720462, 990.777211);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (8, '02eutliqa11r', 'ytoo3o9', 111.926013, 731.301441);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (9, '72klex14ji7z', 'au2dwy', 278.010437, 433.533777);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (10, 'pyu78d99', 'ljsl0', 27.036693, 884.000446);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumcity_population AS sum_city_population_ FROM (SELECT SUM(city_population) AS sumcity_population FROM (SELECT * FROM district WHERE (city_population > 3.0))) ORDER BY sum_city_population_;

/*
Gold Result:
(5573.670302,)
*/

-- Prediction Query
SELECT SUM(city_population) FROM district ORDER BY city_area DESC, district.district_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(5575.670302,)
*/