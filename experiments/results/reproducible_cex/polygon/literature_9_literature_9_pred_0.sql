-- Schema DDL
CREATE TABLE "user" ("uid" INTEGER, "uname" INTEGER, "city" INTEGER);

CREATE TABLE "picture" ("uid" INTEGER, "size" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "user" ("uid", "uname", "city") VALUES (31, NULL, 3);
INSERT INTO "user" ("uid", "uname", "city") VALUES (20, 21, 3);
INSERT INTO "user" ("uid", "uname", "city") VALUES (31, 22, 3);
INSERT INTO "picture" ("uid", "size") VALUES (31, 1000001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UID, UNAME, IIF(CNT IS NULL, 0, CNT) AS CNT FROM (SELECT X.UID AS UID, X.UNAME FROM USER AS X WHERE X.CITY = 3) AS P LEFT JOIN (SELECT Y.UID AS UID, COUNT(*) AS CNT FROM PICTURE AS Y WHERE Y.SIZE > 1000000 GROUP BY Y.UID) AS Q USING (UID);

/*
Gold Result:
(31, None, 1)
(20, 21, 0)
(31, 22, 1)
*/

-- Prediction Query
SELECT X.UID AS UID, X.UNAME AS UNAME, COUNT(*) AS CNT FROM USER AS X CROSS JOIN PICTURE AS Y WHERE X.UID = Y.UID AND Y.SIZE > 1000000 AND X.CITY = 3 GROUP BY X.UID, X.UNAME;

/*
Prediction Result:
(31, None, 1)
(31, 22, 1)
*/