-- Schema DDL
CREATE TABLE "i039" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i039" ("c") VALUES ('a');
INSERT INTO "i039" ("c") VALUES ('b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c FROM (SELECT * FROM (SELECT * FROM (SELECT c, MAX(n) AS maxn FROM (SELECT c, COUNT(*) AS n FROM i039 GROUP BY c) GROUP BY c) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('a',)
*/

-- Prediction Query
SELECT t2.c FROM (SELECT MAX(cnt) AS maxcnt FROM (SELECT c, COUNT(*) AS cnt FROM i039 GROUP BY c) AS t3) AS t1 JOIN (SELECT c, COUNT(*) AS cnt FROM i039 GROUP BY c) AS t2 ON t1.maxcnt = t2.cnt;

/*
Prediction Result:
('a',)
('b',)
*/