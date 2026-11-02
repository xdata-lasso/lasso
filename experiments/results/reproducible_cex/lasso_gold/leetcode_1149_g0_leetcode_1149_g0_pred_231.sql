-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (0.6, 1011, 1013, '1972-03-03');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (0.6, 1016.0, 1013, '1972-03-03');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (0.6, 1011, 1013, '1972-03-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT V.VIEWER_ID, COUNT(V.ARTICLE_ID) OVER (PARTITION BY V.VIEWER_ID, V.VIEW_DATE ORDER BY V.VIEWER_ID) AS IDX FROM (SELECT DISTINCT * FROM VIEWS) AS V) SELECT DISTINCT VIEWER_ID AS ID FROM TMP WHERE IDX > 1;

/*
Prediction Result:
(1013,)
*/