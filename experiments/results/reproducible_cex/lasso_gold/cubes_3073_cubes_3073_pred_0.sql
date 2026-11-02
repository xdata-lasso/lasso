-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1044, 'surface', '1939 Christine Manor
Sarahborough, TN 94373', 1045.5, 'Public', 1046.5, 'Derek Anderson', 'population');
INSERT INTO "university" ("school_id", "school", "location", "founded", "affiliation", "enrollment", "nickname", "primary_conference") VALUES (1047, 'author', '79911 William Curve
Nicolebury, MN 37854', 1046.5, 'Public', 1047.5, 'Roy Warner', 'quite');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school", "location" FROM "university" WHERE ("affiliation" = 'Public') ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('author', '79911 William Curve\nNicolebury, MN 37854')
('surface', '1939 Christine Manor\nSarahborough, TN 94373')
*/

-- Prediction Query
SELECT school, LOCATION FROM university WHERE affiliation = 'Public';

/*
Prediction Result:
('surface', '1939 Christine Manor\nSarahborough, TN 94373')
('author', '79911 William Curve\nNicolebury, MN 37854')
*/