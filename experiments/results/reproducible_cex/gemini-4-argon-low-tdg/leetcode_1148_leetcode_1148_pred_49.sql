-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, NULL, NULL, '2023-05-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 10, NULL, '2023-05-02');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, NULL, 10, '2023-05-03');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (4, 10, 10, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 20, 20, '2023-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 INNER JOIN VIEWS AS V2 ON V1.AUTHOR_ID = V2.VIEWER_ID AND V1.VIEW_DATE = V2.VIEW_DATE AND V1.ARTICLE_ID = V2.ARTICLE_ID GROUP BY V1.AUTHOR_ID HAVING COUNT(*) >= 1 ORDER BY ID ASC;

/*
Prediction Result:
*/