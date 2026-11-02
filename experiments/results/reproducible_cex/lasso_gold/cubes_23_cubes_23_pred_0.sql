-- Schema DDL
CREATE TABLE "i027" ("cname" TEXT, "wmname" TEXT, "avg" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Allison Hill', 'Daniel Wagner', 1001.5);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Noah Rhodes', 'Cristian Santos', 1008.5);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Angie Henderson', 'Connie Lawrence', 1015.5);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Abigail Shaffer', 'Ryan Munoz', 1004.5);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Gina Moore', 'Monica Herrera', 1004.5);
INSERT INTO "i027" ("cname", "wmname", "avg") VALUES ('Gabrielle Davis', 'Jamie Arnold', 1004.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT cname, wmname, avg_other AS maxavg FROM (SELECT LHS.avg AS AVG, LHS.maxavg AS maxavg, RHS.cname AS cname, RHS.wmname AS wmname, RHS.avg AS avg_other FROM (SELECT AVG, MAX(AVG) AS maxavg FROM i027 GROUP BY AVG) AS LHS CROSS JOIN i027 AS RHS) WHERE (AVG <= avg_other AND maxavg <> avg_other) ORDER BY cname, wmname NULLS LAST, maxavg NULLS LAST;

/*
Gold Result:
('Abigail Shaffer', 'Ryan Munoz', 1004.5)
('Angie Henderson', 'Connie Lawrence', 1015.5)
('Gabrielle Davis', 'Jamie Arnold', 1004.5)
('Gina Moore', 'Monica Herrera', 1004.5)
('Noah Rhodes', 'Cristian Santos', 1008.5)
*/

-- Prediction Query
SELECT m.cname, m.wmname, t.mx FROM (SELECT cname, MAX(avg) AS mx FROM i027 GROUP BY cname) AS t JOIN i027 AS m ON m.cname = t.cname AND t.mx = m.avg;

/*
Prediction Result:
('Allison Hill', 'Daniel Wagner', 1001.5)
('Noah Rhodes', 'Cristian Santos', 1008.5)
('Angie Henderson', 'Connie Lawrence', 1015.5)
('Abigail Shaffer', 'Ryan Munoz', 1004.5)
('Gina Moore', 'Monica Herrera', 1004.5)
('Gabrielle Davis', 'Jamie Arnold', 1004.5)
*/