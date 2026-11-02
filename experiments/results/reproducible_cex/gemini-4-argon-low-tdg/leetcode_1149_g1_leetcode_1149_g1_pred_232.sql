-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 100, 10, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 101, 10, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, 20, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 101, 20, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 100, NULL, '2019-08-01');
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 101, NULL, '2019-08-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT V.VIEWER_ID, COUNT(V.ARTICLE_ID) OVER (PARTITION BY V.VIEWER_ID, V.VIEW_DATE ORDER BY V.VIEWER_ID) AS IDX FROM (SELECT DISTINCT * FROM VIEWS) AS V) SELECT DISTINCT VIEWER_ID AS ID FROM TMP WHERE IDX > 1;

/*
Prediction Result:
(None,)
*/