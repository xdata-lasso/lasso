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
SELECT DISTINCT L.ACCOUNT_ID FROM LOGINFO AS L JOIN LOGINFO AS R ON L.ACCOUNT_ID = R.ACCOUNT_ID AND L.LOGIN <= R.LOGOUT AND L.LOGOUT >= R.LOGIN AND L.IP_ADDRESS <> R.IP_ADDRESS;

/*
Prediction Result:
(1035,)
*/