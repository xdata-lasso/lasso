-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (17, 19, '1000-08-27', '1000-08-28');
INSERT INTO "LogInfo" ("account_id", "ip_address", "login", "logout") VALUES (NULL, 19, '1000-08-28', '1000-08-29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.ACCOUNT_ID FROM LOGINFO AS A CROSS JOIN LOGINFO AS B ON A.ACCOUNT_ID = B.ACCOUNT_ID AND A.IP_ADDRESS <> B.IP_ADDRESS WHERE A.LOGIN BETWEEN (B.LOGIN) AND (B.LOGOUT) ORDER BY A.ACCOUNT_ID ASC;

/*
Prediction Result:
*/