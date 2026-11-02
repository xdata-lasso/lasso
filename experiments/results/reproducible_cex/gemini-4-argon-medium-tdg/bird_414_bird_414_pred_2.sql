-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, DISTINCT vs ALL (duplicate languages), and partial condition failures (OR vs AND, off-by-one boundaries, string prefix/case mismatches).
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (1, 'GPT', 'Ravnica', 180, 180, 'Guildpact', 'expansion');
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (2, 'RAV', 'Ravnica', 306, 306, 'Ravnica: City of Guilds', 'expansion');
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (3, 'DIS', 'Ravnica', 179, 180, 'Dissension', 'expansion');
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (4, 'RTR', 'Return to Ravnica', 180, 274, 'Return to Ravnica', 'expansion');
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (5, 'GTC', 'ravnica', 180, 249, 'Gatecrash', 'expansion');
INSERT INTO "sets" ("id", "code", "block", "baseSetSize", "totalSetSize", "name", "type") VALUES (6, 'DGM', 'Ravnica', 181, 156, 'Dragons Maze', 'expansion');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (10, 'French', 'GPT', 'Le Pacte des Guildes');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (20, 'French', 'GPT', 'Pacte des Guildes Alt');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (30, 'German', 'GPT', 'Gildenbund');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (40, 'Spanish', 'RAV', 'Ravnica');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (50, 'Italian', 'DIS', 'Discordia');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (60, 'Japanese', 'RTR', 'ラヴニカへの回帰');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (70, 'Russian', 'GTC', 'Незваные гости');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (80, 'Korean', 'DGM', '용의 미로');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Ravnica' AND T1.baseSetSize = 180;

/*
Gold Result:
('French',)
('French',)
('German',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 180 AND T1.block = 'Ravnica';

/*
Prediction Result:
('Le Pacte des Guildes',)
('Pacte des Guildes Alt',)
('Gildenbund',)
*/