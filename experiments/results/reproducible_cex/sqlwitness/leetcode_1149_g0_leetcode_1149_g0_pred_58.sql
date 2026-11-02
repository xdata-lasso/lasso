-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 0, 0, '2023-01-02'), (2, 0, 1, '2023-01-02'), (2, 2, 2, '2023-01-01'), (2, 0, NULL, NULL), (NULL, 0, NULL, NULL), (NULL, 0, 1, NULL), (2, 0, 2, NULL), (2, 0, 1, NULL), (2, 1, 2, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T.VIEWER_ID AS ID FROM (SELECT DISTINCT ARTICLE_ID, VIEWER_ID, VIEW_DATE FROM VIEWS) AS T GROUP BY T.VIEWER_ID, T.VIEW_DATE HAVING COUNT(*) > 1 ORDER BY T.VIEWER_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
*/