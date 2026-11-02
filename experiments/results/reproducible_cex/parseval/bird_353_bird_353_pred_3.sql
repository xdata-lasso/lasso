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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__092adf', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 't1__8717cc', 'rmdp', '2022-07-21', -918961358, 1, 'e5u');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1620389964, '00t5c4ecigc', 'e376nium52', 't1__f6fc71', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 't1__8717cc', 'l7', '2024-12-21', -1438850342, 1, 'x1');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 244829661, 'jsl', 'b4yp5qi', 'O', -227162283, 2056419640, 222415430, 556727997, 1178000634, 'pz0f8jegd', -283454505, 233994589, 'j4hwbd', 'lph2gn', 't1__8717cc', 'q', '2023-11-15', -1245682094, 1, 'x');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 722884590, 'hncprjtu0dz', '9fjgq8n2f', 'A', -1056308489, -1454058168, -2078052421, -512640349, 1038566008, 'n6vck6ah0f', 138842628, -932772113, 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', '2024-05-29', 1250290042, -1717646459, 'ri');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 357330522, '68x8vacx7a', 'u5', 'G', -290314193, 76996700, -435350511, 1992637800, -820614248, 't', -1284905200, 7929158, '0v', 'q8qdjpe1', 't1__8717cc', 'o22', '2025-10-23', 199672698, 1, '7cvtjpt');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 1944978593, 'bfkfoacd', '7z2zezj', 't2__9ba4fd', 1448731351, -604098478, 1248858185, -57705450, -915385605, 'm', 1721638020, 983324983, 'ztdg', '5i3', 't1__8717cc', 'q5l', '2022-06-10', -1556979799, 1, 'k58qs27p');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Italian', 't1__092adf', 'w6kl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Italian', 't1__092adf', 'ji7zwau2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Italian', 't1__092adf', 'dwyrq13pyu78');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Italian', 'A', 'tsj3ayxp1q4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Italian', 'A', '01jh3den');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Italian', 'A', 'tg6bnou5zi');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Italian', 't2__9ba4fd', 'r94gth2m');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Italian', 't2__9ba4fd', 'ajjl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 't2__40fa6a', 't1__092adf', '3');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Italian', 't1__092adf', 'okv8uttmu2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Italian', 't1__092adf', 'e578');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, NULL, 't1__092adf', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Italian', 't1__092adf', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Italian', 't1__092adf', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Italian', 't1__092adf', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Italian', 't1__092adf', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Italian', 't1__092adf', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Italian', 't1__092adf', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.totalSetSize FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian';

/*
Gold Result:
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('16nijjai5dh', -1717646459)
('16nijjai5dh', -1717646459)
('16nijjai5dh', -1717646459)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
('t1__8717cc', 1)
*/

-- Prediction Query
SELECT st.translation, s.totalSetSize FROM set_translations AS st JOIN sets AS s ON st.setCode = s.code WHERE st.language = 'Italian';

/*
Prediction Result:
('w6kl', 1)
('ji7zwau2', 1)
('dwyrq13pyu78', 1)
('tsj3ayxp1q4', -1717646459)
('01jh3den', -1717646459)
('tg6bnou5zi', -1717646459)
('okv8uttmu2', 1)
('e578', 1)
('r94gth2m', 1)
('ajjl', 1)
('5k5swwqcgs', 1)
('9n8', 1)
('4', 1)
('gu7v', 1)
('e4', 1)
('hria2ypuzhs', 1)
*/