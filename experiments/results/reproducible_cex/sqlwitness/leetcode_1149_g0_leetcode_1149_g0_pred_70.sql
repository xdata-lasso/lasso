-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 2, 0, '2023-01-01'), (1, NULL, 1, '2023-01-01'), (0, NULL, NULL, '2023-01-02'), (NULL, NULL, NULL, '2023-01-01'), (0, 2, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT * FROM VIEWS) AS T GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(ARTICLE_ID) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(None,)
*/