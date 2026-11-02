-- Schema DDL
CREATE TABLE "wrestler" ("Wrestler_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Reign" TEXT, "Days_held" TEXT, "Location" TEXT, "Event" TEXT);

CREATE TABLE "Elimination" ("Elimination_ID" TEXT PRIMARY KEY, "Wrestler_ID" TEXT, "Team" TEXT, "Eliminated_By" TEXT, "Elimination_Move" TEXT, "Time" TEXT, FOREIGN KEY ("Wrestler_ID") REFERENCES "wrestler" ("Wrestler_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: wrestler --
INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483648, '5k5swwqcgs', '9n8', 'wre_5ad803', '4', 'gu7v');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483647, 'wre_1b058a', 'e4', 'wre_c19d24', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483646, 'wre_1b058a', 'tti', 'wre_59e7fc', 'bnp', 'mdpos');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483645, 'wre_1b058a', 'ie5', 'wre_ee920f', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (1, 'gce376nium52', 'zbuo4nrqrof', 'rhs_262f56', 'rhs_581c97', 'rhs_3d4ecb');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483643, 'qyp5s5bbp0', '2eutliqa11r', 'wre_5ad803', 'ytoo3o9', 'l7');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483642, 'klex14ji', '7zwau2dwyr', 'wre_bdd027', '13pyu', '8d99rljsl');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483641, 'wre_1b058a', 'b4yp5qi', 'wre_c19d24', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483640, 'wre_1b058a', '1vy9uxj4', 'wre_59e7fc', 'wb', 'v');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483639, 'wre_1b058a', 'ph2', 'wre_ee920f', 'nd', 'wnqcx');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483638, '5hncprjtu0d', '79fjgq8', NULL, 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483637, 'wre_1b058a', 'kn6vc', NULL, '6ah', 'f8jswwl');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483636, 'wre_1b058a', '7xb72', 'wre_59e7fc', 'xa', '7ryfdrz16n');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483635, 'wre_1b058a', 'jja', 'wre_ee920f', '5dh', 'ogrgjd8y');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483634, 't1afgog', 'itsj3', 'wre_5ad803', NULL, 'y');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483633, 'wre_1b058a', 'p1q430', NULL, NULL, 'jh3den8');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483632, 'wre_1b058a', 'c68x8vacx7', 'wre_59e7fc', NULL, 'f');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483631, 'wre_1b058a', '5w1of7', 'wre_ee920f', NULL, 'pzo72ctdc');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483630, 'mfg62', '0v', 'wre_5ad803', 'q8qdjpe1', NULL);

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483629, 'wre_1b058a', 'o22', NULL, '8507cvtjp', NULL);

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483628, 'wre_1b058a', 'ttg6bnou5zi3', 'wre_59e7fc', 'c4bfkfoac', NULL);

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483627, 'wre_1b058a', '0', 'wre_ee920f', '7z2zezjo7wg', NULL);

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483626, NULL, 'd5ysxc', 'wre_5ad803', 'r0oz', 'dgj5i');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483625, NULL, 'lq5lnpim', NULL, 'k58qs27p', 'r94gth2m');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483624, NULL, 'ajjl', 'wre_59e7fc', '3', 'okv8uttmu2');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483623, NULL, 'e578', 'wre_ee920f', 'fvy', '7zzbe8y');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483622, 'kv42q7', 'x58b4', 'wre_5ad803', 'pmaus3auvmkr', 'pdjwzw5chn9');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483621, 'wre_1b058a', 'o705', NULL, 'a9n0jxfofws', 'do2zobb');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483620, 'wre_1b058a', 'q0k32od', NULL, 'cl5ams', 'orlwyngc1dj');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483619, 'wre_1b058a', '9erhizgk1yoe', NULL, 'o6l0hdt', 'fuqyxuzkb');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483618, '521gwnlas6e', 'lboeowii1z5', 'wre_5ad803', 'xih6', '2q2xlyoto');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483617, 'wre_1b058a', '9oaawg', NULL, '6aqb0tbin', 'z');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483616, 'wre_1b058a', '9tajz9td', NULL, 'n5wcgumbc', '3tdu6bd0w960');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483615, 'wre_1b058a', 'vzxw1rxe', 'wre_ee920f', '9yfk7qk162n', '55');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483614, '3dohvu0', 'dza35rmki', 'wre_5ad803', '18ri', 'hy08ftp6');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483613, 'wre_1b058a', 'wt', NULL, 'xxnja', 'bymzn2mfx7h3');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483612, 'wre_1b058a', 'p6sto1cj', NULL, 'sh5knzys7', 'y');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (-2147483611, 'wre_1b058a', 'yd1jmgjach8', 'wre_ee920f', 'qta8y3a17v4y', 'ma');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (2, 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490');

INSERT INTO "wrestler" ("wrestler_id", "name", "reign", "days_held", "location", "event") VALUES (3, 'dmsqtg', 'lc', 'qb9i9f', 'ccukjq1q', 'ik1yhb');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.days_held AS days_held, RHS.wrestler_id AS wrestler_id, RHS.days_held AS days_held_other, RHS.location AS LOCATION, RHS.event AS event FROM (SELECT name, MIN(days_held) AS days_held FROM wrestler GROUP BY name) AS LHS INNER JOIN wrestler AS RHS ON (LHS.name = RHS.name AND LHS.days_held = RHS.reign)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT Name FROM wrestler ORDER BY Days_held ASC, wrestler.wrestler_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('5hncprjtu0d',)
*/