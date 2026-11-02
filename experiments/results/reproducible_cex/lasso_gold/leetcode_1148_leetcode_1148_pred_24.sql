-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1035, 1036, 1036, '1988-08-19');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1037, 1037, 1037, '1989-09-20');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1039, 1037, 1037, '1990-10-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1036,)
(1037,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS WHERE AUTHOR_ID = VIEWER_ID GROUP BY AUTHOR_ID ORDER BY COUNT(DISTINCT ARTICLE_ID) DESC, ID NULLS LAST;

/*
Prediction Result:
(1037,)
(1036,)
*/