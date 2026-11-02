-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, NULL, NULL), (1, NULL, 0, '2023-01-02'), (1, NULL, NULL, '2023-01-01'), (0, 1, 1, NULL), (1, 2, 2, NULL), (2, 1, 2, NULL), (0, 1, 2, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 CROSS JOIN VIEWS AS V2 WHERE V1.VIEWER_ID = V2.VIEWER_ID AND V1.VIEW_DATE = V2.VIEW_DATE AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY V1.VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
*/