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
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (1, 0, 0);
INSERT INTO ATTRIBUTE_DEFINITIONS VALUES (0, 0, 0);
INSERT INTO CATALOGS VALUES (-1, 0, 0, 0, 0);
INSERT INTO CATALOGS VALUES (0, 0, 0, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (-1, 0, 0);
INSERT INTO CATALOG_STRUCTURE VALUES (0, 0, 0);
INSERT INTO CATALOG_CONTENTS VALUES (-1, -1, 0, 0, 0, 25, 26, 0, 23, 27, 28, 29, 30, 31);
INSERT INTO CATALOG_CONTENTS VALUES (0, 0, 0, 0, 0, 0, 16, 0, 24, 17, 18, 19, 20, 21);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (-1, 0, 0, 0);
INSERT INTO CATALOG_CONTENTS_ADDITIONAL_ATTRIBUTES VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.price_in_euros AS price_in_euros_other FROM catalog_contents AS LHS INNER JOIN (SELECT next_entry_id, price_in_euros, MAX(price_in_dollars) AS price_in_dollars FROM catalog_contents GROUP BY next_entry_id, price_in_euros) AS RHS ON (LHS.catalog_entry_id = RHS.next_entry_id AND LHS.price_in_dollars = RHS.price_in_dollars)) ORDER BY catalog_entry_name;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('25',)
*/