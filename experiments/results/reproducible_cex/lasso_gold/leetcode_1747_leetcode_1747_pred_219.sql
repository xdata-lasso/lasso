-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1042, '1984-04-15', '1984-04-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1043, '1984-04-15', '1984-04-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1043, '1984-04-17', '1984-04-16');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1057, '1989-09-22', '1989-09-21');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1058, '1989-09-20', '1989-09-21');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1059, 1060, '1990-10-21', '1990-10-22');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1059, 1061, '1990-10-23', '1990-10-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1041,)
*/

-- Prediction Query
SELECT DISTINCT L1.ACCOUNT_ID FROM LOGINFO AS L1 JOIN LOGINFO AS L2 ON L1.ACCOUNT_ID = L2.ACCOUNT_ID AND L1.IP_ADDRESS <> L2.IP_ADDRESS AND ((L2.LOGIN BETWEEN L1.LOGIN AND L1.LOGOUT) OR (L2.LOGOUT BETWEEN L1.LOGOUT AND L1.LOGOUT));

/*
Prediction Result:
(1041,)
(1056,)
(1059,)
*/