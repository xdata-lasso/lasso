-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483648, '5k5swwqcgs', '9n8', 'peo_25451f', 1610062532);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483647, 'pgu7vfe4', 'hria2ypuzhs', 'peo_25451f', 700293388);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483646, 'wbbp6luhvdlt', 'ilbnp', 'peo_25451f', 1236688122);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (2, 'dpos', 'ie5', 'peo_25451f', -1209887326);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (3, 'klfa9000t', 'c4ecigce', 'peo_25451f', -1585009206);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483645, '52zb', 'uo4nrqrofqy', 'peo_25451f', -1106983592);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483642, '5bbp0', '2eutliqa11r', 'G', 2137741668);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483641, 'ytoo3o9hl7', 'klex14ji', 'G', -453362185);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483640, 'au2dwyrq13', 'yu78', 'A', 244829661);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483639, 'jsl', 'b4yp5qi', 'O', -227162283);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483638, 'f9v', 'x58pz', 'O', -1529584866);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483637, 'd2', 'vy9uxj4', 'A', -1612443122);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483636, 'd', 'lph2gn', 'G', 1968874827);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483635, 'nqcx5h', 'cprj', 'G', -841004020);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483634, 'dz79fjg', '8n2f3', 'A', 806170397);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483633, 'qv0gcb98ozk', 'zbilyrkn', 'O', -688098735);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483632, '6ah', 'f8jswwl', 'O', 1255343543);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483631, '7', '2fxa7ryfdrz', 'A', 61479715);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483630, 'jja', '5dh', NULL, 1583472758);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483629, 'rg', 'd8y', NULL, 1129658414);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483628, '1afgo', 'ri', NULL, -902895762);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483627, 'ayxp1q43', '1jh3den', 'peo_25451f', 357330522);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483626, '68x8vacx7a', 'u5', 'peo_25451f', -290314193);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483625, 'f77pzo72ctd', 't', 'peo_25451f', -1284905200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('peo_25451f',)
*/