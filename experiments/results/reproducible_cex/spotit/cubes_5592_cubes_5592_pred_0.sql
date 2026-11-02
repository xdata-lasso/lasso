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
INSERT INTO CATALOGS VALUES (1, 0, 0, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (8, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (7, 1, 0);
INSERT INTO CATALOG_CONTENTS VALUES (-1, 7, 0, 0, 0, 18, 19, 20, 21, 22, 23, 24, 25, 26);
INSERT INTO CATALOG_CONTENTS VALUES (0, 8, 0, 0, 0, 0, 27, 28, 29, 30, 31, 32, 33, 34);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (8, 0, 0, 39);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (8, 0, 0, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.attribute_id AS attribute_id, LHS.attribute_value AS attribute_value, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id, RHS.previous_entry_id AS previous_entry_id, RHS.next_entry_id AS next_entry_id, RHS.catalog_entry_name AS catalog_entry_name, RHS.product_stock_number AS product_stock_number, RHS.price_in_dollars AS price_in_dollars, RHS.price_in_euros AS price_in_euros, RHS.price_in_pounds AS price_in_pounds, RHS.capacity AS capacity, RHS.length AS LENGTH, RHS.height AS height, RHS.width AS width FROM (SELECT * FROM catalog_contents_additional_attributes WHERE (catalog_level_number = 8)) AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_entry_id = RHS.catalog_entry_id)) ORDER BY catalog_entry_name;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT t1.catalog_entry_name FROM Catalog_Contents AS t1 JOIN Catalog_Contents_Additional_Attributes AS t2 ON t1.catalog_entry_id = t2.catalog_entry_id WHERE t2.catalog_level_number = '8';

/*
Prediction Result:
('0',)
('0',)
*/