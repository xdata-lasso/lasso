-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, 0, '2023-01-01'), (0, NULL, 2, NULL), (NULL, 2, 2, '2023-01-01'), (NULL, 1, 0, NULL), (1, NULL, 2, '2023-01-01'), (1, 1, NULL, '2023-01-01'), (1, 1, 1, '2023-01-01'), (1, 2, NULL, '2023-01-02'), (2, 2, NULL, '2023-01-02'), (0, NULL, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT A.VIEWER_ID AS ID FROM VIEWS AS A JOIN VIEWS AS B ON A.VIEWER_ID = B.VIEWER_ID AND A.ARTICLE_ID <> B.ARTICLE_ID AND A.VIEW_DATE = B.VIEW_DATE ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/