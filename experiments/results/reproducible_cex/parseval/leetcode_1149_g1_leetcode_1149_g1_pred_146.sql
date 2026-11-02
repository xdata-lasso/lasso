-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1437333179, -921145356, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1258409369, -1981402255, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-890215420, 1610062532, 1, '2025-06-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-734455130, 1744686505, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1633151678, -252690330, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1115440883, 1644814318, 1, '2025-04-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1349201381, 1019800248, NULL, '2023-10-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1526238907, -1377057208, NULL, '2023-05-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1610064545, 429706943, NULL, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (462974032, -1137908826, NULL, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-918961358, -1602639011, NULL, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1209887326, -1399556171, 1, '2025-06-27');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1038707349, 1419861592, 1, '2025-06-27');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (700088193, 374105386, 1, '2025-06-27');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1683203397, 528680845, 1, '2020-06-23');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1585009206, -53231346, 1, '2020-06-23');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-443340271, 757448742, 1, '2020-06-23');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (902887186, -967741825, 1, '2022-07-11');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (775304493, 373262291, 1, '2022-07-11');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-472966518, -921187550, 1, '2022-07-11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH T_NUM_BOOKS AS (SELECT COUNT(DISTINCT V1.ARTICLE_ID) AS NUM_BOOKS, V1.VIEWER_ID FROM VIEWS AS V1 GROUP BY V1.VIEW_DATE, V1.VIEWER_ID) SELECT DISTINCT T1.VIEWER_ID AS ID FROM T_NUM_BOOKS AS T1 WHERE T1.NUM_BOOKS > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
(1,)
*/