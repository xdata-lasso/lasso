-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483647, 'gu7v', 'e4', 'hria2ypuzhs', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483646, 'rwbbp6luhvd', 'tti', 'bnp', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (2, 'mdpos', 'ie5', 'nw6klf', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (3, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483645, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483642, 'l7', 'klex14ji', '7zwau2dwyr', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483641, '13pyu', '8d99rljsl', 'b4yp5qi', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483640, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 3);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483639, 'wb', 'v', 'ph2', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483638, 'nd', 'wnqcx', '5hncprjtu0d', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483637, '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 3);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483636, 'kn6vc', '6ah', 'f8jswwl', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483635, '7xb72', 'xa', '7ryfdrz16n', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483634, 'jja', '5dh', 'ogrgjd8y', 3);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483633, 't1afgog', 'itsj3', 'y', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483632, 'p1q430', 'jh3den8', 'c68x8vacx7', 2);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483631, 'f', '5w1of7', 'pzo72ctdc', 3);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483630, 'mfg62', '0v', 'q8qdjpe1', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483629, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483628, 'c4bfkfoac', '0', '7z2zezjo7wg', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483627, 'd5ysxc', 'r0oz', 'dgj5i', NULL);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483626, 'lq5lnpim', 'k58qs27p', 'r94gth2m', NULL);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483625, 'ajjl', '3', 'okv8uttmu2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LEVEL FROM (SELECT LHS.card_number AS card_number, LHS.level AS LEVEL, LHS.n AS n, RHS.card_number AS card_number_other, RHS.name AS name, RHS.hometown AS hometown FROM (SELECT card_number, LEVEL, COUNT(*) AS n FROM member GROUP BY card_number, LEVEL) AS LHS INNER JOIN member AS RHS ON (LHS.level = RHS.level AND LHS.n = RHS.member_id)) ORDER BY LEVEL;

/*
Gold Result:
*/

-- Prediction Query
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY COUNT(*) DESC, LEVEL NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/