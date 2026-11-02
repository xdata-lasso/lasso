-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: companies --
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 249.706432, 1.0, 99.523333, '7vfe4h');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483647, 'ia2yp', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 986.066566, 1.0, 666.330692, 'p');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483646, 'siie', 'unw6klfa', '9000t5c4ec', 128.76421, 1.0, 610.208018, 'ce');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1, 'lhs_ab2115', 'lhs_5bda9a', 'lhs_56478a', 1.0, 1.0, 1.0, 'lhs_68df60');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483644, '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, 1.0, 825.231787, 'ut');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483643, 'iqa', '1ryytoo', 'o9hl72kl', 74.250383, 1.0, 776.522001, '14ji7z');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483642, 'au2dwy', 'q13py', '78d99r', 182.777264, 1.0, 943.791649, 'l0b4y');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483641, 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 890.091601, 1.0, NULL, 'y9uxj4');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483640, 'wb', 'v', 'ph2', 109.083092, 1.0, NULL, 'dqwn');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483639, 'cx5hn', 'p', 'jtu0d', 395.809081, 1.0, NULL, 'fjgq8n2f3');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483638, 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 346.706184, NULL, 176.824244, 'xb72fxa7r');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483637, 'fdrz16n', 'jja', '5dh', 488.601669, NULL, 781.755052, 'grgj');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483636, '8', 'yzt1afgogrit', 'sj3ayxp1q430', 947.945777, NULL, 571.595144, 'jh3den8c68');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483635, '8vacx7', 'f', '5w1of7', NULL, 1.0, 517.927187, 'o72ctdc');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483634, 'mfg62', '0v', 'q8qdjpe1', NULL, 1.0, 140.053935, '2278');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483633, '07cvtjpt', 'tg6bnou5zi', '6c4bfkfo', NULL, 1.0, 12.330671, 'cd07z2zezj');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483632, NULL, '7wgx', '5', 377.388457, 1.0, 372.754231, 'r0oz');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483631, NULL, 'dgj5i', 'lq5lnpim', 487.138399, 1.0, 821.273487, 'qs27p2r94');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483630, NULL, 'th', '2mnajjla3o', 904.028668, 1.0, 167.474325, 'uttmu2ne5');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483629, '78lfvyz7zz', NULL, 'be8yvkv42q7', 282.68858, 1.0, 369.678951, '58b4pmaus3a');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483628, 'vmkrpd', NULL, 'wzw', 487.079129, 1.0, 110.207708, 'mo705a9n0');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483627, 'xfo', NULL, 'ws', 900.422166, 1.0, 55.294573, '2zob');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483626, '0', '0k32o', NULL, 57.929422, 1.0, 38.169466, '5am');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483625, 'sorlwyngc1', 'j', NULL, 821.485286, 1.0, 549.267866, 'rhizgk1yoey');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483624, 'o6l0hdt6fu', 'yxuzk', NULL, 20.547158, 1.0, 959.258771, '521gwnlas6e');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483623, 'lboeowii1z5', 'xih6', '2q2xlyoto', 913.199755, 1.0, 547.887692, NULL);

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483622, 'aawg96aqb0tb', 'indz39tajz', 'td8n5wcgu', 203.071475, 1.0, 950.098522, NULL);

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (-2147483621, '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', 111.965818, 1.0, 490.363975, NULL);

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (2, 'y3dohvu0', 'dza35rmki', '18ri', 851.78202, 890.677915, 590.734291, '08ftp6ewtqxx');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (3, 'jaby', 'mzn2mfx7h3', 'p6sto1cj', 835.790392, 291.255711, 902.546958, 'knzys7dy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT industry FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion FROM companies AS LHS INNER JOIN (SELECT profits_billion, COUNT(*) AS n FROM companies GROUP BY profits_billion) AS RHS ON (LHS.id = RHS.n AND LHS.profits_billion = RHS.profits_billion)) ORDER BY industry;

/*
Gold Result:
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/