-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (9, 11, 'Public22', 'Public22', 'Public22', 'Public22', 'Public22', 'Public22', 22, 'Public22', 'Public22', 'Public22');
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (8, 10, 'Public22', 'Public22', 'Public22', 'Public22', 'Public22', 'Public22', 22, 'Public22', 'Public22', 'Public22');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (10, NULL, NULL, -635, 'Public12', NULL, NULL, NULL);
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (11, NULL, 'Public18', 142, 'Public', 19, 'Public20', 'Public21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school" FROM "university" WHERE ("affiliation" <> 'Public' OR founded <> 1850.0) ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT school FROM university WHERE founded > 1850 OR affiliation = 'Public';

/*
Prediction Result:
(None,)
*/