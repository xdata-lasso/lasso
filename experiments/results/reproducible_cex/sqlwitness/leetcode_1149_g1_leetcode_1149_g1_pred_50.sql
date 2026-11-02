-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (0, 4, 3, '2023-01-02'), (2, 3, 0, NULL), (1, 2, 3, NULL), (2, NULL, 3, '2023-01-01'), (1, NULL, NULL, '2023-01-02'), (1, 3, 3, '2023-01-01'), (1, 2, 2, '2023-01-01'), (4, 1, 4, NULL), (1, 4, NULL, NULL), (1, 4, 4, '2023-01-02'), (3, 0, 3, '2023-01-01'), (3, 1, NULL, NULL), (1, NULL, 3, NULL), (2, 2, 0, '2023-01-01'), (4, 4, NULL, '2023-01-01'), (2, 1, 2, NULL), (1, 1, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT DISTINCT A.VIEWER_ID AS ID FROM (SELECT VIEWER_ID, VIEW_DATE, ARTICLE_ID, COUNT(*) AS CT FROM VIEWS GROUP BY 1, 2, 3) AS A GROUP BY A.VIEWER_ID, A.VIEW_DATE HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
(3,)
*/