-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 1, 2, '2023-01-02'), (2, 0, 1, '2023-01-02'), (0, 1, NULL, '2023-01-01'), (1, 1, NULL, NULL), (2, 0, NULL, '2023-01-01'), (2, 1, 2, NULL), (NULL, NULL, 1, '2023-01-01'), (2, 1, 2, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, ROW_NUMBER() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY AUTHOR_ID) AS RN FROM (SELECT DISTINCT * FROM VIEWS) AS A) AS B WHERE RN > 1;

/*
Prediction Result:
(None,)
(2,)
*/