-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (2, 3, NULL, '2023-01-01'), (0, 1, NULL, '2023-01-01'), (1, NULL, 2, '2023-01-01'), (3, 1, 3, '2023-01-02'), (1, 2, 2, '2023-01-02'), (1, NULL, 2, '2023-01-02'), (1, 2, NULL, NULL), (2, 3, 2, NULL), (NULL, 3, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT VIEWER_ID AS ID FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID HAVING COUNT(DISTINCT ARTICLE_ID) > 1 ORDER BY ID;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH T AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(ARTICLE_ID) OVER (PARTITION BY VIEWER_ID, VIEW_DATE) AS N_ART FROM (SELECT DISTINCT * FROM VIEWS) AS SUB) SELECT DISTINCT VIEWER_ID AS ID FROM T WHERE N_ART >= 2 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(2,)
*/