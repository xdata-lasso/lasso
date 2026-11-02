-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483648, 1, '5k5swwqcgs', 'peo_7ac142', '9n8');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483647, 1, '4', 'peo_7ac142', 'gu7v');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483646, 1, 'e4', 'peo_7ac142', 'hria2ypuzhs');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (1, 700293388, 'wbbp6luhvdlt', 'ilbnp', 'mdpos');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483644, 1, 'ie5', 'peo_7ac142', 'nw6klf');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483643, 1, 'a9000t5c4eci', 'peo_7ac142', 'gce376nium52');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483642, 1, 'zbuo4nrqrof', 'peo_7ac142', 'qyp5s5bbp0');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483641, 1, 'x14ji7zwau2d', 'peo_7ac142', 'yrq13p');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483640, 1, 'u78d99r', 'peo_7ac142', 'jsl');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483639, 1, 'b4yp5qi', 'peo_7ac142', 'rkf9vqx5');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483638, 1, 'pz0f8jegd', 'peo_7ac142', '1vy9uxj4');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483637, 1, 'wb', 'peo_7ac142', 'v');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483636, 1, 'ph2', 'peo_7ac142', 'nd');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483635, 1, 'wnqcx', 'peo_7ac142', '5hncprjtu0d');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483634, 1, '79fjgq8', 'peo_7ac142', 'n2f3dqv0gcb9');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483633, 1, 'ozk3zbily', 'peo_7ac142', 'kn6vc');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483632, 1, '6ah', 'peo_7ac142', 'f8jswwl');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483631, 1, '7xb72', 'peo_7ac142', 'xa');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483630, 1, '7ryfdrz16n', 'peo_7ac142', 'jja');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483629, 1, '5dh', 'peo_7ac142', 'ogrgjd8y');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483628, 1, 't1afgog', 'peo_7ac142', 'itsj3');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483627, 1, 'y', 'peo_7ac142', 'p1q430');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483626, 1, 'jh3den8', 'peo_7ac142', 'c68x8vacx7');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483625, 1, 'f', 'peo_7ac142', '5w1of7');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483624, 1, 'pzo72ctdc', 'peo_7ac142', 'mfg62');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483623, 1, '0v', 'peo_7ac142', 'q8qdjpe1');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483622, 1, 'o22', 'peo_7ac142', '8507cvtjp');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483621, 1, 'ttg6bnou5zi3', 'peo_7ac142', 'c4bfkfoac');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483620, 1, '0', NULL, '7z2zezjo7wg');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483619, 1, 'd5ysxc', NULL, 'r0oz');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483618, 1, 'dgj5i', NULL, 'lq5lnpim');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483617, NULL, 'k58qs27p', 'peo_7ac142', 'r94gth2m');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483616, NULL, 'ajjl', 'peo_7ac142', '3');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483615, NULL, 'okv8uttmu2', 'peo_7ac142', 'e578');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483614, 1, 'fvy', 'peo_7ac142', '7zzbe8y');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483613, 1, 'kv42q7', 'peo_7ac142', 'x58b4');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483612, 1, 'pmaus3auvmkr', 'peo_7ac142', 'pdjwzw5chn9');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483611, 1, 'o705', 'peo_7ac142', 'a9n0jxfofws');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483610, 1, 'do2zobb', 'peo_7ac142', 'q0k32od');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483609, 1, 'cl5ams', 'peo_7ac142', 'orlwyngc1dj');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483608, 1, '9erhizgk1yoe', 'peo_7ac142', 'o6l0hdt');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483607, 1, 'fuqyxuzkb', 'peo_7ac142', '521gwnlas6e');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483606, 1, 'lboeowii1z5', 'peo_7ac142', 'xih6');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483605, 1, '2q2xlyoto', 'peo_7ac142', '9oaawg');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483604, 1, '6aqb0tbin', 'peo_7ac142', 'z');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483603, 1, '9tajz9td', 'peo_7ac142', 'n5wcgumbc');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483602, 1, '3tdu6bd0w960', 'peo_7ac142', 'vzxw1rxe');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483601, 1, '9yfk7qk162n', 'peo_7ac142', '55');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483600, 1, '3dohvu0', 'peo_7ac142', 'dza35rmki');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483599, 1, '18ri', 'peo_7ac142', 'hy08ftp6');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483598, 1, 'wt', 'peo_7ac142', 'xxnja');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483597, 1, 'bymzn2mfx7h3', 'peo_7ac142', 'p6sto1cj');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483596, 1, 'sh5knzys7', 'peo_7ac142', 'y');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483595, 1, 'yd1jmgjach8', 'peo_7ac142', 'qta8y3a17v4y');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483594, 1, 'ma', 'peo_7ac142', 'q3qdpua');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483593, 1, '96rn', 'peo_7ac142', 'dqrhm');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483592, 1, 'wlic7dn2', 'peo_7ac142', 'p490');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483591, 1, 'dmsqtg', 'peo_7ac142', 'lc');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483590, 1, 'qb9i9f', 'peo_7ac142', 'ccukjq1q');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483589, 1, 'ik1yhb', 'peo_7ac142', '8hlst1p');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483588, 1, 'qomiztvb6m', 'peo_7ac142', 'iz78aqql');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483587, 1, 'd8ftb8', 'peo_7ac142', '9114q');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483586, 1, 'r', 'peo_7ac142', '6b');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483585, 1, 'jeuuwsj8kj', 'peo_7ac142', '85');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483584, 1, 'pxlvri', 'peo_7ac142', 'surz0kaqtncg');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483583, 1, 'c8s3b7v88k', 'peo_7ac142', 'dmdbdh');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483582, 1, '6j47n', 'peo_7ac142', 'ar50hs');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483581, 1, 'han', 'peo_7ac142', 'xdpunmw');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483580, 1, 'wx', 'peo_7ac142', 'rlawk');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483579, 1, '14r5dqt', 'peo_7ac142', 'mg97a');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483578, 1, 'z2o20', 'peo_7ac142', 'pj6ddlysu6ip');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483577, 1, 'dk', 'peo_7ac142', 'u2gir31vwq5');

INSERT INTO "people" ("people_id", "age", "name", "nationality", "graduation_college") VALUES (-2147483576, 1, 'oa2sb3u', 'peo_7ac142', 'i1pa');

-- Inserting into table: company --
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (1.0, 'lhs_45de2c', 'lhs_aa8578', 'lhs_adc44b', 1.0, 1.0, 1.0, 1.0);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (0.5, 'lhs_45de2c', 'lhs_aa8578', 'lhs_adc44b', 1.0, 1.0, 1.0, 1.0);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (0.0, '2eutliqa11r', 'ytoo3o9', 'l7', 443.457804, 774.422647, 176.308171, 763.856372);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (-1.0, 'lhs_45de2c', 'lhs_aa8578', 'lhs_adc44b', 1.0, 1.0, 1.0, 1.0);

-- Inserting into table: employment --
INSERT INTO "employment" ("company_id", "people_id", "year_working") VALUES (1, 1, 1);

INSERT INTO "employment" ("company_id", "people_id", "year_working") VALUES (0, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, n AS count___ FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, LHS.people_id AS people_id, LHS.year_working AS year_working, RHS.age AS age, RHS.nationality AS nationality, RHS.n AS n FROM (SELECT LHS.company_id AS company_id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_in_billion AS sales_in_billion, LHS.profits_in_billion AS profits_in_billion, LHS.assets_in_billion AS assets_in_billion, LHS.market_value_in_billion AS market_value_in_billion, RHS.people_id AS people_id, RHS.year_working AS year_working FROM company AS LHS INNER JOIN employment AS RHS ON (LHS.company_id = RHS.company_id)) AS LHS CROSS JOIN (SELECT age, nationality, COUNT(*) AS n FROM people GROUP BY age, nationality) AS RHS) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('2eutliqa11r', 1)
('2eutliqa11r', 3)
('2eutliqa11r', 66)
('lhs_45de2c', 1)
('lhs_45de2c', 3)
('lhs_45de2c', 66)
*/

-- Prediction Query
SELECT T3.Name, COUNT(*) FROM employment AS T1 JOIN people AS T2 ON T1.People_ID = T2.People_ID JOIN company AS T3 ON T1.Company_ID = T3.Company_ID GROUP BY T3.Name;

/*
Prediction Result:
('2eutliqa11r', 1)
('lhs_45de2c', 1)
*/