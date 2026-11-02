-- Schema DDL
CREATE TABLE "i027" ("cname" TEXT, "wmname" TEXT, "avg" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('20', '21', -715);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES (NULL, '16', -715);
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
('20', '21', -715.0)
*/