-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Age" INTEGER, "Name" TEXT, "Nationality" TEXT, "Graduation_College" TEXT);

CREATE TABLE "company" ("Company_ID" REAL PRIMARY KEY, "Name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_in_Billion" REAL, "Profits_in_Billion" REAL, "Assets_in_Billion" REAL, "Market_Value_in_Billion" REAL);

CREATE TABLE "employment" ("Company_ID" INTEGER, "People_ID" INTEGER, "Year_working" INTEGER, PRIMARY KEY ("Company_ID", "People_ID"), FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (582.588439, '5k5swwqcgsk', 'com_fd73ea', '9n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (770.236508, 'ia2yp', 'com_fd73ea', 'uzhsrwbbp6lu', 737.440743, 334.878198, 55.194297, 303.05704);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (125.12763, 'n', 'com_fd73ea', 'rmdp', 227.766936, 971.82669, 133.007885, 75.403642);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (2.0, 'w6kl', 'com_fd73ea', 'a9', 877.276439, 627.258639, 801.414196, 890.762259);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (3.0, '0t5c4ecigce3', 'com_fd73ea', '6nium52zb', 676.357279, 225.300904, 760.580899, 590.639932);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (327.753528, 'qrofq', 'com_fd73ea', 'p5s5bbp', 705.580387, 673.065986, 825.231787, 75.551482);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (297.722676, '1ryytoo', 'G', 'o9hl72kl', 74.250383, 776.522001, 374.674916, 428.830568);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (138.017996, 'i7z', 'G', 'au2dwy', 278.010437, 433.533777, 458.991081, 244.556758);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (251.267403, '78d99r', 'A', 'jsl', 419.361606, 470.165282, 384.969231, 893.990071);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (495.297639, 'f9v', 'G', 'x58pz', 410.133844, 88.474525, 704.657819, 143.865765);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (261.217059, 'd2', 'G', 'vy9uxj4', 124.573829, 22.63964, 328.40866, 989.653112);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (447.109657, 'h2gndqwnqcx5', '!', 'hncprjtu0dz', 521.610309, 654.674676, 92.925632, 94.390081);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (541.805676, 'dqv0gcb9', 'O', 'ozk3zbily', 279.382219, 170.168747, 648.551674, 692.775559);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (708.207154, 'ck6ah0', 'O', '8j', 282.822068, 351.095514, 260.513699, 969.559316);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (450.823993, 'xb72fxa7ryfd', 'A', 'z16ni', 968.276986, 154.68882, 128.858335, 498.231061);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (651.586084, 'grgj', '#', '8', 740.059813, 388.212083, 393.279942, 639.801051);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (121.521559, 'f', '#', 'og', 279.731401, 630.468925, 309.988616, 846.657221);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (849.655083, 'j3ayx', '!', '1q43', 787.642728, 947.945777, 571.595144, 620.748111);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (123.184903, 'den8c68x', NULL, 'vacx7afu5', 354.593207, 432.405958, 850.85096, 80.712613);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (517.927187, 'o72ctdc', NULL, 'mfg62', 93.813527, 935.463334, 492.883123, 691.147113);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (537.702873, 'djpe1', NULL, 'o22', 518.274259, 494.537964, 409.740447, 656.82869);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (966.626935, 'tjpttg', 'com_fd73ea', 'bnou5zi36', 952.850618, 900.959264, 17.379583, 166.297151);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (91.430825, 'acd0', 'com_fd73ea', '7z2zezjo7wg', 790.772456, 50.798088, 486.564401, 286.870177);

INSERT INTO "company" ("company_id", "name", "headquarters", "industry", "sales_in_billion", "profits_in_billion", "assets_in_billion", "market_value_in_billion") VALUES (33.028254, '0oztd', 'com_fd73ea', 'j5', 125.223349, 172.799686, 913.609637, 922.974233);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT headquarters FROM (SELECT * FROM (SELECT * FROM (SELECT company_id, name, headquarters, industry, sales_in_billion, profits_in_billion, assets_in_billion, market_value_in_billion, COUNT(*) OVER () AS n FROM company) ORDER BY profits_in_billion) LIMIT 1);

/*
Gold Result:
('G',)
*/

-- Prediction Query
SELECT Headquarters FROM company GROUP BY Headquarters ORDER BY COUNT(*) DESC, Headquarters NULLS LAST LIMIT 1;

/*
Prediction Result:
('com_fd73ea',)
*/