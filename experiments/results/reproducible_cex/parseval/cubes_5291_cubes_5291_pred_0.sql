-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

-- Inserting into table: entrepreneur --
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483648, -2147483648, 'hria2ypu', 882.963176, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483647, -2147483648, 'rwbbp', 503.083789, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483646, -2147483648, 'hvdlttilbnpr', 986.066566, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483645, -2147483648, 'posiie5unw6k', 768.216462, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483644, -2147483648, 'a9000t5c4eci', 734.586266, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483643, -2147483648, 'e', 467.07027, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483642, -2147483648, 'um5', 452.706544, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483641, -2147483648, 'u', 225.300904, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483640, -2147483648, 'rqrofqyp5s', 499.570479, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483639, -2147483648, 'p', 705.580387, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483638, -2147483648, 'eutliqa11r', 997.73177, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483637, -2147483648, 'oo3o9', 111.926013, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483636, -2147483648, 'lex', 913.303855, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483635, -2147483648, 'i7z', 353.163664, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483634, -2147483648, '2dwyrq', 433.533777, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483633, -2147483648, 'yu78', 49.538289, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483632, -2147483648, 'jsl', 419.361606, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483631, -2147483648, 'p5qi2rk', 811.601922, NULL);

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483630, -2147483648, 'vqx58pz0f', 707.476301, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483629, -2147483648, 'gd', 452.27611, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483628, -2147483648, 'y9uxj4', 124.573829, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483627, -2147483648, 'v', 185.427628, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483626, -2147483648, 'h2gndqwnqcx5', 635.267184, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483625, -2147483648, 'p', 269.734861, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483624, -2147483648, '0dz79f', 154.065416, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483623, -2147483648, 'n2f3dqv0g', 790.551139, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483622, -2147483648, '9', 540.154414, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483621, -2147483648, '3zb', 138.057338, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483620, -2147483648, 'kn6vc', 915.583344, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483619, -2147483648, 'h0f8jswwlq', 842.831917, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483618, -2147483648, '7', 949.322482, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483617, -2147483648, 'xa', 584.342044, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483616, -2147483648, 'fdrz16n', 130.468488, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483615, -2147483648, 'ai5', 62.386264, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483614, -2147483648, 'ogrgjd8y', 763.019095, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483613, -2147483648, '1afgogritsj', 453.914926, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483612, -2147483648, 'p1q430', 947.945777, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483611, -2147483648, '3d', 881.248682, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483610, -2147483648, '8c68', 369.474112, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483609, -2147483648, 'c', 735.057703, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483608, -2147483648, 'afu5w1of7', 517.927187, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483607, -2147483648, '72ct', 51.002063, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483606, -2147483648, 'mfg62g0v5q8q', 53.966914, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483605, -2147483648, 'e1io', 443.690199, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483604, -2147483648, '7cvtjpt', 605.666938, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483603, -2147483648, 'bnou5zi36', 952.850618, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483602, -2147483648, 'f', 166.297151, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483601, -2147483648, 'oacd07z2zez', 147.932394, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483600, -2147483648, 'wgxd5ysxc', 187.71278, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483599, -2147483648, '0oztdgj5i3lq', 913.609637, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483598, -2147483648, 'npi', 197.278049, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483597, -2147483648, '8qs27p2r', 555.274052, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483596, -2147483648, 'th', 577.602934, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483595, -2147483648, 'ajjl', 11.892553, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483594, -2147483648, 'v8u', 311.951038, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483593, -2147483648, 'mu2ne578lf', 988.50905, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483592, -2147483648, 'yz7zzbe8yvk', 743.007715, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483591, -2147483648, 'q7sx58b4', 710.005534, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483590, -2147483648, 'aus3', 13.328055, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483589, -2147483648, 'krpd', 144.157236, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483588, -2147483648, 'w5chn9m', 691.814216, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483587, -2147483648, 'a9n0jxfo', 82.48091, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483586, -2147483648, 'do2zobb', 407.368744, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483585, -2147483648, '32o', 57.929422, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483584, -2147483648, '5am', 938.014057, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483583, -2147483648, 'orlwyngc1dj', 821.485286, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483582, -2147483648, 'rhizgk1yoey', 619.529525, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483581, -2147483648, 'hdt6fuq', 801.297876, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483580, -2147483648, 'uzkb521gwnl', 900.123388, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483579, -2147483648, 'elboeowii', 437.428969, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483578, -2147483648, 'xih6', 946.669761, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483577, -2147483648, '2xlyo', 749.652116, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483576, -2147483648, 'ow9oaawg96a', 725.010524, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483575, -2147483648, 'tbindz3', 555.680342, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483574, -2147483648, 'j', 770.531988, 'ent_e04305');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483573, -2147483648, 'td8n5wcgu', 203.071475, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483572, -2147483648, '3tdu6bd0w960', 460.649748, 'ent_e16758');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (-2147483571, -2147483648, 'xw1rxe9', 382.416063, 'ent_e16758');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor_other AS investor FROM (SELECT LHS.investor AS investor, LHS.maxn AS maxn, RHS.investor AS investor_other, RHS.maxn AS maxn_other FROM (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS LHS CROSS JOIN (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS RHS) WHERE (maxn < maxn_other) ORDER BY investor;

/*
Gold Result:
('ent_e04305',)
('ent_e16758',)
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('ent_e04305',)
*/