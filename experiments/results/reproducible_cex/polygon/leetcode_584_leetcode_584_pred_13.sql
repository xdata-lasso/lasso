-- Schema DDL
CREATE TABLE "customer" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "referee_id" INTEGER, FOREIGN KEY ("referee_id") REFERENCES "customer" ("id"), CHECK ("referee_id" <> 'customer.id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customer" ("id", "name", "referee_id") VALUES (9, NULL, 2);
INSERT INTO "customer" ("id", "name", "referee_id") VALUES (2, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT C1.NAME AS NAME FROM CUSTOMER AS C1 LEFT JOIN CUSTOMER AS C2 ON C1.REFEREE_ID = C2.ID WHERE C2.NAME IS NULL OR C2.ID <> 2;

/*
Prediction Result:
(None,)
(None,)
*/