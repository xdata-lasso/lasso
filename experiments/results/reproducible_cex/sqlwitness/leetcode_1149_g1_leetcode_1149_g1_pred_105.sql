-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (3, 0, 2, '2023-01-01'), (1, NULL, NULL, '2023-01-01'), (2, 2, 2, '2023-01-02'), (0, NULL, 1, NULL), (1, 1, 2, '2023-01-01'), (0, 0, 1, NULL), (3, 1, 2, '2023-01-02'), (1, 3, 1, NULL), (3, 0, NULL, NULL), (2, NULL, 0, NULL), (2, NULL, NULL, '2023-01-01'), (1, 0, 1, NULL);
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
WITH CTE AS (SELECT VIEW_DATE, VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS NO_OF_ART FROM VIEWS GROUP BY 1, 2) SELECT DISTINCT VIEWER_ID AS ID FROM CTE WHERE NO_OF_ART > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/