-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, NULL), (1, NULL, NULL, NULL), (1, NULL, 0, NULL), (0, NULL, NULL, NULL), (2, NULL, 0, NULL), (0, NULL, 2, '2023-01-01'), (1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT (V.VIEWER_ID) AS ID FROM VIEWS AS V GROUP BY V.VIEWER_ID, V.VIEW_DATE HAVING COUNT(DISTINCT (V.ARTICLE_ID)) > 1 ORDER BY ID ASC;

/*
Prediction Result:
(None,)
(0,)
*/