-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'FROM the Vault: Lore', 'rmdp', '2022-07-21', -918961358, -1602639011, 'set_ad1746');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -45536098, 'w6kl', 'a9', 'C', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4', 374105386, 1274489983, 'gce', '76nium52', 'FROM the Vault: Lore', 'zbuo4nrqrof', '2022-11-29', -472966518, -921187550, 'set_ad1746');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, -2070843029, '02eu', 'liqa1', 'A', 2074205376, 274769912, -188151580, 226938182, 90119032, 'lex', 1775126557, -74849714, '7zw', 'au2dwyrq13', 'FROM the Vault: Lore', 'yu78', '2020-07-21', -977635379, 1661181156, 'set_ad1746');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1372125820, '4', 'p5qi2rk', 'code_4', -705985602, 537874887, -461695645, 836513442, 176555546, 'gd', -283454505, 233994589, 'j4hwbd', 'lph2gn', NULL, 'q', '2023-11-15', -1245682094, -1660358170, 'set_ad1746');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -1106350634, 'tu0', 'z', 'code_5', -1748371085, -1742081330, 894242932, -211209314, -1056308489, 'gcb98oz', 1443629118, -155284187, 'i', 'yrk', 'FROM the Vault: Lore', 'n6vck6ah0f', '2025-12-20', -1520489792, -658391922, NULL);

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (4, -1388029300, 'xb72fxa7r', 'fdrz16n', 'code_6', -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 'rg', -1478247928, 1074760385, 't1afgog', 'itsj3', NULL, 'y', '2024-01-17', -106471771, 1235416111, 'jh3den8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (5, 195720193, 'vacx7afu5', '1of77p', 'code_7', -435350511, 1992637800, -820614248, 481546706, -1784554553, '2g0v5q8qd', 569007824, -1139855872, 'io22785', '7cvtjpt', NULL, 'tg6bnou5zi', '2025-03-18', -68044929, -1776877925, 'oa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, 382831862, '0', '7z2zezjo7wg', 'code_8', 1248858185, -57705450, -915385605, -2005628382, 1721638020, '0oztdgj5i3lq', 1816660482, -1212676731, 'm5k', '8qs27p2r', NULL, '4gth2mnaj', '2021-09-30', -1351793914, 1919033056, 'v8u');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, 618058035, '2ne578', 'fvy', 'code_9', -451030047, -2052653308, -489120589, -72442907, -2060082151, 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', 'a9n0jxfo', NULL, 'ws', '2024-06-14', -210159774, 270415200, 'b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (8, -397848196, '0k32odwcl5a', 'msorlwyngc', 'code_10', -323362455, 453340472, 211603887, -413043724, 761519897, 'yoeyo6l', 1428194830, -1614619556, '6fuqy', 'uzkb52', NULL, 'gwnlas6', '2020-09-24', 1468640756, 1048147204, 'eowi');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, -1610380698, '5nxih66', 'q2xlyoto', 'code_11', 1774679448, 205676091, -2094843966, -1048779857, -381485009, 'i', 503053726, -1897615568, '9tajz9td', 'n5wcgumbc', NULL, '3tdu6bd0w960', '2025-03-01', -541917667, -961629819, '9y');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (10, -1046720861, '162nh55y3d', 'ohvu06dza3', 'code_12', 1595632888, 2072023304, 789756515, -1160642134, 769234989, '8ftp6ewtqx', 2013745856, 917362079, 'mzn2mfx', 'h33p6sto1', NULL, 'j', '2023-04-07', -1643065004, -1438303683, 'zys7dyyd1jmg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (11, 729543907, 'c', '8q', 'code_13', 280292620, 620355627, -531872415, -2125172723, 339193890, 'ygmayq3q', 1032339628, 608093726, 'p', '6rntdqrhm', NULL, 'wlic7dn2', '2022-05-10', -1104749933, 379651188, 'dmsqtg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (12, -1872934808, 'u', 'qb9i9f2ccu', 'code_14', -1414362698, 1046248997, 1584429327, -1575692857, 1570917601, 'hb08hlst1pq', 1980131681, 1222311103, 'ztv', '6', NULL, '4iz7', '2020-01-18', 1728201214, -1370566258, '8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (13, 948460309, '8', '9114q', 'code_15', -2063751689, 36589303, -1537647691, 364280973, 1592061050, 'sj8kjh', 1138926079, -609840352, 'lvrisu', 'z0kaq', NULL, 'ncgc8', '2023-04-22', 438933248, 180947503, 'dmdbdh');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT type FROM sets WHERE name LIKE '%FROM the Vault: Lore%';

/*
Gold Result:
('set_ad1746',)
(None,)
('set_ad1746',)
('set_ad1746',)
*/

-- Prediction Query
SELECT type FROM sets WHERE name = 'From the Vault: Lore';

/*
Prediction Result:
*/