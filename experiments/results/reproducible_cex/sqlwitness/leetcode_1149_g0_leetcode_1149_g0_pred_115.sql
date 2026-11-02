-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 3, 3, '2023-01-02'), (3, 0, NULL, '2023-01-01'), (2, 0, 2, '2023-01-02'), (0, 2, 0, '2023-01-01'), (3, 3, 2, '2023-01-01'), (0, NULL, 1, NULL), (1, 0, 3, '2023-01-02'), (NULL, NULL, 1, '2023-01-01'), (2, 2, 1, NULL), (1, NULL, 2, NULL), (0, 3, 2, '2023-01-01'), (3, NULL, 1, '2023-01-02'), (2, 1, 1, NULL), (NULL, NULL, 1, NULL), (3, 0, 0, NULL), (2, 0, NULL, '2023-01-01'), (NULL, 2, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE FROM VIEWS), T2 AS (SELECT T1.VIEW_DATE, T1.VIEWER_ID AS VD, COUNT(T1.VIEWER_ID) AS CVID FROM T1 GROUP BY 1, 2) SELECT DISTINCT T2.VD AS ID FROM T2 WHERE CVID > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(1,)
(2,)
(3,)
*/