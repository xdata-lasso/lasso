-- Schema DDL
CREATE TABLE "I027" (
    "CNAME" TEXT,
    "WMNAME" TEXT,
    "AVG" FLOAT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I027 VALUES (3, 4, 0);
INSERT INTO I027 VALUES (1, -2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cname, wmname, avg_other AS maxavg FROM (SELECT LHS.avg AS AVG, LHS.maxavg AS maxavg, RHS.cname AS cname, RHS.wmname AS wmname, RHS.avg AS avg_other FROM (SELECT AVG, MAX(AVG) AS maxavg FROM i027 GROUP BY AVG) AS LHS CROSS JOIN i027 AS RHS) WHERE (AVG <= avg_other AND maxavg <> avg_other) ORDER BY cname, wmname NULLS LAST, maxavg NULLS LAST;

/*
Gold Result:
('1', '-2', 1.0)
*/

-- Prediction Query
SELECT m.cname, m.wmname, t.mx FROM (SELECT cname, MAX(avg) AS mx FROM i027 GROUP BY cname) AS t JOIN i027 AS m ON m.cname = t.cname AND t.mx = m.avg;

/*
Prediction Result:
('3', '4', 0.0)
('1', '-2', 1.0)
*/