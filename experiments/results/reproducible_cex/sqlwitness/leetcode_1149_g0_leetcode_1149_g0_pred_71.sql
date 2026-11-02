-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, 2, NULL), (NULL, 1, 2, NULL), (NULL, 2, 2, NULL), (2, 1, 2, NULL), (1, 0, 0, '2023-01-01'), (2, 1, 2, '2023-01-01'), (NULL, 0, 2, '2023-01-02'), (1, 2, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT VIEWER_ID, ROW_NUMBER() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) AS RN FROM (SELECT DISTINCT * FROM VIEWS) AS A) AS B WHERE RN > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(2,)
*/