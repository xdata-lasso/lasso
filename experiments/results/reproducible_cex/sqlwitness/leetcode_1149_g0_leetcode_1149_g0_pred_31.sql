-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, 0, '2023-01-01'), (NULL, NULL, 0, NULL), (NULL, 2, NULL, '2023-01-02'), (0, NULL, 1, '2023-01-02'), (NULL, 1, 2, '2023-01-01'), (2, 2, NULL, '2023-01-02'), (0, 0, 0, '2023-01-01'), (NULL, 0, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(*) OVER (PARTITION BY VIEWER_ID, VIEW_DATE) AS CNT FROM (SELECT DISTINCT * FROM VIEWS) AS A) AS T WHERE T.CNT > 1;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/