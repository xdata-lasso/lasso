-- Schema DDL
CREATE TABLE "TV_Channel" ("id" TEXT PRIMARY KEY, "series_name" TEXT, "Country" TEXT, "Language" TEXT, "Content" TEXT, "Pixel_aspect_ratio_PAR" TEXT, "Hight_definition_TV" TEXT, "Pay_per_view_PPV" TEXT, "Package_Option" TEXT);

CREATE TABLE "TV_series" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Episode" TEXT, "Air_Date" TEXT, "Rating" TEXT, "Share" REAL, "18_49_Rating_Share" TEXT, "Viewers_m" TEXT, "Weekly_Rank" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

CREATE TABLE "Cartoon" ("id" REAL PRIMARY KEY, "Channel" TEXT, "Title" TEXT, "Directed_by" TEXT, "Written_by" TEXT, "Original_air_date" TEXT, "Production_code" REAL, FOREIGN KEY ("Channel") REFERENCES "TV_Channel" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch1', 'Alpha', 'USA', 'Spanish', 'News', '16:9', 'yes', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch2', 'Alpha', 'USA', 'Spanish', 'Sports', '16:9', 'yes', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch3', 'Beta', 'Mexico', 'Spanish', 'Music', '4:3', 'no', 'no', 'Standard');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch4', 'Gamma', 'Spain', 'Spanish', 'Drama', '16:9', 'yes', 'yes', 'Premium');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch5', 'Delta', 'UK', 'English', 'News', '16:9', 'yes', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch6', 'Delta', 'UK', 'English', 'Movies', '16:9', 'yes', 'yes', 'Premium');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch7', 'Epsilon', 'USA', 'English', 'Kids', '4:3', 'no', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch8', 'Zeta', 'China', 'Chinese', 'Culture', '16:9', 'yes', 'no', 'Standard');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch9', 'Eta', 'China', 'Chinese', 'News', '16:9', 'no', 'no', 'Basic');
INSERT INTO TV_Channel (id, series_name, Country, Language, Content, Pixel_aspect_ratio_PAR, Hight_definition_TV, Pay_per_view_PPV, Package_Option) VALUES ('ch10', 'Theta', 'Egypt', 'Arabic', 'Documentary', '4:3', 'no', 'no', 'Basic');
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (1.0, 'ch1', 'Ep1', '2020-01-01', '5.0', 10.0, '2.1/6', '4.5', 10.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (2.0, 'ch10', 'Ep2', '2020-01-02', '6.0', 12.0, '2.5/7', '5.5', 5.0);
INSERT INTO TV_series (id, Channel, Episode, Air_Date, Rating, Share, "18_49_Rating_Share", Viewers_m, Weekly_Rank) VALUES (3.0, 'ch10', 'Ep3', '2020-01-09', '6.2', 13.0, '2.6/8', '5.8', 4.0);
INSERT INTO Cartoon (id, Channel, Title, Directed_by, Written_by, Original_air_date, Production_code) VALUES (1.0, 'ch10', 'Toon A', 'Dir 1', 'Wri 1', '2019-05-01', 101.0);
INSERT INTO Cartoon (id, Channel, Title, Directed_by, Written_by, Original_air_date, Production_code) VALUES (2.0, 'ch10', 'Toon B', 'Dir 2', 'Wri 2', '2019-05-08', 102.0);
INSERT INTO Cartoon (id, Channel, Title, Directed_by, Written_by, Original_air_date, Production_code) VALUES (3.0, 'ch5', 'Toon C', 'Dir 1', 'Wri 3', '2019-06-01', 103.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language_other AS LANGUAGE, n_other AS count___ FROM (SELECT LHS.language AS LANGUAGE, LHS.n AS n, RHS.language AS language_other, RHS.n AS n_other FROM (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS LHS CROSS JOIN (SELECT LANGUAGE, COUNT(*) AS n FROM tv_channel GROUP BY LANGUAGE) AS RHS) WHERE (n > n_other) ORDER BY LANGUAGE, count___ NULLS LAST;

/*
Gold Result:
('Arabic', 1)
('Arabic', 1)
('Arabic', 1)
('Chinese', 2)
('Chinese', 2)
('English', 3)
*/

-- Prediction Query
SELECT LANGUAGE, COUNT(*) FROM TV_Channel GROUP BY LANGUAGE ORDER BY COUNT(*) ASC, LANGUAGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Arabic', 1)
*/