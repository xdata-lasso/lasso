-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 10, 20, '2022-03-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 20, 10, '2022-03-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 30, 10, '2022-03-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 40, 40, '2022-03-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(40,)
*/

-- Prediction Query
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 CROSS JOIN VIEWS AS V2 WHERE V1.AUTHOR_ID = V2.VIEWER_ID AND V1.ARTICLE_ID = V2.ARTICLE_ID ORDER BY ID;

/*
Prediction Result:
(10,)
(20,)
(40,)
*/