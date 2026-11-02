-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (3, 3, NULL, '2023-01-01'), (3, 1, 1, '2023-01-01'), (0, 0, 2, NULL), (3, 0, 2, NULL), (3, 3, 2, '2023-01-01'), (NULL, 0, 0, NULL), (2, 1, NULL, '2023-01-02'), (1, 0, NULL, '2023-01-01'), (3, 2, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT (VIEWER_ID) AS ID FROM VIEWS WHERE (VIEWER_ID, VIEW_DATE) IN (SELECT VIEWER_ID, VIEW_DATE FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(DISTINCT (ARTICLE_ID)) >= 2) ORDER BY ID;

/*
Prediction Result:
*/