-- Schema DDL
CREATE TABLE "i039" ("c" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i039 --
INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES (NULL);

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_226e50');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');

INSERT INTO "i039" ("c") VALUES ('i03_52e5b3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c FROM (SELECT * FROM (SELECT * FROM (SELECT c, MAX(n) AS maxn FROM (SELECT c, COUNT(*) AS n FROM i039 GROUP BY c) GROUP BY c) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('i03_226e50',)
*/

-- Prediction Query
SELECT t2.c FROM (SELECT MAX(cnt) AS maxcnt FROM (SELECT c, COUNT(*) AS cnt FROM i039 GROUP BY c) AS t3) AS t1 JOIN (SELECT c, COUNT(*) AS cnt FROM i039 GROUP BY c) AS t2 ON t1.maxcnt = t2.cnt;

/*
Prediction Result:
('i03_226e50',)
('i03_52e5b3',)
*/