-- Schema DDL
CREATE TABLE "i009" ("username" TEXT, "ip" TEXT, "time_stamp" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO i009 (username, ip, time_stamp) VALUES ('alice', '192.168.1.2', 100);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('alice', NULL, 100);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('alice', '192.168.1.1', 100);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('alice', '192.168.1.9', 50);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('bob', '10.0.0.1', 200);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('bob', '10.0.0.1', 200);
INSERT INTO i009 (username, ip, time_stamp) VALUES ('bob', '10.0.0.2', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username, ip, time_stamp FROM (SELECT LHS.username AS username, LHS.time_stamp AS time_stamp, RHS.ip AS ip FROM (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS LHS LEFT JOIN i009 AS RHS ON (LHS.username = RHS.username AND LHS.time_stamp = RHS.time_stamp)) ORDER BY username, ip NULLS LAST, time_stamp NULLS LAST;

/*
Gold Result:
('alice', '192.168.1.1', 100)
('alice', '192.168.1.2', 100)
('alice', None, 100)
('bob', '10.0.0.1', 200)
('bob', '10.0.0.1', 200)
*/

-- Prediction Query
SELECT u.username, u.ip, q.time_stamp FROM i009 AS u JOIN (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS q ON u.username = q.username AND u.time_stamp = q.time_stamp;

/*
Prediction Result:
('alice', '192.168.1.2', 100)
('alice', None, 100)
('alice', '192.168.1.1', 100)
('bob', '10.0.0.1', 200)
('bob', '10.0.0.1', 200)
*/