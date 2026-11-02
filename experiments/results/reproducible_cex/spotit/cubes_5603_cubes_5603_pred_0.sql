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
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (0, 0, 0);
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (-1, 0, 0);
INSERT INTO CATALOGS VALUES (-1, 0, 0, 0, 0);
INSERT INTO CATALOGS VALUES (-2, 0, 0, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (1, -2, 40);
INSERT INTO CATALOG_STRUCTURE VALUES (-1, -1, -2);
INSERT INTO CATALOG_CONTENTS VALUES (-1, -1, 0, 0, 0, 32, 33, 1, 34, 35, 36, 37, 38, 39);
INSERT INTO CATALOG_CONTENTS VALUES (0, 1, 0, 0, 0, 41, 42, 0, 43, 44, 45, 46, 47, 48);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (1, -1, 0, 0);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (-1, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_level_name FROM (SELECT catalog_level_number, catalog_id, catalog_level_name, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number AS catalog_entry_id FROM (SELECT LHS.catalog_level_number AS catalog_level_number, LHS.catalog_id AS catalog_id, LHS.catalog_level_name AS catalog_level_name, RHS.parent_entry_id AS parent_entry_id, RHS.previous_entry_id AS previous_entry_id, RHS.next_entry_id AS next_entry_id, RHS.catalog_entry_name AS catalog_entry_name, RHS.product_stock_number AS product_stock_number, RHS.price_in_dollars AS price_in_dollars, RHS.price_in_euros AS price_in_euros, RHS.price_in_pounds AS price_in_pounds, RHS.capacity AS capacity, RHS.length AS LENGTH, RHS.height AS height, RHS.width AS width FROM catalog_structure AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_level_number = RHS.catalog_entry_id AND LHS.catalog_id = RHS.catalog_level_number))) ORDER BY catalog_level_name;

/*
Gold Result:
('-2',)
*/

-- Prediction Query
SELECT t2.catalog_level_name FROM catalog_contents AS t1 JOIN catalog_structure AS t2 ON t1.catalog_level_number = t2.catalog_level_number ORDER BY t1.price_in_dollars, t1.catalog_entry_id NULLS LAST, t2.catalog_level_number NULLS LAST LIMIT 1;

/*
Prediction Result:
('40',)
*/