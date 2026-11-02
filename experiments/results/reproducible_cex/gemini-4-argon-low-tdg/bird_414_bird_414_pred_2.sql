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
-- Tests basic join, WHERE predicates (block = 'Ravnica', baseSetSize = 180), OR vs AND, and off-by-one/inequality mutations.
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (1, 'GPT', 'Guildpact', 'Ravnica', 180, 165);
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (2, 'RAV', 'Ravnica: City of Guilds', 'Ravnica', 179, 180);
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (3, 'DIS', 'Dissension', 'Ravnica', 181, 180);
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (4, 'CHK', 'Champions of Kamigawa', 'Kamigawa', 180, 306);
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (5, 'MRD', 'Mirrodin', NULL, 180, 306);
INSERT INTO "sets" ("id", "code", "name", "block", "baseSetSize", "totalSetSize") VALUES (6, 'RTR', 'Return to Ravnica', 'Ravnica', NULL, 180);
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (1, 'French', 'GPT', 'Le Pacte des Guildes');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (2, 'German', 'RAV', 'Ravnica: Stadt der Gilden');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (3, 'Spanish', 'DIS', 'Disensión');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (4, 'Italian', 'CHK', 'Campioni di Kamigawa');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (5, 'Japanese', 'MRD', 'ミラディン');
INSERT INTO "set_translations" ("id", "language", "setCode", "translation") VALUES (6, 'Russian', 'RTR', 'Возвращение в Равнику');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Ravnica' AND T1.baseSetSize = 180;

/*
Gold Result:
('French',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 180 AND T1.block = 'Ravnica';

/*
Prediction Result:
('Le Pacte des Guildes',)
*/