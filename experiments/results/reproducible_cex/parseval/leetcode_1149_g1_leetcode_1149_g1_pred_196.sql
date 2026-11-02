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

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1349201381, 1019800248, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1910425938, -845863578, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1610064545, 429706943, 1, '2021-03-30');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1236688122, 2087640001, NULL, '2020-07-11');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1137908826, -918961358, NULL, '2021-06-03');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1823627488, -1209887326, NULL, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1399556171, 1038707349, NULL, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1419861592, 700088193, NULL, '2022-09-14');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1274489983, -1683203397, 1, '2020-11-01');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (528680845, -1585009206, 1, '2020-11-01');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-53231346, -443340271, 1, '2020-11-01');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1179823637, 1119186446, 1, '2023-08-27');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (781505063, 418417917, 1, '2023-08-27');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1031969798, -1106983592, 1, '2023-08-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, COUNT(DISTINCT ARTICLE_ID) AS NUM FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) AS N WHERE NUM > 1 ORDER BY ID ASC;

/*
Prediction Result:
(None,)
(1,)
*/