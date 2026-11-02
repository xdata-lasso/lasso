-- Schema DDL
CREATE TABLE "i009" ("username" TEXT, "ip" TEXT, "time_stamp" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i009 --
INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', '5k5swwqcgs', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', '9n8', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', '4', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('gu7v', 'rhs_76dabb', -1865039888);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'hria2ypuzhs', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'rwbbp6luhvd', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'tti', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('bnp', 'rhs_76dabb', 1236688122);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('dpos', 'rhs_47f787', -1576219117);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, '5u', 1861536320);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, '6klfa9', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, '00t5c4e', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, 'cigce376nium', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES (NULL, 'rhs_76dabb', 283598170);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('zbuo4nrq', NULL, 418417917);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', NULL, 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', NULL, NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', NULL, NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('fqyp', 'rhs_76dabb', -921187550);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'bbp02eutliqa', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', '1ryytoo', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'o9hl72kl', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('x1', 'rhs_76dabb', -74849714);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', '7zw', 1);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'au2dwyrq13', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('i00_9b5fad', 'yu78', NULL);

INSERT INTO "i009" ("username", "ip", "time_stamp") VALUES ('9', 'rhs_76dabb', 244829661);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username, ip, time_stamp FROM (SELECT LHS.username AS username, LHS.time_stamp AS time_stamp, RHS.ip AS ip FROM (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS LHS LEFT JOIN i009 AS RHS ON (LHS.username = RHS.username AND LHS.time_stamp = RHS.time_stamp)) ORDER BY username, ip NULLS LAST, time_stamp NULLS LAST;

/*
Gold Result:
(None, None, 1861536320)
('9', 'rhs_76dabb', 244829661)
('bnp', 'rhs_76dabb', 1236688122)
('dpos', 'rhs_47f787', -1576219117)
('fqyp', 'rhs_76dabb', -921187550)
('gu7v', 'rhs_76dabb', -1865039888)
('i00_9b5fad', '4', 1)
('i00_9b5fad', '5k5swwqcgs', 1)
('i00_9b5fad', '7zw', 1)
('i00_9b5fad', '9n8', 1)
('i00_9b5fad', 'bbp02eutliqa', 1)
('i00_9b5fad', 'hria2ypuzhs', 1)
('i00_9b5fad', 'rwbbp6luhvd', 1)
('i00_9b5fad', 'tti', 1)
('i00_9b5fad', None, 1)
('x1', 'rhs_76dabb', -74849714)
('zbuo4nrq', None, 418417917)
*/

-- Prediction Query
SELECT u.username, u.ip, q.time_stamp FROM i009 AS u JOIN (SELECT username, MAX(time_stamp) AS time_stamp FROM i009 GROUP BY username) AS q ON u.username = q.username AND u.time_stamp = q.time_stamp;

/*
Prediction Result:
('i00_9b5fad', '5k5swwqcgs', 1)
('i00_9b5fad', '9n8', 1)
('i00_9b5fad', '4', 1)
('gu7v', 'rhs_76dabb', -1865039888)
('i00_9b5fad', 'hria2ypuzhs', 1)
('i00_9b5fad', 'rwbbp6luhvd', 1)
('i00_9b5fad', 'tti', 1)
('bnp', 'rhs_76dabb', 1236688122)
('dpos', 'rhs_47f787', -1576219117)
('zbuo4nrq', None, 418417917)
('i00_9b5fad', None, 1)
('fqyp', 'rhs_76dabb', -921187550)
('i00_9b5fad', 'bbp02eutliqa', 1)
('x1', 'rhs_76dabb', -74849714)
('i00_9b5fad', '7zw', 1)
('9', 'rhs_76dabb', 244829661)
*/