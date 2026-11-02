-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 13, 13, NULL);
INSERT INTO "Views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (NULL, 13, 13, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(13,)
*/

-- Prediction Query
SELECT DISTINCT (A.AUTHOR_ID) AS ID FROM VIEWS AS A INNER JOIN VIEWS AS B ON A.AUTHOR_ID = B.VIEWER_ID AND A.ARTICLE_ID = B.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/