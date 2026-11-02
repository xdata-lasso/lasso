-- Schema DDL
CREATE TABLE "basketball_match" ("Team_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Team_Name" TEXT, "ACC_Regular_Season" TEXT, "ACC_Percent" TEXT, "ACC_Home" TEXT, "ACC_Road" TEXT, "All_Games" TEXT, "All_Games_Percent" INTEGER, "All_Home" TEXT, "All_Road" TEXT, "All_Neutral" TEXT, FOREIGN KEY ("School_ID") REFERENCES "university" ("School_ID"));

CREATE TABLE "university" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Founded" REAL, "Affiliation" TEXT, "Enrollment" REAL, "Nickname" TEXT, "Primary_conference" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logical OR vs AND, negation, exact boundary values (1850.0, 1849.0, 1851.0), and case sensitivity ('public' vs 'Public').
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (1, 'Uni_False_Both', 'Loc1', 1850.0, 'Public', 10000.0, 'Nick1', 'Conf1');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (2, 'Uni_True_Aff', 'Loc2', 1850.0, 'Private', 15000.0, 'Nick2', 'Conf1');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (3, 'Uni_True_Found_High', 'Loc3', 1851.0, 'Public', 20000.0, 'Nick3', 'Conf2');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (4, 'Uni_True_Found_Low', 'Loc4', 1849.0, 'Public', 25000.0, 'Nick4', 'Conf2');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (5, 'Uni_True_Both', 'Loc5', 1900.0, 'Private', 30000.0, 'Nick5', 'Conf3');
INSERT INTO "university" ("School_ID", "School", "Location", "Founded", "Affiliation", "Enrollment", "Nickname", "Primary_conference") VALUES (6, 'Uni_Case_Public', 'Loc6', 1850.0, 'public', 12000.0, 'Nick6', 'Conf3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "school" FROM "university" WHERE ("affiliation" <> 'Public' OR founded <> 1850.0) ORDER BY school, university.school_id NULLS LAST;

/*
Gold Result:
('Uni_Case_Public',)
('Uni_True_Aff',)
('Uni_True_Both',)
('Uni_True_Found_High',)
('Uni_True_Found_Low',)
*/

-- Prediction Query
SELECT school FROM university WHERE founded > 1850 OR affiliation = 'Public';

/*
Prediction Result:
('Uni_False_Both',)
('Uni_True_Found_High',)
('Uni_True_Found_Low',)
('Uni_True_Both',)
*/