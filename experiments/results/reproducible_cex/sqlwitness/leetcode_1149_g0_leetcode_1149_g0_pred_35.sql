-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, 2, '2023-01-02'), (1, NULL, 1, NULL), (NULL, 0, 0, '2023-01-02'), (NULL, NULL, NULL, '2023-01-02'), (0, NULL, 2, '2023-01-01'), (0, 1, 2, '2023-01-01'), (NULL, 1, 0, '2023-01-01'), (2, 2, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.VIEWER_ID AS ID FROM (SELECT DISTINCT * FROM VIEWS) AS T1 GROUP BY T1.VIEWER_ID HAVING COUNT(DISTINCT T1.VIEW_DATE) <> COUNT(T1.VIEW_DATE) ORDER BY T1.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(2,)
*/