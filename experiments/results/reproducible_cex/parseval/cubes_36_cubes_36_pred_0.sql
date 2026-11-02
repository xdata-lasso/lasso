-- Schema DDL
CREATE TABLE "i054" ("created_at" TEXT, "count" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i054 --
INSERT INTO "i054" ("created_at", "count") VALUES ('i05_e91246', -55602865);

INSERT INTO "i054" ("created_at", "count") VALUES ('i05_e91246', -59984348);

INSERT INTO "i054" ("created_at", "count") VALUES ('i05_e91246', -664303813);

INSERT INTO "i054" ("created_at", "count") VALUES (NULL, NULL);

INSERT INTO "i054" ("created_at", "count") VALUES (NULL, NULL);

INSERT INTO "i054" ("created_at", "count") VALUES ('i05_e91246', NULL);

INSERT INTO "i054" ("created_at", "count") VALUES ('i05_365b77', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT created_at, SUM(COUNT) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS COUNT FROM i054 ORDER BY created_at, i054.count NULLS LAST;

/*
Gold Result:
(None, -779891026)
(None, -779891026)
('i05_365b77', -779891026)
('i05_e91246', -779891026)
('i05_e91246', -115587213)
('i05_e91246', -55602865)
('i05_e91246', -779891026)
*/

-- Prediction Query
SELECT s1.created_at, SUM(s2.count) AS cumul_count FROM i054 AS s1 JOIN i054 AS s2 ON s1.created_at >= s2.created_at GROUP BY s1.created_at;

/*
Prediction Result:
('i05_365b77', None)
('i05_e91246', -3119564104)
*/