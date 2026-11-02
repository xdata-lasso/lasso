-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 0, NULL, '2023-01-02'), (0, 2, NULL, '2023-01-01'), (NULL, NULL, 2, '2023-01-02'), (0, NULL, 2, '2023-01-02'), (1, 0, NULL, '2023-01-02'), (2, 0, 2, '2023-01-02'), (1, NULL, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH CTE AS (SELECT VIEWER_ID AS ID, COUNT(DISTINCT ARTICLE_ID) AS CNT FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) SELECT DISTINCT ID FROM CTE WHERE CNT > 1;

/*
Prediction Result:
(None,)
(2,)
*/