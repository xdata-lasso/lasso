-- Schema DDL
CREATE TABLE "i027" ("cname" TEXT, "wmname" TEXT, "avg" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i027 --
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('5k5swwqcgs', '9n8', 1.0);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('4', 'gu7v', 1.0);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('e4', 'hria2ypuzhs', 1.0);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('rwbbp6luhvd', 'tti', 1.0);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('rhs_6fd612', 'rhs_cce2af', 1.0);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('bnp', 'mdpos', NULL);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('ie5', 'nw6klf', NULL);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('a9000t5c4eci', 'gce376nium52', NULL);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('zbuo4nrqrof', 'qyp5s5bbp0', NULL);

INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('rhs_6fd612', 'rhs_cce2af', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cname, wmname, avg_other AS maxavg FROM (SELECT LHS.avg AS AVG, LHS.maxavg AS maxavg, RHS.cname AS cname, RHS.wmname AS wmname, RHS.avg AS avg_other FROM (SELECT AVG, MAX(AVG) AS maxavg FROM i027 GROUP BY AVG) AS LHS CROSS JOIN i027 AS RHS) WHERE (AVG <= avg_other AND maxavg <> avg_other) ORDER BY cname, wmname NULLS LAST, maxavg NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT m.cname, m.wmname, t.mx FROM (SELECT cname, MAX(avg) AS mx FROM i027 GROUP BY cname) AS t JOIN i027 AS m ON m.cname = t.cname AND t.mx = m.avg;

/*
Prediction Result:
('5k5swwqcgs', '9n8', 1.0)
('4', 'gu7v', 1.0)
('e4', 'hria2ypuzhs', 1.0)
('rwbbp6luhvd', 'tti', 1.0)
('rhs_6fd612', 'rhs_cce2af', 1.0)
*/