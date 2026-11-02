-- Schema DDL
CREATE TABLE "PRODUCT" (
    "PRODUCT_ID" INT,
    "PRODUCT_NAME" TEXT,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "STORE" (
    "STORE_ID" INT,
    "STORE_NAME" TEXT,
    PRIMARY KEY ("STORE_ID")
);
CREATE TABLE "STORE_PRODUCT" (
    "STORE_ID" INT,
    "PRODUCT_ID" INT,
    PRIMARY KEY ("STORE_ID", "PRODUCT_ID"),
    FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCT"("PRODUCT_ID"),
    FOREIGN KEY ("STORE_ID") REFERENCES "STORE"("STORE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PRODUCT VALUES (-1, 10);
INSERT INTO PRODUCT VALUES (0, 11);
INSERT INTO STORE VALUES (0, 1088464336713759545);
INSERT INTO STORE VALUES (1, 9);
INSERT INTO STORE_PRODUCT VALUES (0, -1);
INSERT INTO STORE_PRODUCT VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name <> 'Miramichi';

/*
Gold Result:
('10',)
('11',)
*/

-- Prediction Query
SELECT product_name FROM product JOIN store_product ON product.product_id = store_product.Product_ID JOIN store ON store_product.Store_ID = store.Store_ID WHERE Store_Name = 'Miramichi';

/*
Prediction Result:
*/