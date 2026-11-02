-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 0, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT A.AUTHOR_ID AS ID FROM VIEWS AS A JOIN VIEWS AS B ON A.ARTICLE_ID = B.ARTICLE_ID WHERE A.AUTHOR_ID = B.VIEWER_ID ORDER BY ID;

/*
Prediction Result:
*/