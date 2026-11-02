-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, 15, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 101, 15, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, 25, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 101, 25, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 102, 35, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (3, 102, 35, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT V2.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON V1.VIEWER_ID = V2.VIEWER_ID AND V1.VIEW_DATE = V2.VIEW_DATE AND V1.ARTICLE_ID <> V2.ARTICLE_ID GROUP BY 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/