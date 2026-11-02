-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1, 1, 1, '2023-01-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 1, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT VIEWER_ID, ARTICLE_ID, VIEW_DATE, DENSE_RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) AS NUM FROM VIEWS) SELECT DISTINCT VIEWER_ID AS ID FROM TEMP GROUP BY VIEWER_ID HAVING MAX(NUM) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(1,)
*/