-- Schema DDL
CREATE TABLE "ATTRIBUTE_DEFINITIONS" (
    "ATTRIBUTE_ID" INT,
    "ATTRIBUTE_NAME" TEXT,
    "ATTRIBUTE_DATA_TYPE" TEXT,
    PRIMARY KEY ("ATTRIBUTE_ID")
);
CREATE TABLE "CATALOGS" (
    "CATALOG_ID" INT,
    "CATALOG_NAME" TEXT,
    "CATALOG_PUBLISHER" TEXT,
    "DATE_OF_PUBLICATION" DATETIME,
    "DATE_OF_LATEST_REVISION" DATETIME,
    PRIMARY KEY ("CATALOG_ID")
);
CREATE TABLE "CATALOG_STRUCTURE" (
    "CATALOG_LEVEL_NUMBER" INT,
    "CATALOG_ID" INT,
    "CATALOG_LEVEL_NAME" TEXT,
    PRIMARY KEY ("CATALOG_LEVEL_NUMBER"),
    FOREIGN KEY ("CATALOG_ID") REFERENCES "CATALOGS"("CATALOG_ID")
);
CREATE TABLE "CATALOG_CONTENTS" (
    "CATALOG_ENTRY_ID" INT,
    "CATALOG_LEVEL_NUMBER" INT,
    "PARENT_ENTRY_ID" INT,
    "PREVIOUS_ENTRY_ID" INT,
    "NEXT_ENTRY_ID" INT,
    "CATALOG_ENTRY_NAME" TEXT,
    "PRODUCT_STOCK_NUMBER" TEXT,
    "PRICE_IN_DOLLARS" FLOAT,
    "PRICE_IN_EUROS" FLOAT,
    "PRICE_IN_POUNDS" FLOAT,
    "CAPACITY" TEXT,
    "LENGTH" TEXT,
    "HEIGHT" TEXT,
    "WIDTH" TEXT,
    PRIMARY KEY ("CATALOG_ENTRY_ID"),
    FOREIGN KEY ("CATALOG_LEVEL_NUMBER") REFERENCES "CATALOG_STRUCTURE"("CATALOG_LEVEL_NUMBER")
);
CREATE TABLE "CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES" (
    "CATALOG_LEVEL_NUMBER" INT,
    "CATALOG_ENTRY_ID" INT,
    "ATTRIBUTE_ID" INT,
    "ATTRIBUTE_VALUE" TEXT,
    FOREIGN KEY ("CATALOG_LEVEL_NUMBER") REFERENCES "CATALOG_STRUCTURE"("CATALOG_LEVEL_NUMBER"),
    FOREIGN KEY ("CATALOG_ENTRY_ID") REFERENCES "CATALOG_CONTENTS"("CATALOG_ENTRY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (-1, 0, 0);
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (0, 0, 0);
INSERT INTO CATALOGS VALUES (0, 0, 0, 0, 0);
INSERT INTO CATALOGS VALUES (-1, 0, 0, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (-1, -1, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (0, 0, 0);
INSERT INTO CATALOG_CONTENTS VALUES (-1, 0, 0, 0, 0, 0, 20, 21, 22, 23, 0, 24, 0, 25);
INSERT INTO CATALOG_CONTENTS VALUES (0, -1, 0, 0, 0, -1, 26, 27, 28, 29, 0, 30, 0, 31);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (0, -1, 0, 0);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (-1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name_other AS catalog_entry_name FROM (SELECT catalog_level_number AS catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_level_number = RHS.catalog_entry_id AND LHS.capacity = RHS.height))) ORDER BY catalog_entry_name;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY height DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/