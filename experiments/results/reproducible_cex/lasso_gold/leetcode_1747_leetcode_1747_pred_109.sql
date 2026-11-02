-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1036, '1994-03-02', '1995-04-03');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1995-04-02', '1994-03-03');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1035, 1037, '1994-03-02', '1994-03-01');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1044, 1045, '1971-09-08', '1971-09-07');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1044, 1046, '1972-10-08', '1971-09-09');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1048, '1973-11-10', '1974-01-11');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1047, 1049, '1974-01-10', '1973-11-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1035,)
(1047,)
*/

-- Prediction Query
WITH CTE AS (SELECT T1.ACCOUNT_ID, T1.IP_ADDRESS AS IP_ADDRESS1, T2.IP_ADDRESS AS IP_ADDRESS2, T1.LOGIN AS LOGIN1, T2.LOGIN AS LOGIN2, T1.LOGOUT AS LOGOUT1, T2.LOGOUT AS LOGOUT2 FROM LOGINFO AS T1 CROSS JOIN LOGINFO AS T2 ON T1.ACCOUNT_ID = T2.ACCOUNT_ID WHERE (T1.LOGIN <> T2.LOGIN OR T1.LOGOUT <> T2.LOGOUT) AND T1.IP_ADDRESS < T2.IP_ADDRESS AND NOT (T1.LOGIN > T2.LOGOUT OR T2.LOGIN > T1.LOGOUT)) SELECT DISTINCT ACCOUNT_ID FROM CTE;

/*
Prediction Result:
(1035,)
*/