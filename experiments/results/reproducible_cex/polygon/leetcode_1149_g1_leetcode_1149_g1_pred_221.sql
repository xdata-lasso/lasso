-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 13, 14, '1000-01-16');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (16, 17, 14, '1000-01-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE FROM VIEWS) AS A GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(1) > 1 ORDER BY ID;

/*
Prediction Result:
(14,)
*/