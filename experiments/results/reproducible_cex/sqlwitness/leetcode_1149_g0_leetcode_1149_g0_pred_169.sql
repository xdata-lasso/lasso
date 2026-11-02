-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 3, 1, '2023-01-02'), (0, 3, 1, NULL), (1, NULL, 1, '2023-01-02'), (2, 1, 3, '2023-01-02'), (NULL, 2, 1, '2023-01-02'), (2, 0, 3, '2023-01-01'), (2, 2, NULL, NULL), (1, 3, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(1,)
*/

-- Prediction Query
WITH VIEW_CNT AS (SELECT VIEWER_ID AS ID, VIEW_DATE AS DATE, COUNT(VIEWER_ID) AS COUNT FROM VIEWS GROUP BY 1, 2 HAVING COUNT(DISTINCT ARTICLE_ID) > 1) SELECT DISTINCT ID FROM VIEW_CNT WHERE COUNT > 1 ORDER BY ID;

/*
Prediction Result:
(1,)
*/