-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1001, 1002, 1003, '1970-01-01');
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1001, 1004, 1002, '1971-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT L.AUTHOR_ID AS ID FROM VIEWS AS L INNER JOIN VIEWS AS R ON L.AUTHOR_ID = R.VIEWER_ID AND L.ARTICLE_ID = R.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(1002,)
*/