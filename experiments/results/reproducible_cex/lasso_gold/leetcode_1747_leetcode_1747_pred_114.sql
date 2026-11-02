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
WITH LOGS_PN AS (SELECT ACCOUNT_ID, IP_ADDRESS, LOGIN, LOGOUT, LAG(LOGOUT) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS PREV_LOGOUT, LAG(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS PREV_IP, LEAD(LOGIN) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGOUT) AS NEXT_LOGIN, LEAD(IP_ADDRESS) OVER (PARTITION BY ACCOUNT_ID ORDER BY LOGIN) AS NEXT_IP FROM LOGINFO) SELECT DISTINCT ACCOUNT_ID FROM LOGS_PN WHERE (CAST(PREV_LOGOUT AS DATETIME) >= CAST(LOGIN AS DATETIME) AND PREV_IP <> IP_ADDRESS) OR (CAST(LOGOUT AS DATETIME) >= CAST(NEXT_LOGIN AS DATETIME) AND IP_ADDRESS <> NEXT_IP);

/*
Prediction Result:
(1035,)
(1044,)
*/