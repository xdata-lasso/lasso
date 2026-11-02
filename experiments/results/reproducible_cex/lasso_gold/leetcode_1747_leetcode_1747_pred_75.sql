-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1057, '1979-06-16', '1980-07-17');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1058, '1980-07-16', '1979-06-17');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1062, 1063, '1983-10-20', NULL);
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1062, 1064, '1984-11-20', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1056,)
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM (SELECT L1.ACCOUNT_ID, CASE WHEN L1.LOGOUT < L2.LOGIN THEN 0 ELSE 1 END AS BANNED FROM LOGINFO AS L1 CROSS JOIN LOGINFO AS L2 WHERE L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND L1.LOGIN <= L2.LOGIN) AS SUB WHERE BANNED = 1;

/*
Prediction Result:
(1056,)
(1062,)
*/