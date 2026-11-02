-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 2, 1, '2023-01-01'), (2, 0, 1, '2023-01-02'), (0, 3, 3, '2023-01-02'), (2, 1, 1, '2023-01-02'), (0, 1, NULL, NULL), (3, 3, 2, '2023-01-01'), (0, 3, 0, '2023-01-01'), (2, 2, NULL, NULL), (0, 3, 2, '2023-01-02'), (2, 1, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, VIEW_DATE FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(DISTINCT ARTICLE_ID) >= 2) AS T ORDER BY VIEWER_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(None,)
*/