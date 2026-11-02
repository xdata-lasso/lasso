-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, NULL, NULL, NULL);
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1116, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT ARTICLE_ID, VIEWER_ID, VIEW_DATE FROM VIEWS) AS T GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
*/