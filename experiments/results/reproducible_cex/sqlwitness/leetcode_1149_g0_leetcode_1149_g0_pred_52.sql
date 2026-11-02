-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, 0, '2023-01-02'), (2, 2, 1, '2023-01-01'), (2, 2, NULL, '2023-01-01'), (1, 2, 2, '2023-01-02'), (0, NULL, 2, NULL), (2, 2, NULL, NULL), (1, 0, 1, NULL), (0, 2, 1, '2023-01-02'), (1, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT A.VIEWER_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.VIEW_DATE = B.VIEW_DATE AND A.VIEWER_ID = B.VIEWER_ID GROUP BY A.VIEWER_ID, A.VIEW_DATE HAVING COUNT(DISTINCT A.ARTICLE_ID) > 1 ORDER BY A.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/