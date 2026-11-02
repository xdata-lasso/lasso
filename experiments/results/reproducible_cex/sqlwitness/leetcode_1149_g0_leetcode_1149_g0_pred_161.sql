-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 0, 0, '2023-01-01'), (0, 2, 0, '2023-01-01'), (NULL, 2, NULL, '2023-01-02'), (NULL, 2, NULL, '2023-01-02'), (0, 0, NULL, NULL), (NULL, NULL, 1, '2023-01-01'), (2, 1, 0, '2023-01-01'), (2, 1, 2, '2023-01-02'), (0, 2, 0, '2023-01-01'), (NULL, 1, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT * FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT *, COUNT(VIEW_DATE) OVER (PARTITION BY VIEWER_ID, VIEW_DATE) AS COUNT_VIEWS FROM TEMP) AS FINAL_T WHERE COUNT_VIEWS > 1 ORDER BY ID ASC;

/*
Prediction Result:
(None,)
(0,)
*/