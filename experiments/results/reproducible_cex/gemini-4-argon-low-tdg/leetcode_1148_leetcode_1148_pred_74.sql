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
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 WHERE EXISTS(SELECT 1 FROM VIEWS AS V2 WHERE V2.ARTICLE_ID = V1.ARTICLE_ID AND V1.AUTHOR_ID = V2.VIEWER_ID) ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(10,)
(20,)
*/