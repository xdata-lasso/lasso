-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (NULL, 0, NULL, '2023-01-01'), (NULL, 2, NULL, '2023-01-02'), (NULL, 0, 2, '2023-01-01'), (1, 0, 1, NULL), (0, 2, 2, '2023-01-01'), (0, 2, NULL, '2023-01-02'), (1, 1, 2, '2023-01-02'), (1, 2, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP AS (SELECT V.VIEWER_ID, COUNT(V.ARTICLE_ID) OVER (PARTITION BY V.VIEWER_ID, V.VIEW_DATE ORDER BY V.VIEWER_ID) AS IDX FROM (SELECT DISTINCT * FROM VIEWS) AS V) SELECT DISTINCT VIEWER_ID AS ID FROM TMP WHERE IDX > 1;

/*
Prediction Result:
(1,)
*/