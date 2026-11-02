-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (14, 15, 23, '1000-01-17');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (17, 18, 19, '1000-01-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT V.VIEWER_ID, COUNT(V.ARTICLE_ID) OVER (PARTITION BY V.VIEWER_ID, V.VIEW_DATE ORDER BY V.VIEWER_ID) AS IDX FROM (SELECT DISTINCT * FROM VIEWS) AS V) SELECT DISTINCT VIEWER_ID AS ID FROM TMP WHERE IDX > 1;

/*
Prediction Result:
*/