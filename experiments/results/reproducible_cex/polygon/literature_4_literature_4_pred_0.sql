-- Schema DDL
CREATE TABLE "itp" ("itemn" INTEGER PRIMARY KEY, "ponum" INTEGER);

CREATE TABLE "itl" ("itemn" INTEGER, "wkcen" INTEGER, "locan" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "itp" ("itemn", "ponum") VALUES (15, 29);
INSERT INTO "itp" ("itemn", "ponum") VALUES (16, NULL);
INSERT INTO "itl" ("itemn", "wkcen", "locan") VALUES (25, NULL, NULL);
INSERT INTO "itl" ("itemn", "wkcen", "locan") VALUES (28, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM ITP AS ITP WHERE ITP.ITEMN IN (SELECT ITL.ITEMN FROM ITL AS ITL WHERE ITL.WKCEN = 468 AND ITL.LOCAN = 0);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ITP.* FROM ITP AS ITP CROSS JOIN ITL AS ITL WHERE ITP.ITEMN = ITL.ITEMN AND ITL.WKCEN = 468 AND ITL.LOCAN = 0;

/*
Prediction Result:
*/