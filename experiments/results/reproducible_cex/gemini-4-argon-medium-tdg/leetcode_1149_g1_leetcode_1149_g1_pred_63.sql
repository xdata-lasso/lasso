-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (10, 1, 9, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (20, 2, 9, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (10, 1, NULL, '2019-08-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (20, 2, NULL, '2019-08-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 1, 11, '2019-08-01');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (20, 2, 11, '2019-08-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS VIEW_CNTS_PER_DAY FROM VIEWS AS V2 GROUP BY 1, 2) AS X WHERE VIEW_CNTS_PER_DAY > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(None,)
(9,)
*/