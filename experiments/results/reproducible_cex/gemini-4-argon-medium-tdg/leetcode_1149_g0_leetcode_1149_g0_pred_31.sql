-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 500, 500, '2023-07-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 500, 500, '2023-07-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 500, 600, '2023-07-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 600, 600, '2023-07-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(500,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(*) OVER (PARTITION BY VIEWER_ID, VIEW_DATE) AS CNT FROM (SELECT DISTINCT * FROM VIEWS) AS A) AS T WHERE T.CNT > 1;

/*
Prediction Result:
(500,)
(600,)
*/