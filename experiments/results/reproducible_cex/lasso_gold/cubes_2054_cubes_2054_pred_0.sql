-- Schema DDL
CREATE TABLE "School" ("School_id" TEXT PRIMARY KEY, "School_name" TEXT, "Location" TEXT, "Mascot" TEXT, "Enrollment" INTEGER, "IHSAA_Class" TEXT, "IHSAA_Football_Class" TEXT, "County" TEXT);

CREATE TABLE "budget" ("School_id" INTEGER, "Year" INTEGER, "Budgeted" INTEGER, "total_budget_percent_budgeted" REAL, "Invested" INTEGER, "total_budget_percent_invested" REAL, "Budget_invested_percent" TEXT, PRIMARY KEY ("School_id", "Year"), FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

CREATE TABLE "endowment" ("endowment_id" INTEGER PRIMARY KEY, "School_id" INTEGER, "donator_name" TEXT, "amount" REAL, FOREIGN KEY ("School_id") REFERENCES "School" ("School_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('act', 'Angel Lewis MD', '5868 Crosby Crescent
Gregoryview, AZ 14709', 'find', 1014, 'country', 'research', 'its');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('energy', 'Shirley Suarez', '740 Cynthia Village Suite 005
Lake Tina, GA 97655', 'talk', 1025.0, 'yard', 'go', 'suffer');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('example', 'Christopher Bass', '011 Amy Village Suite 982
Andersonport, MN 05730', 'cost', 1036.0, 'yard', 'stay', 'relationship');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('low', 'Lisa Archer', 'PSC 3315, Box 8692
APO AE 21800', 'upon', 1047.0, 'since', 'word', 'treat');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('collection', 'Ashley Brennan', '841 Joseph Coves
West Juan, IL 94559', 'such', 1015, 'ago', 'window', 'power');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('order', 'Courtney Velasquez', '569 Paul Ports Apt. 406
New Saraside, TX 94798', 'once', 1029.0, 'red', 'smile', 'outside');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('pretty', 'Eric Pope', 'USNS Diaz
FPO AE 87563', 'care', 1040.0, 'yard', 'weight', 'fish');
INSERT INTO "school" ("school_id", "school_name", "location", "mascot", "enrollment", "ihsaa_class", "ihsaa_football_class", "county") VALUES ('simple', 'Alexander Lee', 'PSC 9514, Box 8465
APO AA 91885', 'dark', 1051.0, 'hundred', 'contain', 'into');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_name FROM (SELECT * FROM (SELECT * FROM school ORDER BY ihsaa_class, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Ashley Brennan',)
*/

-- Prediction Query
SELECT school_name FROM school ORDER BY enrollment, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Angel Lewis MD',)
*/