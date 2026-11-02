-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (10, NULL, '-55', '-55', '-55', '-55', '-55', '-55', -55, '-55', '-55', '-55');
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (9, 11, '-55', '-55', '-55', '-55', '-55', '-55', -55, '-55', '-55', '-55');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (11, NULL, '14', 15, '16', -55, '17', '18');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (12, '-55', '-55', -55, '-55', -715, '-55', '-55');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT sumenrollment AS sum_enrollment_, MIN(enrollment) OVER () AS min_enrollment_ FROM (SELECT school_id, school, LOCATION, founded, affiliation, enrollment, nickname, primary_conference, SUM(enrollment) OVER () AS sumenrollment FROM university) ORDER BY sum_enrollment_, min_enrollment_ NULLS LAST;

/*
Gold Result:
(-770.0, -715.0)
*/

-- Prediction Query
SELECT SUM(enrollment), MIN(enrollment) FROM university;

/*
Prediction Result:
(-770.0, -715.0)
*/