-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: university --
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1, 'uni_d3f132', 'uni_28cf49', 1.0, 'uni_46155f', 20000.0, 'uni_756ed8', 'uni_73ad5a');

INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (-2147483647, 'uni_7a2f62', 'uni_c9ece0', 1.0, 'uni_32517f', 20000.0, 'uni_4f1ef1', 'uni_c4f8cb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___, affiliation FROM (SELECT affiliation, COUNT(DISTINCT enrollment) AS n_distinct FROM (SELECT * FROM university WHERE (enrollment >= 20000.0)) GROUP BY affiliation) ORDER BY count___, affiliation NULLS LAST;

/*
Gold Result:
(1, 'uni_32517f')
(1, 'uni_46155f')
*/

-- Prediction Query
SELECT COUNT(*), affiliation FROM university WHERE enrollment > 20000 GROUP BY affiliation;

/*
Prediction Result:
*/