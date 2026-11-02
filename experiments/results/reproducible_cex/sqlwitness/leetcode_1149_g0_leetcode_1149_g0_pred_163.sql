-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 2, 1, '2023-01-02'), (2, 2, NULL, NULL), (2, NULL, NULL, '2023-01-02'), (1, 1, NULL, '2023-01-02'), (1, 0, 2, '2023-01-01'), (2, 2, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT * FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID, ARTICLE_ID, AUTHOR_ID) AS TB1 GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(VIEWER_ID) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/