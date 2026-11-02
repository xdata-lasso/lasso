-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 10, 20, '2023-01-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 20, 10, '2023-01-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 10, 10, '2023-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT DISTINCT A1.AUTHOR_ID AS ID FROM VIEWS AS A1 CROSS JOIN VIEWS AS A2 WHERE A1.AUTHOR_ID = A2.VIEWER_ID AND A1.ARTICLE_ID = A2.ARTICLE_ID ORDER BY A1.AUTHOR_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(10,)
(20,)
*/