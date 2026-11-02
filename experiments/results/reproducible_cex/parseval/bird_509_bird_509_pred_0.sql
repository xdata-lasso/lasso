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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, NULL, 'gce376nium52', 'zbuo4nrqrof', 'code_2', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2022-12-09', -1097120355, 244829661, 'jsl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, NULL, 'b4yp5qi', 'rkf9vqx5', 'code_3', 1836127587, -1529584866, 1196308825, 910894705, -283454505, '9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, '9fjgq8n2f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, NULL, 'dqv0gcb9', 'ozk3zbily', 'code_4', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl', 1255343543, -541746689, '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', '2024-05-29', 1250290042, -1717646459, 'ri');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, NULL, 'tsj3ayxp1q4', '01jh3den', 'code_5', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2025-10-23', 199672698, 2119806856, '7cvtjpttg6b');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, 1, 'ou5z', '36c', '@', 1722106924, -2072838897, -1173368267, 382831862, -406331049, 'ezjo7wg', 1248858185, -57705450, 'xcmr0', 'ztdg', '5i3', 'q5l', '2022-06-10', -1556979799, -55240145, '8qs27p2r');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, '4gth2mnaj', 'la3', 'A', 1803796945, 872694102, 618058035, 1553368934, -1252009958, '78lfvyz7', 448935289, 458835042, '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', '2022-08-18', -1934017803, 1105964624, 'w5chn9m');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (4, 1, 'o705a9n0jxfo', 'ws', 'B', 1719800120, -210159774, 270415200, -2071531094, -397848196, '0k32odwcl5a', 292557306, 709097796, 'lwyng', '1', 'j', '9erhizgk1yoe', '2024-04-17', 513375398, 718167481, 'hdt6fuq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (5, 1, 'xuzkb52', 'gwnlas6', '?', -2076274980, 1731324803, -1159083009, -1589605308, -268740517, 'nxih662q', 287256667, 1614799674, 'ow9oaawg96a', 'qb0tbindz39t', 'j', '9td8n5w', '2020-05-31', -1694533100, -1275298282, '3');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, 1, 'tdu6bd0w96', '3vzxw1r', 'D', 237552112, -1046720861, 643589729, -1231488097, 956819642, '5y3dohvu06d', -438741674, -154207334, 'rmkio18ri2', 'y0', '8ftp6ewtqx', 'njabym', '2024-06-25', 687330820, -224390110, 'x7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, 1, '33', '6sto', 'C', -285085577, 170892881, -1643065004, -1438303683, -515419519, 'dyyd1jmgj', -2108844113, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', '2025-06-18', -648564084, -1573704891, 'dn2np490x');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (8, 1, 'm', 'sqtgelcuqb', '`', 1374676344, 238243966, -788896327, -1541581575, -325680600, 'ik1yhb', 1862728578, 1909521477, 'qomi', 'tvb6m4i', '78aqqlu', '8', '2020-12-02', -835782528, 192271618, '9114qbre6bj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, 1, 'uu', 'sj8kjh', '!', 1138926079, -609840352, 486475144, -679850352, 1205111943, '0kaqtnc', 697582781, 428944759, 's3b7v88kw', 'm', 'b', 'h', '2023-05-27', 103252327, -556370776, '50hsj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (10, 1, 'an', 'xdpunmw', '#', -1782325492, -544173163, -958321297, 2015039199, -641927001, '14r5dqt', 1298113538, -1340460158, '7aqz2o20p', '6dd', 'ysu', 'iphdku2gi', '2022-12-26', -176968915, -717865822, 'q51oa2sb3u');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (11, 1, 'i1pa', 'cvwnyq', 'P', -1005394301, 917675957, -1582954378, -1143329124, 1368469085, '63xyf', 1394459557, -1335280432, 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', '2020-10-22', -873300912, 1803900001, 'pgckqwtsr');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (12, 1, '54o6qjektb1', '2', 'F', -460035045, 1794943626, 886926141, 294604606, -1460437682, 'ns47j2ja8dc', -1955129162, -1015337060, 'yrnxs6dvd', 'do2v7t', 'gvplj9fj', 'uun7k1', '2024-08-13', 720126052, 629588446, 'y1og');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (13, 1, 'v1rgeza', 'xc1clupgly', 'E', 139907579, 914471233, -1813651479, -1353862813, -1839279753, '19cy7od033d', -1665891229, -929713613, 'hed2', '9lqv26u331s', 'xpw3', 'bgwkxgi', '2022-05-06', -1919229426, 495658460, '2o3');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (14, 1, 'k', '62ocagj', 'H', 1361395061, 1707457950, -582813835, -572986964, 387548943, 'kuboe8cde', 1557266002, -775706063, 'khllbwvdpu', '5v0eduy9v2z', '29835xo', 'pa', '2020-06-22', 1372042958, 1147974039, 'f0c296xi');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (15, 1, 'et8xjhc', '46', 'G', -2003500453, 1280646590, -568125159, -329270684, -1517724233, 'nv3ddroku', -1963148607, -1652058172, 'a3cmvb7vpc0x', 'fw', 'r1es', 'sf9', '2022-10-27', -213453775, -1721445347, 'huij7f8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM sets ORDER BY baseSetSize DESC, sets.id NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT id FROM sets WHERE basesetsize = (SELECT MAX(basesetsize) FROM sets);

/*
Prediction Result:
(2,)
(3,)
(4,)
(5,)
(6,)
(7,)
(8,)
(9,)
(10,)
(11,)
(12,)
(13,)
(14,)
(15,)
*/