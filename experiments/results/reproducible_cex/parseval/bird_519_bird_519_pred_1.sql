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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Battlebond', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, 1419861592, '4ecigce376n', 'um5', 'code_2', 742285925, -747753377, 902887186, -967741825, 775304493, 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', 'Battlebond', '9hl7', '2024-12-21', -1438850342, -305670381, 'i7z');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'code_3', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', NULL, 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (5, -1585009206, '52zb', 'uo4nrqrofqy', 'code_4', -1106983592, 1884179925, 902551284, 2107872094, 882961052, '2eutliqa11r', 2137741668, -525979501, 'oo3o9hl72kl', 'x1', NULL, 'ji7zwau2', '2020-08-25', 1485335077, -511185946, '13pyu');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (7, -705985602, 'x58pz0f8je', 'd2', 'code_5', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd', -736979194, 2103044118, 'h2gndqwnqcx5', 'hncprjtu0dz', NULL, '9fjgq8n2f', '2025-02-11', 806170397, 513454646, '0gcb98');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (9, 1784916884, 'ah0f8jsww', 'q7x', 'code_6', -541746689, 1294666887, -515895469, 1427161052, 564390026, '6nijjai5dh', 1583472758, 1449284300, 'gjd8y', 't1afgog', NULL, 'itsj3', '2020-03-04', 2111987706, -598313376, 'q4301jh');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (11, -683007527, 'x', 'afu5w1of7', 'code_7', 76996700, -435350511, 1992637800, -820614248, 481546706, 'g6', -242584410, -698610044, 'q8qdjpe1io22', '8507cvtjp', NULL, 'ttg6bnou5zi3', '2025-09-22', 1944978593, 1722106924, 'f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (13, 304189298, 'xd', 'ysxcmr0o', 'code_8', 853709925, -870767087, -1699185893, 875300074, -1609653472, 'q5l', 1339733032, -1556979799, 'k58qs27p', 'r94gth2m', NULL, 'ajjl', '2020-02-18', 1919033056, -1428186898, 'uttmu2ne5');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (15, -705922211, 'v42q7sx58b4p', 'aus3', 'code_9', -2090240067, -699574669, 274891948, 609771851, -1934017803, 'wzw5chn9mo70', 628082526, -1245584612, 'xfo', 'ws', NULL, 'do2zobb', '2024-07-26', 375841374, -1449226553, '2odwcl5amso');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (1, 'set_c7e029', 'code_2', 'au2dwyrq13');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'set_c7e029', 'code_1', 'u78d99r');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, '000t5c4ec', 'code_3', 'gce');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '9rljsl0b4', 'code_1', 'p5qi2rk');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'k3zbily', 'code_2', 'kn6vc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'e', 'code_4', '8c68');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'oa', 'code_2', 'cd07z2zezjo7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'vy', 'code_3', '7zzbe8y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (14, 'wyn', 'code_5', 'gc1dj9erhi');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language FROM set_translations WHERE id IN (SELECT id FROM sets WHERE name = 'Battlebond');

/*
Gold Result:
('set_c7e029',)
('set_c7e029',)
*/

-- Prediction Query
SELECT st.language FROM set_translations AS st JOIN sets AS s ON st.setCode = s.code WHERE s.name = 'Battlebond';

/*
Prediction Result:
('set_c7e029',)
('set_c7e029',)
('9rljsl0b4',)
('k3zbily',)
('oa',)
*/