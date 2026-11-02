-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 7, 7, '1000-01-10');
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 10, 10, '1000-01-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(7,)
(10,)
*/

-- Prediction Query
SELECT AUTHOR_ID AS ID FROM VIEWS AS V WHERE AUTHOR_ID = VIEWER_ID GROUP BY AUTHOR_ID HAVING COUNT(ARTICLE_ID) >= 1 ORDER BY ID;

/*
Prediction Result:
*/