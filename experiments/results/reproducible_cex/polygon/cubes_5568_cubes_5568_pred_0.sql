-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (9, 11, 'Public15', 'Public15', 'Public15', 'Public15', 'Public15', 'Public15', 15, 'Public15', 'Public15', 'Public15');
INSERT INTO "basketball_match" ("team_id", "school_id", "team_name", "acc_regular_season", "acc_percent", "acc_home", "acc_road", "all_games", "all_games_percent", "all_home", "all_road", "all_neutral") VALUES (8, 11, 'Public15', 'Public15', 'Public15', 'Public15', 'Public15', 'Public15', 15, 'Public15', 'Public15', 'Public15');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (10, 'Public13', 'Public14', 15, 'Public-719', 16, 'Public17', 'Public18');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (11, 'Public19', 'Public20', 15, 'Public-719', 21, 'Public22', 'Public23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "founded" FROM (SELECT "affiliation", "founded", MAX("affiliation") AS "maxaffiliation" FROM "university" GROUP BY "affiliation", "founded") WHERE ("affiliation" <> 'Public') ORDER BY founded, "founded" NULLS LAST;

/*
Gold Result:
(15.0,)
*/

-- Prediction Query
SELECT founded FROM university WHERE affiliation <> 'Public' ORDER BY founded DESC, university.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(15.0,)
*/