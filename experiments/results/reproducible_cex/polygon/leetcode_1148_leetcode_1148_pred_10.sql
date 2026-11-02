-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (7, 9, 9, '1000-01-09');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (7, 10, 10, '1000-01-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(9,)
(10,)
*/

-- Prediction Query
SELECT DISTINCT (AUTHOR_ID) AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY ARTICLE_ID, VIEW_DATE ORDER BY ID;

/*
Prediction Result:
(9,)
*/