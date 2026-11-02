-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, 0, '2023-01-01'), (0, 1, 1, '2023-01-02'), (2, 0, 0, '2023-01-01'), (0, 0, 2, NULL), (1, 0, 2, '2023-01-01'), (0, 0, 0, '2023-01-02'), (2, 1, NULL, '2023-01-01'), (2, 1, 2, '2023-01-01'), (1, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT (VIEWER_ID) AS ID FROM (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE, ARTICLE_ID) AS A GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(*) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(0,)
(2,)
*/