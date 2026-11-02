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
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT DISTINCT * FROM VIEWS) AS T GROUP BY VIEWER_ID, VIEW_DATE HAVING COUNT(ARTICLE_ID) > 1 ORDER BY VIEWER_ID, ID NULLS LAST;

/*
Prediction Result:
(1013,)
*/