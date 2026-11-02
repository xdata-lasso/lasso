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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', NULL, 'set_208ee3', 'n', '2022-09-14', 1236688122, 2087640001, 'dposiie5unw');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -1399556171, 'a9000t5c4eci', 'gce376nium52', 'C', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', NULL, 'set_208ee3', 'ytoo3o9', '2021-04-03', 90119032, -1438850342, 'x1');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, -74849714, '7zw', 'au2dwyrq13', 'A', 2142703426, -533293970, 176380444, -977635379, 1661181156, '0b4', 1649269347, -1116181514, 'i2rkf', NULL, 'set_208ee3', 'vqx58pz0f', '2021-08-12', -1937207087, 1675430660, 'y9uxj4');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (4, -1612443122, 'd', 'lph2gn', 'code_4', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz', -1748371085, -1742081330, 'n2f3dqv0g', 'set_e777c9', 'cb98ozk3zbil', 'yrkn6vck6ah0', '2021-01-15', 138842628, -932772113, 'lq7xb7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (5, 602161869, 'xa', '7ryfdrz16n', 'code_5', -1496556994, -2115841792, 1746373317, 1360271423, 1583472758, 'rg', -1478247928, 1074760385, 't1afgog', NULL, 'itsj3', 'y', '2024-01-17', -106471771, 1235416111, 'jh3den8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, 195720193, 'vacx7afu5', '1of77p', 'code_6', -435350511, 1992637800, -820614248, 481546706, -1784554553, '2g0v5q8qd', 569007824, -1139855872, 'io22785', NULL, '7cvtjpt', 'tg6bnou5zi', '2025-03-18', -68044929, -1776877925, 'oa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, 382831862, '0', '7z2zezjo7wg', 'code_7', 1248858185, -57705450, -915385605, -2005628382, 1721638020, '0oztdgj5i3lq', 1816660482, -1212676731, 'm5k', NULL, '8qs27p2r', '4gth2mnaj', '2021-09-30', -1351793914, 1919033056, 'v8u');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (8, 618058035, '2ne578', 'fvy', 'code_8', -451030047, -2052653308, -489120589, -72442907, -2060082151, 'pmaus3auvmkr', 609771851, -1934017803, 'wzw5chn9mo70', NULL, 'a9n0jxfo', 'ws', '2024-06-14', -210159774, 270415200, 'b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, -397848196, '0k32odwcl5a', 'msorlwyngc', 'code_9', -323362455, 453340472, 211603887, -413043724, 761519897, 'yoeyo6l', 1428194830, -1614619556, '6fuqy', NULL, 'uzkb52', 'gwnlas6', '2020-09-24', 1468640756, 1048147204, 'eowi');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (10, -1610380698, '5nxih66', 'q2xlyoto', 'code_10', 1774679448, 205676091, -2094843966, -1048779857, -381485009, 'i', 503053726, -1897615568, '9tajz9td', NULL, 'n5wcgumbc', '3tdu6bd0w960', '2025-03-01', -541917667, -961629819, '9y');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (11, -1046720861, '162nh55y3d', 'ohvu06dza3', 'code_11', 1595632888, 2072023304, 789756515, -1160642134, 769234989, '8ftp6ewtqx', 2013745856, 917362079, 'mzn2mfx', NULL, 'h33p6sto1', 'j', '2023-04-07', -1643065004, -1438303683, 'zys7dyyd1jmg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (12, 729543907, 'c', '8q', 'code_12', 280292620, 620355627, -531872415, -2125172723, 339193890, 'ygmayq3q', 1032339628, 608093726, 'p', NULL, '6rntdqrhm', 'wlic7dn2', '2022-05-10', -1104749933, 379651188, 'dmsqtg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (13, -1872934808, 'u', 'qb9i9f2ccu', 'code_13', -1414362698, 1046248997, 1584429327, -1575692857, 1570917601, 'hb08hlst1pq', 1980131681, 1222311103, 'ztv', NULL, '6', '4iz7', '2020-01-18', 1728201214, -1370566258, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM sets WHERE mtgoCode IS NULL ORDER BY name, sets.id NULLS LAST LIMIT 3;

/*
Gold Result:
('6',)
('6rntdqrhm',)
('7cvtjpt',)
*/

-- Prediction Query
SELECT "code", "name" FROM "sets" WHERE "mtgoCode" IS NULL OR "mtgoCode" = '' ORDER BY "name" ASC, sets.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('code_13', '6')
('code_12', '6rntdqrhm')
('code_6', '7cvtjpt')
*/