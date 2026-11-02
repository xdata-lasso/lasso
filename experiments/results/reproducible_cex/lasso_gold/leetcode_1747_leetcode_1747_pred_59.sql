-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1042, '1986-06-17', '1986-06-17');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1043, '1986-06-17', '1986-06-17');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1041, 1043, '1986-06-18', '1986-06-17');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1057, '1991-11-23', '1991-11-22');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1056, 1058, '1991-11-22', '1991-11-22');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1059, 1060, '1992-01-23', '1992-01-23');
INSERT INTO "loginfo" ("account_id", "ip_address", "login", "logout") VALUES (1059, 1061, '1992-01-24', '1992-01-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
(1041,)
*/

-- Prediction Query
SELECT DISTINCT A.ACCOUNT_ID FROM LOGINFO AS A CROSS JOIN LOGINFO AS B WHERE A.IP_ADDRESS <> B.IP_ADDRESS AND A.ACCOUNT_ID = B.ACCOUNT_ID AND ((A.LOGIN >= B.LOGIN AND A.LOGIN <= B.LOGOUT) OR (B.LOGIN >= A.LOGIN AND B.LOGIN <= A.LOGOUT) OR (A.LOGOUT = B.LOGIN OR B.LOGOUT = A.LOGIN));

/*
Prediction Result:
(1041,)
(1056,)
(1059,)
*/