-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (16, 15, 15, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (18, 15, 15, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT DISTINCT G.VIEWER_ID AS ID FROM (SELECT DISTINCT V.VIEWER_ID, V.ARTICLE_ID, V.VIEW_DATE FROM VIEWS AS V) AS G CROSS JOIN (SELECT DISTINCT V.VIEWER_ID, V.ARTICLE_ID, V.VIEW_DATE FROM VIEWS AS V) AS P WHERE P.ARTICLE_ID <> G.ARTICLE_ID AND P.VIEW_DATE = G.VIEW_DATE AND P.VIEWER_ID = G.VIEWER_ID ORDER BY G.VIEWER_ID ASC, ID NULLS LAST;

/*
Prediction Result:
*/