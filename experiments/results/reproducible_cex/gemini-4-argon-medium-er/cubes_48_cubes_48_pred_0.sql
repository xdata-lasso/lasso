-- Schema DDL
CREATE TABLE "i009" ("username" TEXT, "ip" TEXT, "time_stamp" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('a', '1.1.1.1', NULL);
INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, '2.2.2.2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username, ip, time_stamp FROM (SELECT LHS.username AS username, LHS.time_stamp AS time_stamp, RHS.ip AS ip FROM (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS LHS LEFT JOIN i009 AS RHS ON (LHS.username = RHS.username AND LHS.time_stamp = RHS.time_stamp)) ORDER BY username, ip NULLS LAST, time_stamp NULLS LAST;

/*
Gold Result:
(None, None, 1)
('a', None, None)
*/

-- Prediction Query
SELECT u.username, u.ip, q.time_stamp FROM i009 AS u JOIN (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS q ON u.username = q.username AND u.time_stamp = q.time_stamp;

/*
Prediction Result:
*/