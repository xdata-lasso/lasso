-- Schema DDL
CREATE TABLE "user" ("uid" INTEGER, "uname" INTEGER, "city" INTEGER);

CREATE TABLE "picture" ("uid" INTEGER, "size" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality: a user in city 3 with no pictures at all, and a user in city 3 with only small/boundary-sized pictures (testing LEFT JOIN + IIF null handling, and WHERE Y.SIZE > 1000000 boundary).
INSERT INTO "user" ("uid", "uname", "city") VALUES (1, 101, 3);
INSERT INTO "user" ("uid", "uname", "city") VALUES (2, 102, 3);
INSERT INTO "picture" ("uid", "size") VALUES (2, 1000000);
INSERT INTO "picture" ("uid", "size") VALUES (2, 500000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UID, UNAME, IIF(CNT IS NULL, 0, CNT) AS CNT FROM (SELECT X.UID AS UID, X.UNAME FROM USER AS X WHERE X.CITY = 3) AS P LEFT JOIN (SELECT Y.UID AS UID, COUNT(*) AS CNT FROM PICTURE AS Y WHERE Y.SIZE > 1000000 GROUP BY Y.UID) AS Q USING (UID);

/*
Gold Result:
(1, 101, 0)
(2, 102, 0)
*/

-- Prediction Query
SELECT X.UID AS UID, X.UNAME AS UNAME, COUNT(*) AS CNT FROM USER AS X CROSS JOIN PICTURE AS Y WHERE X.UID = Y.UID AND Y.SIZE > 1000000 AND X.CITY = 3 GROUP BY X.UID, X.UNAME;

/*
Prediction Result:
*/