-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (1, 1, 1, NULL);
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES (2, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT A.VIEWER_ID AS ID FROM VIEWS AS A JOIN VIEWS AS B ON A.VIEWER_ID = B.VIEWER_ID AND A.ARTICLE_ID <> B.ARTICLE_ID AND A.VIEW_DATE = B.VIEW_DATE ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
*/