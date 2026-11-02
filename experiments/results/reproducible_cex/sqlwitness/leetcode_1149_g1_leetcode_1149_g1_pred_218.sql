-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 0, 0, '2023-01-01'), (0, 0, NULL, '2023-01-02'), (NULL, 0, NULL, '2023-01-02'), (NULL, 3, 0, '2023-01-01'), (1, 3, 3, '2023-01-01'), (0, 2, 1, '2023-01-02'), (0, 3, 3, '2023-01-01'), (1, 2, 3, NULL), (2, NULL, 3, NULL), (1, 0, 2, '2023-01-01'), (3, 0, 3, '2023-01-02'), (1, 0, NULL, '2023-01-02'), (2, NULL, 3, '2023-01-01'), (NULL, NULL, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(3,)
*/

-- Prediction Query
WITH CTE AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS TOTAL_DAILY FROM VIEWS GROUP BY 1, 2) SELECT DISTINCT VIEWER_ID AS ID FROM CTE WHERE TOTAL_DAILY > 1;

/*
Prediction Result:
(None,)
(3,)
*/