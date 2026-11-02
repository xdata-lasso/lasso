-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 10, '2023-09-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, 10, '2023-09-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (5, 1, 10, '2023-09-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 20, '2023-09-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 20, '2023-09-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(20,)
*/

-- Prediction Query
WITH CTE AS (SELECT VIEWER_ID, RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) AS RNK FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM CTE WHERE RNK > 1;

/*
Prediction Result:
(10,)
(20,)
*/