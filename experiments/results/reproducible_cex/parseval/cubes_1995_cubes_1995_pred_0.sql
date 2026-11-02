-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Voting_record" ("Class_Senator_Vote" INTEGER, "Class_President_Vote" INTEGER, "Treasurer_Vote" INTEGER, "Secretary_Vote" INTEGER, "Vice_President_Vote" INTEGER, "President_Vote" INTEGER, "StuID" INTEGER, "Registration_Date" TEXT(12), "Election_Cycle" TEXT(12), FOREIGN KEY ("Class_Senator_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Class_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Treasurer_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Secretary_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("Vice_President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("President_Vote") REFERENCES "Student" ("StuID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: voting_record --
INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'Spring');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, NULL, 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', NULL);

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', NULL);

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'vot_fcb659', 'vot_204ebf');

INSERT INTO "voting_record" ("class_senator_vote", "class_president_vote", "treasurer_vote", "secretary_vote", "vice_president_vote", "president_vote", "stuid", "registration_date", "election_cycle") VALUES (1, 1, 1, 1, 1, 1, 1, 'rhs_ba8ff8', 'rhs_3c91da');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "meanage" AS "avg_t1_age_" FROM (SELECT "city_code", "stuid", "meanage", "stuid_other", "registration_date", "election_cycle", "president_vote", "vice_president_vote", "treasurer_vote", "class_president_vote", "class_senator_vote", "stuid" AS "secretary_vote" FROM (SELECT "LHS"."city_code" AS "city_code", "LHS"."stuid" AS "stuid", "LHS"."meanage" AS "meanage", "RHS"."stuid" AS "stuid_other", "RHS"."registration_date" AS "registration_date", "RHS"."election_cycle" AS "election_cycle", "RHS"."president_vote" AS "president_vote", "RHS"."vice_president_vote" AS "vice_president_vote", "RHS"."treasurer_vote" AS "treasurer_vote", "RHS"."class_president_vote" AS "class_president_vote", "RHS"."class_senator_vote" AS "class_senator_vote" FROM (SELECT "city_code", "stuid", AVG("age") AS "meanage" FROM "student" GROUP BY "city_code", "stuid") AS "LHS" INNER JOIN "voting_record" AS "RHS" ON ("LHS"."stuid" = "RHS"."secretary_vote"))) WHERE ("city_code" = 'NYC' AND "election_cycle" <> 'Spring') ORDER BY avg_t1_age_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(T1.Age) FROM STUDENT AS T1 JOIN VOTING_RECORD AS T2 ON T1.StuID = SECRETARY_Vote WHERE T1.city_code = 'NYC' AND T2.Election_Cycle = 'Spring';

/*
Prediction Result:
(None,)
*/