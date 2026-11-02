-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483647, 'gu7v', 'e4', 'hria2ypuzhs', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1, 'rhs_8def5d', 'rhs_f6e569', 'rhs_ed61a1', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483645, 'rwbbp6luhvd', 'tti', 'bnp', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483644, 'mdpos', 'ie5', 'nw6klf', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483643, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483642, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483641, 'l7', 'klex14ji', '7zwau2dwyr', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483640, '13pyu', '8d99rljsl', 'b4yp5qi', 3);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483639, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 4);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483638, 'wb', NULL, 'v', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483637, 'ph2', NULL, 'nd', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483636, 'wnqcx', NULL, '5hncprjtu0d', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483635, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', NULL);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483634, 'kn6vc', '6ah', 'f8jswwl', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483633, '7xb72', 'xa', '7ryfdrz16n', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483632, NULL, 'jja', '5dh', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483631, NULL, 'ogrgjd8y', 't1afgog', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483630, NULL, 'itsj3', 'y', 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483629, 'p1q430', 'jh3den8', NULL, 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483628, 'c68x8vacx7', 'f', NULL, 1);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (-2147483627, '5w1of7', 'pzo72ctdc', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT LHS.age AS age, RHS.people_id AS people_id, RHS.district AS district, RHS.name AS name, RHS.party AS party, RHS.age AS age_other FROM (SELECT MIN(age) AS age FROM people) AS LHS CROSS JOIN people AS RHS) WHERE (age = age_other) ORDER BY party;

/*
Gold Result:
(None,)
(None,)
(None,)
('4',)
('5dh',)
('5hncprjtu0d',)
('7ryfdrz16n',)
('7zwau2dwyr',)
('bnp',)
('f8jswwl',)
('hria2ypuzhs',)
('nd',)
('nw6klf',)
('rhs_ed61a1',)
('t1afgog',)
('v',)
('y',)
('ytoo3o9',)
('zbuo4nrqrof',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('ozk3zbily',)
*/