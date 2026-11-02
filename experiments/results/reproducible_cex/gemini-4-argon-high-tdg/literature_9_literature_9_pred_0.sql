-- Schema DDL
CREATE TABLE "user" ("uid" INTEGER, "uname" INTEGER, "city" INTEGER);

CREATE TABLE "picture" ("uid" INTEGER, "size" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO user (uid, uname, city) VALUES (1, 101, 3);
INSERT INTO user (uid, uname, city) VALUES (2, 102, 3);
INSERT INTO user (uid, uname, city) VALUES (3, 103, 3);
INSERT INTO user (uid, uname, city) VALUES (4, 104, 3);
INSERT INTO user (uid, uname, city) VALUES (5, 105, 2);
INSERT INTO user (uid, uname, city) VALUES (6, 106, 4);
INSERT INTO picture (uid, size) VALUES (2, 1000000);
INSERT INTO picture (uid, size) VALUES (2, 500000);
INSERT INTO picture (uid, size) VALUES (3, 1000001);
INSERT INTO picture (uid, size) VALUES (3, 1000000);
INSERT INTO picture (uid, size) VALUES (4, 2000000);
INSERT INTO picture (uid, size) VALUES (4, 3000000);
INSERT INTO picture (uid, size) VALUES (5, 5000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UID, UNAME, IIF(CNT IS NULL, 0, CNT) AS CNT FROM (SELECT X.UID AS UID, X.UNAME FROM USER AS X WHERE X.CITY = 3) AS P LEFT JOIN (SELECT Y.UID AS UID, COUNT(*) AS CNT FROM PICTURE AS Y WHERE Y.SIZE > 1000000 GROUP BY Y.UID) AS Q USING (UID);

/*
Gold Result:
(1, 101, 0)
(2, 102, 0)
(3, 103, 1)
(4, 104, 2)
*/

-- Prediction Query
SELECT X.UID AS UID, X.UNAME AS UNAME, COUNT(*) AS CNT FROM USER AS X CROSS JOIN PICTURE AS Y WHERE X.UID = Y.UID AND Y.SIZE > 1000000 AND X.CITY = 3 GROUP BY X.UID, X.UNAME;

/*
Prediction Result:
(3, 103, 1)
(4, 104, 2)
*/