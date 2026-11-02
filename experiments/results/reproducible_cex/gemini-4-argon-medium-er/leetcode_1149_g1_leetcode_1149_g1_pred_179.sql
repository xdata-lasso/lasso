-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT (T1.VIEWER_ID) AS ID FROM VIEWS AS T1 JOIN VIEWS AS T2 ON T1.VIEWER_ID = T2.VIEWER_ID WHERE T1.ARTICLE_ID <> T2.ARTICLE_ID AND T1.VIEW_DATE = T2.VIEW_DATE ORDER BY ID;

/*
Prediction Result:
*/