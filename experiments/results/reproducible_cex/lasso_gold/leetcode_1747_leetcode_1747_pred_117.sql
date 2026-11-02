-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1048, '1986-06-17', '1986-06-18');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1986-06-17', '1986-06-18');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1986-06-17', '1986-06-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1068, 1069, '1993-02-01', '1993-01-31');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1068, 1070, '1993-02-01', '1993-02-02');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1071, 1072, '1994-03-02', '1994-03-03');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1071, 1073, '1994-03-02', '1994-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1047,)
(1068,)
(1071,)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN ASC) AS LOGIN_RK FROM LOGINFO), TEMP1 AS (SELECT T1.ACCOUNT_ID, T1.IP_ADDRESS, T1.LOGIN, T1.LOGOUT, T2.IP_ADDRESS AS LAST_IP_ADDRESS, T2.LOGOUT AS LAST_LOGOUT FROM TEMP AS T1 LEFT JOIN TEMP AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID AND T1.LOGIN_RK - 1 = T2.LOGIN_RK) SELECT DISTINCT ACCOUNT_ID FROM TEMP1 WHERE LOGIN <= LAST_LOGOUT AND IP_ADDRESS <> LAST_IP_ADDRESS;

/*
Prediction Result:
(1047,)
(1071,)
*/