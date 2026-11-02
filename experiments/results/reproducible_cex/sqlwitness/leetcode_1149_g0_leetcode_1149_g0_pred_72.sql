-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, 0, '2023-01-01'), (1, NULL, 1, NULL), (1, 0, 1, '2023-01-02'), (NULL, 0, NULL, NULL), (2, 1, 1, '2023-01-02'), (NULL, NULL, 0, '2023-01-01'), (0, 1, 1, '2023-01-01'), (0, NULL, NULL, NULL), (NULL, 2, 0, NULL), (2, NULL, 0, NULL), (2, 2, 2, '2023-01-02'), (0, 2, NULL, NULL), (NULL, 1, 0, '2023-01-01'), (NULL, 1, 1, NULL), (0, 1, 0, '2023-01-01'), (1, NULL, NULL, '2023-01-02'), (2, NULL, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(ARTICLE_ID) OVER (PARTITION BY VIEW_DATE, VIEWER_ID) AS TCOUNT FROM (SELECT * FROM VIEWS GROUP BY ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) AS T) AS T1 WHERE TCOUNT > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
(1,)
*/