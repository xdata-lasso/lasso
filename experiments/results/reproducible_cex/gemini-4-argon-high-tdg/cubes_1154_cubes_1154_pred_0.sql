-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'LaserJet', '10x10x10', 600.0, 20.0, 'A0_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'DeskJet', NULL, NULL, NULL, 'A_correct', NULL);
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'LaserJet', '12x12x12', 1200.0, 30.0, 'C_correct', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'OfficeJet', '11x11x11', 600.0, 15.0, 'X_wrong', 'WiFi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (5, 'WorkForce', '15x15x15', 2400.0, 40.0, 'B_correct', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (6, 'LaserJet', '14x14x14', 600.0, 25.0, 'Z0_wrong', 'WiFi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (7, 'DeskJet', '9x9x9', 300.0, 10.0, 'M_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (8, 'Pixma', '8x8x8', 600.0, 12.0, 'P1_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (9, 'Pixma', '8x8x8', 600.0, 12.0, 'P2_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (10, 'Pixma', '8x8x8', 600.0, 12.0, 'P3_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (11, 'Pixma', '8x8x8', 600.0, 12.0, 'P4_wrong', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (12, 'WorkForce', '15x15x15', 1200.0, 35.0, 'W1_wrong', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (13, 'WorkForce', '15x15x15', 1200.0, 35.0, 'W2_wrong', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (14, 'WorkForce', '15x15x15', 1200.0, 35.0, 'W3_wrong', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (15, 'WorkForce', '15x15x15', 1200.0, 35.0, 'W4_wrong', 'Ethernet');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT LHS.product_id AS product_id, LHS.product AS product, LHS.dimensions AS dimensions, LHS.dpi AS dpi, LHS.pages_per_minute_color AS pages_per_minute_color, LHS.max_page_size AS max_page_size, LHS.interface AS interface FROM product AS LHS INNER JOIN (SELECT product, COUNT(*) AS n FROM product GROUP BY product) AS RHS ON (LHS.product_id = RHS.n AND LHS.product = RHS.product)) ORDER BY max_page_size;

/*
Gold Result:
('A_correct',)
('B_correct',)
('C_correct',)
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1;

/*
Prediction Result:
('A0_wrong',)
*/