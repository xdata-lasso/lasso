-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1, 'dis_b590e4', '5k5swwqcgs', 171.746906, 557.512061);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (2, 'dis_b590e4', '8c4pgu7vfe', 483.665643, 818.685402);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (3, 'dis_b590e4', 'ri', 710.998147, 945.642658);

INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (4, NULL, 'ypuzhsrw', 944.247544, 994.117864);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
(None,)
('dis_b590e4',)
('dis_b590e4',)
('dis_b590e4',)
*/

-- Prediction Query
SELECT DISTINCT District_name FROM district ORDER BY city_area DESC, District_name NULLS LAST;

/*
Prediction Result:
(None,)
('dis_b590e4',)
*/