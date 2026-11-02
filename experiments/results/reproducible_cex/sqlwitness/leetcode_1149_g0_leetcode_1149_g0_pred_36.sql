-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, NULL, '2023-01-01'), (1, 1, NULL, '2023-01-01'), (2, 2, 2, '2023-01-02'), (NULL, 1, NULL, '2023-01-01'), (1, 2, 0, '2023-01-01'), (NULL, 1, 2, NULL), (0, NULL, 0, NULL), (2, NULL, NULL, '2023-01-01'), (1, 1, 0, '2023-01-01'), (2, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT VIEWER_ID AS ID FROM (SELECT VIEWER_ID FROM (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE, ARTICLE_ID) AS NP GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(*) > 1) AS NP2 GROUP BY ID ORDER BY ID;

/*
Prediction Result:
(None,)
(2,)
*/