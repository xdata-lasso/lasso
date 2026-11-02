-- Schema DDL
CREATE TABLE "ORDERS" (
    "O_ID" INT,
    "O_DATE" DATE,
    PRIMARY KEY ("O_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ORDERS VALUES (0, '1997-07-01');
INSERT INTO ORDERS VALUES (1, '1997-07-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT o_id FROM orders WHERE o_date > '1997-07-01' AND o_date < '1997-10-01';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT o_id FROM orders WHERE o_date >= '1997-07-01' AND o_date < '1997-10-01';

/*
Prediction Result:
(0,)
(1,)
*/