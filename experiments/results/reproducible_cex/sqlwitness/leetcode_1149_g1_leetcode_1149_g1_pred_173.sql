-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 2, 0, NULL), (0, NULL, 3, '2023-01-01'), (0, 0, 1, '2023-01-01'), (NULL, 1, 1, '2023-01-02'), (3, 2, NULL, '2023-01-01'), (0, 1, NULL, '2023-01-01'), (NULL, 3, NULL, '2023-01-02'), (1, 1, 1, '2023-01-02'), (NULL, 2, NULL, NULL), (3, 0, 1, '2023-01-01'), (NULL, 0, 0, '2023-01-02'), (3, NULL, 2, '2023-01-01'), (1, 1, 1, '2023-01-02'), (1, 1, 2, NULL), (1, 1, 2, '2023-01-01'), (0, 1, 2, '2023-01-02'), (1, NULL, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH VIEWS_PER_USER AS (SELECT VIEWER_ID AS ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS CT FROM VIEWS GROUP BY 1, 2) SELECT DISTINCT ID FROM VIEWS_PER_USER WHERE CT > 1;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/