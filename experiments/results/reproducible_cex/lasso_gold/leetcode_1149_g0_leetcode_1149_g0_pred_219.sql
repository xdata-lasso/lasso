-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1044, 1046, 1048, '1978-09-09');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1045, 1051.0, 1048, '1978-09-09');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1049, 1051, 1048, '1978-09-10');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1050, 1056.0, 1048, '1978-09-10');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1051, 1056.0, 1048, '1978-09-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1048,)
*/

-- Prediction Query
SELECT VIEWER_ID AS ID FROM (SELECT DISTINCT VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS CNT FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) AS A WHERE CNT >= 2;

/*
Prediction Result:
(1048,)
(1048,)
*/