-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, 3, 0, '2023-01-01'), (0, 2, 3, NULL), (0, 2, 2, '2023-01-01'), (0, 1, 1, '2023-01-02'), (4, 4, NULL, '2023-01-02'), (NULL, NULL, NULL, '2023-01-02'), (3, 0, NULL, '2023-01-02'), (3, 3, 0, NULL), (2, 3, 2, NULL), (3, NULL, 4, '2023-01-02'), (0, 4, 1, '2023-01-02'), (NULL, 0, 0, NULL), (4, 3, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS B, VIEW_DATE FROM VIEWS GROUP BY 3, 1) AS A1 WHERE B > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
*/