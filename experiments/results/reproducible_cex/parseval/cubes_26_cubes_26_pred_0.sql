-- Schema DDL
CREATE TABLE "i051" ("id" INTEGER, "category" TEXT, "date" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i051 --
INSERT INTO "i051" ("id", "category", "date") VALUES (-55602865, 'i05_03e09c', 'swwqcgsk');

INSERT INTO "i051" ("id", "category", "date") VALUES (1, 'i05_4d996f', 'i05_d1e654');

INSERT INTO "i051" ("id", "category", "date") VALUES (1610062532, 'rhs_f7767e', 'pgu7vfe4');

INSERT INTO "i051" ("id", "category", "date") VALUES (1160656988, 'i05_03e09c', 'ia2yp');

INSERT INTO "i051" ("id", "category", "date") VALUES (-1670923962, 'i05_e34989', 'rwbbp6luhvd');

INSERT INTO "i051" ("id", "category", "date") VALUES (1, 'i05_4d996f', 'i05_d1e654');

INSERT INTO "i051" ("id", "category", "date") VALUES (1, 'i05_a127a8', 'i05_e948d0');

INSERT INTO "i051" ("id", "category", "date") VALUES (-1377057208, 'rhs_f7767e', 'ilbnp');

INSERT INTO "i051" ("id", "category", "date") VALUES (1236688122, 'rhs_1f3a91', 'dpos');

INSERT INTO "i051" ("id", "category", "date") VALUES (1, 'ie5', 'nw6klf');

INSERT INTO "i051" ("id", "category", "date") VALUES (1, 'a9000t5c4eci', 'gce376nium52');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, category, maxdate AS date FROM (SELECT LHS.id AS id, LHS.category AS category, LHS.date AS date, LHS.maxdate AS maxdate, RHS.category AS category_other FROM (SELECT id, category, date, MAX(date) OVER () AS maxdate FROM i051) AS LHS INNER JOIN i051 AS RHS ON (LHS.id = RHS.id AND LHS.maxdate = RHS.date)) ORDER BY id, category NULLS LAST, date NULLS LAST;

/*
Gold Result:
(-55602865, 'i05_03e09c', 'swwqcgsk')
*/

-- Prediction Query
SELECT t1.* FROM i051 AS t1 JOIN (SELECT category, MAX(date) AS MAXDATE FROM i051 GROUP BY category) AS t2 ON T1.category = t2.category AND t1.date = t2.MAXDATE;

/*
Prediction Result:
(-55602865, 'i05_03e09c', 'swwqcgsk')
(1, 'i05_4d996f', 'i05_d1e654')
(1610062532, 'rhs_f7767e', 'pgu7vfe4')
(-1670923962, 'i05_e34989', 'rwbbp6luhvd')
(1, 'i05_4d996f', 'i05_d1e654')
(1, 'i05_a127a8', 'i05_e948d0')
(1236688122, 'rhs_1f3a91', 'dpos')
(1, 'ie5', 'nw6klf')
(1, 'a9000t5c4eci', 'gce376nium52')
*/