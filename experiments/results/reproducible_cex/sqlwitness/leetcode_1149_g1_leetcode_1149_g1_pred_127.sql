-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO views (article_id, author_id, viewer_id, view_date) VALUES (1, NULL, 3, '2023-01-02'), (3, 3, 3, '2023-01-01'), (0, 0, 1, NULL), (2, 3, 2, '2023-01-01'), (2, 2, 0, '2023-01-01'), (0, NULL, 0, '2023-01-01'), (3, NULL, NULL, '2023-01-02'), (1, 0, 2, '2023-01-02'), (0, 2, 3, NULL), (NULL, 0, 1, '2023-01-01'), (1, 0, 2, '2023-01-02'), (NULL, 0, 3, NULL), (1, 1, 2, NULL), (2, 0, 1, NULL), (0, 0, 1, NULL), (3, 2, 3, NULL), (1, 2, 2, NULL), (2, 1, 3, '2023-01-01'), (2, 2, 1, '2023-01-01'), (3, 2, 0, '2023-01-01'), (0, NULL, 3, NULL), (NULL, 0, NULL, '2023-01-01'), (3, 3, 1, NULL), (2, 3, 1, NULL), (1, 3, 3, NULL), (0, 3, 2, '2023-01-02'), (1, NULL, 3, '2023-01-01'), (NULL, NULL, 3, '2023-01-02'), (2, 1, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
WITH T AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS VIEW_COUNT FROM VIEWS GROUP BY VIEW_DATE, VIEWER_ID) SELECT DISTINCT VIEWER_ID AS ID FROM T WHERE VIEW_COUNT >= 2 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(0,)
(1,)
(2,)
(3,)
*/