-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, NULL, NULL), (0, 0, NULL, NULL), (2, 0, 0, NULL), (2, 0, 2, '2023-01-02'), (NULL, 1, 1, '2023-01-02'), (NULL, NULL, 1, '2023-01-01'), (NULL, 2, 0, NULL), (1, NULL, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT V.VIEWER_ID AS ID FROM VIEWS AS V GROUP BY V.VIEW_DATE, V.VIEWER_ID HAVING COUNT(V.VIEWER_ID) > 1 AND COUNT(DISTINCT V.ARTICLE_ID) > 1 ORDER BY V.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/