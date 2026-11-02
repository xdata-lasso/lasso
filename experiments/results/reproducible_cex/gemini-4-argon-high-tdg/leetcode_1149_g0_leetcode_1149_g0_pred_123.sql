-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (100, 1, 5, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (100, 1, 5, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (100, 2, 5, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (101, 3, 6, '2020-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (102, 3, 6, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(6,)
*/

-- Prediction Query
WITH X AS (SELECT DISTINCT * FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM X GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(VIEWER_ID) > 1 ORDER BY VIEWER_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(5,)
(6,)
*/