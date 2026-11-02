-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-55602865, -59984348, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-664303813, -1022641847, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1726781632, 247012447, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1980249628, -734455130, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1744686505, -1633151678, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-252690330, 1115440883, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1644814318, 1465859724, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1349201381, 1019800248, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1910425938, -845863578, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1610064545, 429706943, 462974032, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1137908826, -918961358, -1602639011, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-45536098, 1861536320, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (44952191, 1151980946, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1620389964, 546571701, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (947159877, 1990080517, NULL, '2025-07-01');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1964997180, 1149850321, NULL, '2020-07-02');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (528680845, -1585009206, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-53231346, -443340271, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (757448742, -1179823637, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1119186446, 781505063, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (418417917, -1031969798, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1106983592, 1884179925, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (902551284, 2107872094, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (882961052, 743312762, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1822992503, -868774469, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT VIEWER_ID AS ID FROM (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS CT FROM VIEWS GROUP BY 1, 2) AS A WHERE CT > 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
*/