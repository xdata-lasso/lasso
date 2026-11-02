-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, '2023-01-02'), (0, 0, 1, NULL), (NULL, NULL, 1, NULL), (1, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT O.AUTHOR_ID AS ID FROM VIEWS AS O WHERE EXISTS(SELECT I.VIEWER_ID FROM VIEWS AS I WHERE (I.AUTHOR_ID = I.VIEWER_ID) AND (I.ARTICLE_ID = O.ARTICLE_ID)) ORDER BY O.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(0,)
(1,)
*/