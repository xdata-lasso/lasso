-- Schema DDL
CREATE TABLE "LogInfo" ("account_id" INTEGER, "ip_address" INTEGER, "login" DATE, "logout" DATE, CHECK ("login" < 'LogInfo.logout'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 1, '2020-01-01', '2020-01-10');
INSERT INTO LogInfo (account_id, ip_address, login, logout) VALUES (1, 2, NULL, '2020-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT I1.ACCOUNT_ID FROM LOGINFO AS I1 JOIN LOGINFO AS I2 ON (I1.ACCOUNT_ID = I2.ACCOUNT_ID AND I1.IP_ADDRESS <> I2.IP_ADDRESS AND I2.LOGIN BETWEEN I1.LOGIN AND I1.LOGOUT);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACCOUNT_ID FROM LOGINFO AS L WHERE EXISTS(SELECT ACCOUNT_ID FROM LOGINFO WHERE (ACCOUNT_ID = L.ACCOUNT_ID AND IP_ADDRESS <> L.IP_ADDRESS) AND ((LOGIN >= L.LOGIN AND LOGIN <= L.LOGOUT) OR (LOGOUT >= L.LOGIN AND LOGOUT <= L.LOGOUT) OR (LOGIN <= L.LOGIN AND LOGOUT >= L.LOGOUT)));

/*
Prediction Result:
(1,)
*/