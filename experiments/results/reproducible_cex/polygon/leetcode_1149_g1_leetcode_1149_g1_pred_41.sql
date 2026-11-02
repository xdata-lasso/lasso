-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13, 16, 17, '1000-01-16');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (14, 16, 17, '1000-01-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(17,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT AUTHOR_ID, VIEWER_ID, VIEW_DATE, RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY AUTHOR_ID, ARTICLE_ID) AS RNK FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TEMP WHERE RNK >= 2;

/*
Prediction Result:
(17,)
*/