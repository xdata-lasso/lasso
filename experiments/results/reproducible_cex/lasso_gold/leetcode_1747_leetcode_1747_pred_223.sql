-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1036, '1993-02-01', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1993-02-01', '1994-03-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1994-03-03', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1044, 1045, '1971-09-09', '1970-08-08');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1044, 1046, '1970-08-07', '1971-09-08');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1048, '1972-10-09', '1972-10-10');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1973-11-11', '1973-11-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1035,)
*/

-- Prediction Query
WITH BASE AS (SELECT DISTINCT L1.ACCOUNT_ID AS ID1, CASE WHEN NOT L2.ACCOUNT_ID IS NULL OR NOT L3.ACCOUNT_ID IS NULL THEN 1 ELSE 0 END AS FLAG FROM LOGINFO AS L1 LEFT JOIN LOGINFO AS L2 ON L2.ACCOUNT_ID = L1.ACCOUNT_ID AND L2.LOGIN BETWEEN L1.LOGIN AND L1.LOGOUT AND L1.IP_ADDRESS <> L2.IP_ADDRESS LEFT JOIN LOGINFO AS L3 ON L3.ACCOUNT_ID = L1.ACCOUNT_ID AND L3.LOGOUT BETWEEN L1.LOGIN AND L1.LOGOUT AND L1.IP_ADDRESS <> L3.IP_ADDRESS) SELECT ID1 AS ACCOUNT_ID FROM BASE WHERE FLAG = 1;

/*
Prediction Result:
(1035,)
(1044,)
*/