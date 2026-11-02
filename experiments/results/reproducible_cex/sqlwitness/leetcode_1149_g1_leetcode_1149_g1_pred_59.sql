-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, '2023-01-01'), (0, 0, 1, '2023-01-02'), (1, 2, 1, '2023-01-02'), (0, 1, 3, '2023-01-01'), (2, 2, NULL, '2023-01-01'), (0, 2, 1, '2023-01-02'), (1, 1, NULL, '2023-01-02'), (NULL, 0, 1, '2023-01-01'), (0, 3, 2, '2023-01-02'), (1, 1, NULL, '2023-01-01'), (1, 1, 2, '2023-01-01'), (NULL, NULL, 2, '2023-01-02'), (3, 0, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT T1.VIEWER_ID AS ID FROM (SELECT VIEW_DATE, VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS COUNTS FROM VIEWS GROUP BY 1, 2) AS T1 WHERE T1.COUNTS > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
*/