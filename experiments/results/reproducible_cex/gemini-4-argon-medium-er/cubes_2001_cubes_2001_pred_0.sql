-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("StuID") VALUES (1);
INSERT INTO "Student" ("StuID") VALUES (2);
INSERT INTO "Voting_record" ("President_Vote", "Vice_President_Vote", "StuID") VALUES (2, 1, 1);
INSERT INTO "Voting_record" ("President_Vote", "Vice_President_Vote", "StuID") VALUES (1, NULL, 2);
INSERT INTO "Voting_record" ("President_Vote", "Vice_President_Vote", "StuID") VALUES (1, 2, 1);
INSERT INTO "Voting_record" ("President_Vote", "Vice_President_Vote", "StuID") VALUES (NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT president_vote, vice_president_vote FROM voting_record ORDER BY president_vote, vice_president_vote NULLS LAST;

/*
Gold Result:
(None, 1)
(1, 2)
(1, None)
(2, 1)
*/

-- Prediction Query
SELECT DISTINCT President_Vote, VICE_President_Vote FROM VOTING_RECORD;

/*
Prediction Result:
(2, 1)
(1, None)
(1, 2)
(None, 1)
*/