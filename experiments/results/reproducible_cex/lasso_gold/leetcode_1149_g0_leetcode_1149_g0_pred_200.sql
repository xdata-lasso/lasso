-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (0, 1172, 1174, '1971-09-08');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (0, 1177.0, 1174, '1971-09-08');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1, 1173, 1174, '1971-09-09');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1, 1182.0, 1174, '1971-09-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, ARTICLE_ID, COUNT(ARTICLE_ID) OVER (PARTITION BY VIEW_DATE, VIEWER_ID) AS CNT FROM VIEWS) AS A WHERE CNT > 1 GROUP BY VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1;

/*
Prediction Result:
(1174,)
*/