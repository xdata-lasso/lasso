-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't2__0b9b9a', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 't2__def7c1', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 't1__645673', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 191.1711, '705a', -1245584612, 903.226183, 'fofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455, 453340472, 211603887, -413043724, 761519897, 1504707292, 955267863, -1156828895, 1483450542, 513375398, 718167481, 1428194830, -1614619556, 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 'A', 'ccukjq1q', 'ik1yhb');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 908.397506, 'v', 2095277250, 959.09934, 'rouir', 'rpo', 'it63xy', 'vm', 'wpp', '6mb3aj0j', 982289268, 493701528, 461842658, -156860347, 1805058154, -270436559, -569461411, 1498496406, 370054768, -1837449583, 1299933788, 679285124, 1752727653, 1394285393, -1052659852, 'sr54o', 'qjektb1d2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 't1__7d9be9', 'c296xiy', 'et8xjhcf46c');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -2072838897, 'foa', 'cd07z2zezjo7', 't2__def7c1', 304189298, -542502665, 1999335832, -526612570, -546516406, 'r0oz', -870767087, -1699185893, '5i3lq5lnpim5', '58q', 'Coldsnap', 's27p2r94gth2', '2022-03-04', 418247369, -1524425594, 'a3o');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 948460309, '8', '9114q', 'code_2', -2063751689, 36589303, -1537647691, 364280973, 1592061050, 'sj8kjh', 1138926079, -609840352, 'lvrisu', 'z0kaq', 'Coldsnap', 'ncgc8', '2023-04-22', 438933248, 180947503, 'dmdbdh');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -958249959, 'uez', 'ctehia3cmvb', 't2__f2cf24', -1077762203, -1798310553, -1174073066, -1853296452, 2056318381, 'f9q82', -1048234032, -388744933, 'ui', '7f8', 'Coldsnap', 'qhi', '2023-07-16', 1190577316, -1727712360, 'gxb5qjlsa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't2__e07ba6', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Coldsnap', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (1, 'o22', 'Italian', 2004147439, 'tjpttg', 'bnou5zi36', '4', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483647, '8hlst1p', 'Italian', -1333785554, 'tvb6m4i', '78aqqlu', '8', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483646, 'j47nxar50', 'Italian', -913430713, 'an', 'xdpunmw', 'wx', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'pe', 'Italian', -977983676, '6', 'sjv8nv3', 'd', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'p4kwi', 'Italian', -150306637, '7j4', 'y795ybv8', 'kr3w4jn2', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, '19xgjja', 'Italian', 2062713020, 'gmukfb5if4', '80terbf', 'kvee', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, 'ltut6', 'Italian', 1143458360, '2cel8m', 'fc', 'mn5', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 'ni', 'Italian', -1800278299, 'bgz5oqxs27', 'h888y1', '253', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, '5', 'Italian', 1772219707, '1ehn1', 'daqq', 'yy', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'snp64hm', 'Italian', -1220782619, '4m0rrw', 'j', '0bp', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'gdwb7jjpl', 'Italian', -604038417, 'lzh42nyj5yrj', '5mq', 'na3', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, '8gfxswb2d0zm', 'Italian', -600498375, 'b', 'otp5qo1k4', 'c6gwnkd4kc', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, 'iikaxzr9', 'Italian', 1008864713, 'hsp9', 'gobb6nrn5u', 'phy', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, 'n', 'Italian', 1487440939, 'y', 'hvyx8s', 'r', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483634, 'fs3qn0b', 'Italian', -1500616, 'rlxcrwfx', '3rzgz84', 'lqme2wb1b3', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483633, 'un66e0', 'Italian', -1576807806, 'olt070zi90o5', 'q833g86', '5zm6dpewew0', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483632, '2p40u2vil', 'Italian', -261109897, 'sad6q5', 'iqoauy0', '3lwh994f', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483631, 'qc1m9gr8xj', 'Italian', 1072042049, 'xd4s', '5il', 'wnd6dvygw', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483630, 'akmwgw73fy3d', 'Italian', -1436037867, 'ptx', 'bl', '10qx6j6d4f', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483629, 'c75m4s2ajdu2', 'Italian', 46301377, 'j90tef', '3u5u77', '9qf9lx8', 't1__7d9be9');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, '9000t5c4ec', 't1__6f95c6', -1683203397, 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '2eutliqa11r', NULL, 2137741668, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '13pyu', 'Italian', 176380444, '9rljsl0b4', 'p5qi2rk', '9v', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'x58pz', 'Italian', -1529584866, 'd2', 'vy9uxj4', 'wb', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'v', 'Italian', 1581736075, 'gndqwnqc', 'x5hncprjtu0', 'z', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, '9fjgq8n2f', 'Italian', -1056308489, 'gcb98oz', '3zb', 'lyr', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'kn6vck6ah0f8', 'Italian', -1520489792, 'wlq7xb', '72fxa7ryfd', 'z16ni', 't1__645673');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'jai', 'Italian', 1746373317, 'h', 'ogrgjd8y', 't1afgog', 't1__645673');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian' ORDER BY T2.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__0b9b9a',)
*/

-- Prediction Query
SELECT T3.name FROM cards AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code INNER JOIN foreign_data AS T3 ON T1.uuid = T3.uuid WHERE T2.name = 'Coldsnap' AND T3.language = 'Italian' ORDER BY T1.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST;

/*
Prediction Result:
('lzh42nyj5yrj',)
('hsp9',)
('y',)
('rlxcrwfx',)
('olt070zi90o5',)
('sad6q5',)
('tjpttg',)
('9rljsl0b4',)
('d2',)
('gndqwnqc',)
('gcb98oz',)
('wlq7xb',)
('h',)
*/