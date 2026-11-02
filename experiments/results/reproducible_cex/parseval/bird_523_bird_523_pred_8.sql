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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2012-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 528680845, '76nium52', 'zbuo4nrqrof', 'code_2', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2012-01-01', -1021749117, 392822403, 'yu78');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-1, -346339240, 'yp5qi2rk', '9v', 'code_3', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2012-01-01', -841004020, -361507387, '79fjgq8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, -1255130038, '3d', 'qv0gcb98ozk', 'code_4', -155284187, 1686459626, -1554531873, 982314585, 638024588, '6vck6ah0f8js', -658391922, -1388029300, 'xb72fxa7r', 'fdrz16n', 'jja', '5dh', '2012-01-01', 1583472758, 1449284300, 'gjd8y');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -946046410, 'tsj3ayxp1q4', '01jh3den', 'code_5', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 'q8qdjpe1', 'o22', '2012-01-01', 2004147439, -691774480, 'ptt');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -29242208, '36c', 'bfkfoacd', 'code_6', 2115816682, 76987628, -253138337, 641521863, 304189298, 'xd', 1999335832, -526612570, 'cmr0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', '2012-01-01', 988954859, -1719383707, '2m');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, -1524425594, 'a3o', 'v8u', 'code_7', 618058035, 1553368934, -1252009958, 1908593332, 697257217, '7zzbe8y', -705922211, 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', '2012-01-01', 238533676, -1514700303, 'of');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483641, -1197954156, '0', '0k32o', 'code_8', -1898678660, 440115543, 292557306, 709097796, -984562992, 'yngc1d', 453340472, 211603887, 'rhizgk1yoey', 'o6l0hdt6fu', 'yxuzk', '5', '2012-01-01', -206528034, -1686002788, 'las6');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483640, -268740517, 'nxih662q', 'xlyotow9', 'code_9', 727608179, 456034296, -628433041, 1044710644, 966412849, '0', -850941333, -1216952047, '39tajz9', 'd8n5w', 'g', 'mbc3td', '2012-01-01', 1964331395, -1943814113, '9603vz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483639, -639616320, 'xe9yf', '7qk', 'code_10', 643589729, -1231488097, 956819642, 774922170, 2105860871, 'dohvu06d', -438741674, -154207334, 'rmkio18ri2', 'y0', '8ftp6ewtqx', 'njabym', '2012-01-01', 1528227252, -1277305894, '7h33p6');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483638, -843082635, 'cj8sh5k', 'zys7', 'code_11', 1487347213, 1328948152, -1923069176, -1520090613, 591870819, 'jach8qta8y3', -2125172723, 339193890, 'ygmayq3q', 'dpuap96rnt', 'q', 'hm5wl', '2012-01-01', -1573704891, -1260548409, 'p490');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483637, -934098178, 'gelcu', 'qb9i9f2ccu', 'code_12', -1414362698, 1046248997, 1584429327, -1575692857, 1570917601, 'hb08hlst1pq', 1980131681, 1222311103, 'ztv', '6', '4iz7', 'aqqlud8ft', '2012-01-01', 1183069552, -1057355067, 'e6bje');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483636, 1592061050, 'sj8kjh', '5wpxlvris', 'code_13', 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 'gc8s3b7v88k', -622923312, 1789767331, 'b', 'h', '6j47n', 'ar50hs', '2012-01-01', -1515201134, -2121944911, 'xdpunmw');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_14', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2012-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (5, 1620389964, '00t5c4ecigc', 'e376nium52', 'code_15', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '2012-01-01', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (6, -705985602, 'x58pz0f8je', 'd2', 'code_16', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd', -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', '2012-01-01', 172461907, 1606439408, '3zb');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (8, -1554531873, 'yrkn6vck6ah0', '8j', 'code_17', -932772113, -639539893, 1255343543, -541746689, 1294666887, 'fdrz16n', -1496556994, -2115841792, 'dh5ogrgj', '8', 'yzt1afgogrit', 'sj3ayxp1q430', '2012-01-01', 1923912467, 518609210, '3d');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_18', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '1970-01-01', -45536098, 1861536320, '6klfa9');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (10, -443340271, 'uo4nrqrofqy', '5s5b', 'code_19', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', NULL, -1021749117, 392822403, 'yu78');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (1, 't2__37fcbe', 'code_1', '00t5c4ecigc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 't2__37fcbe', 'code_2', 'jsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, '!', 'code_4', '1afgo');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (0, '!', 'code_3', 'zdo2z');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-1, 'M', 'code_1', 'eowi');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, '3pyu78d99r', 'code_7', 'jsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '4', 'code_7', 'p5qi2rk');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 't2__37fcbe', 'code_3', '8c68');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__a02e24', 'code_12', 'vacx7afu5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, '00t5c4ecigc', 'code_14', 'e376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, '9rljsl0b4', 'code_2', 'p5qi2rk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4, T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.id = T2.id WHERE T1.releaseDate BETWEEN '2012-01-01' AND '2015-12-31' GROUP BY T1.releaseDate ORDER BY COUNT(T2.language) DESC, (CAST(SUM(T1.id) AS REAL) / COUNT(T1.id)) / 4 NULLS LAST, T2.language NULLS LAST LIMIT 1;

/*
Gold Result:
(-89478484.95833333, 't2__37fcbe')
*/

-- Prediction Query
SELECT AVG("id"), (SELECT "language" FROM "set_translations" GROUP BY "language" ORDER BY COUNT("language") DESC, "language" NULLS LAST LIMIT 1) AS common_language FROM "sets" WHERE "releaseDate" BETWEEN '2012-01-01' AND '2015-12-31';

/*
Prediction Result:
(-1263225669.764706, 't2__37fcbe')
*/