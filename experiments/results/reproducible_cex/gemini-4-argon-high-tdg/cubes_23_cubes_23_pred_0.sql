-- Schema DDL
CREATE TABLE "i027" ("cname" TEXT, "wmname" TEXT, "avg" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i027 (cname, wmname, avg) VALUES ('c1', 'w1', 10.0);
INSERT INTO i027 (cname, wmname, avg) VALUES ('c2', 'w2', 20.0);
INSERT INTO i027 (cname, wmname, avg) VALUES ('c3', 'w3', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cname, wmname, avg_other AS maxavg FROM (SELECT LHS.avg AS AVG, LHS.maxavg AS maxavg, RHS.cname AS cname, RHS.wmname AS wmname, RHS.avg AS avg_other FROM (SELECT AVG, MAX(AVG) AS maxavg FROM i027 GROUP BY AVG) AS LHS CROSS JOIN i027 AS RHS) WHERE (AVG <= avg_other AND maxavg <> avg_other) ORDER BY cname, wmname NULLS LAST, maxavg NULLS LAST;

/*
Gold Result:
('c2', 'w2', 20.0)
('c3', 'w3', 30.0)
*/

-- Prediction Query
SELECT m.cname, m.wmname, t.mx FROM (SELECT cname, MAX(avg) AS mx FROM i027 GROUP BY cname) AS t JOIN i027 AS m ON m.cname = t.cname AND t.mx = m.avg;

/*
Prediction Result:
('c1', 'w1', 10.0)
('c2', 'w2', 20.0)
('c3', 'w3', 30.0)
*/