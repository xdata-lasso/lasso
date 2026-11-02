-- Schema DDL
CREATE TABLE "TV_CHANNEL" (
    "ID" TEXT,
    "SERIES_NAME" TEXT,
    "COUNTRY" TEXT,
    "LANGUAGE" TEXT,
    "CONTENT" TEXT,
    "PIXEL_ASPECT_RATIO_PAR" TEXT,
    "HIGHT_DEFINITION_TV" TEXT,
    "PAY_PER_VIEW_PPV" TEXT,
    "PACKAGE_OPTION" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "TV_SERIES" (
    "ID" FLOAT,
    "CHANNEL" TEXT,
    "EPISODE" TEXT,
    "AIR_DATE" TEXT,
    "RATING" TEXT,
    "SHARE" FLOAT,
    "18_49_RATING_SHARE" TEXT,
    "VIEWERS_M" TEXT,
    "WEEKLY_RANK" FLOAT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("CHANNEL") REFERENCES "TV_CHANNEL"("ID")
);
CREATE TABLE "CARTOON" (
    "ID" FLOAT,
    "CHANNEL" TEXT,
    "TITLE" TEXT,
    "DIRECTED_BY" TEXT,
    "WRITTEN_BY" TEXT,
    "ORIGINAL_AIR_DATE" TEXT,
    "PRODUCTION_CODE" FLOAT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("CHANNEL") REFERENCES "TV_CHANNEL"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO TV_CHANNEL VALUES (2, -1, 20, 21, 22, 23, 1710114150516487853, 24, 0);
INSERT INTO TV_CHANNEL VALUES (3, -1, 25, 26, 27, 28, 1710114150516487853, 29, 1);
INSERT INTO TV_SERIES VALUES (4, 2, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO TV_SERIES VALUES (5, 3, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CARTOON VALUES (6, 2, 0, 0, 0, 0, 0);
INSERT INTO CARTOON VALUES (7, 2, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pixel_aspect_ratio_par AS package_option, pixel_aspect_ratio_par_other AS series_name FROM (SELECT LHS.id AS id, LHS.series_name AS series_name, LHS.country AS country, LHS.language AS LANGUAGE, LHS.content AS content, LHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par, LHS.hight_definition_tv AS hight_definition_tv, LHS.pay_per_view_ppv AS pay_per_view_ppv, LHS.package_option AS package_option, RHS.id AS id_other, RHS.series_name AS series_name_other, RHS.country AS country_other, RHS.language AS language_other, RHS.content AS content_other, RHS.pixel_aspect_ratio_par AS pixel_aspect_ratio_par_other, RHS.hight_definition_tv AS hight_definition_tv_other, RHS.pay_per_view_ppv AS pay_per_view_ppv_other, RHS.package_option AS package_option_other FROM tv_channel AS LHS CROSS JOIN tv_channel AS RHS) WHERE (hight_definition_tv = hight_definition_tv_other) ORDER BY package_option, series_name NULLS LAST;

/*
Gold Result:
('23', '23')
('23', '28')
('28', '23')
('28', '28')
*/

-- Prediction Query
SELECT package_option, series_name FROM TV_Channel WHERE hight_definition_TV = 'yes';

/*
Prediction Result:
*/