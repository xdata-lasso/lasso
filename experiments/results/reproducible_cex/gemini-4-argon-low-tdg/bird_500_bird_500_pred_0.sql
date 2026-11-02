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
-- Core positive case alongside negative filters:
-- Tests T1.name = 'Fellwar Stone', T2.language = 'Japanese', NOT T2.translation IS NULL, and the join condition T1.setCode = T2.setCode.
-- Also tests schema traps (using sets.name or foreign_data.name instead of set_translations.translation).
INSERT INTO "sets" (id, code, name) VALUES (1, 'DRK', 'The Dark');
INSERT INTO "sets" (id, code, name) VALUES (2, '4ED', 'Fourth Edition');
INSERT INTO "sets" (id, code, name) VALUES (3, '5ED', 'Fifth Edition');
INSERT INTO "sets" (id, code, name) VALUES (4, 'CM2', 'Commander Anthology Volume II');
INSERT INTO "cards" (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (1, 'uuid-1', 'Fellwar Stone', 'Fellwar Stone', 'Fellwar Stone', 'Fellwar Stone', 'DRK');
INSERT INTO "cards" (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (2, 'uuid-2', 'Fellwar Stone', 'Fellwar Stone', 'Fellwar Stone', 'Fellwar Stone', '4ED');
INSERT INTO "cards" (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (3, 'uuid-3', 'Sol Ring', 'Fellwar Stone', 'Fellwar Stone', 'Fellwar Stone', '5ED');
INSERT INTO "cards" (id, uuid, name, asciiName, faceName, flavorName, setCode) VALUES (4, 'uuid-4', 'Fellwar Stone', 'Other', 'Other', 'Other', 'CM2');
INSERT INTO "set_translations" (id, language, setCode, translation) VALUES (1, 'Japanese', 'DRK', 'ザ・ダーク');
INSERT INTO "set_translations" (id, language, setCode, translation) VALUES (2, 'French', 'DRK', 'The Dark FR');
INSERT INTO "set_translations" (id, language, setCode, translation) VALUES (3, 'Japanese', '4ED', NULL);
INSERT INTO "set_translations" (id, language, setCode, translation) VALUES (4, 'Japanese', '5ED', '第５版');
INSERT INTO "foreign_data" (id, language, name, text, uuid) VALUES (1, 'Japanese', 'フェルワーの石', 'Card text in JP', 'uuid-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.translation FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T1.name = 'Fellwar Stone' AND T2.language = 'Japanese' AND NOT T2.translation IS NULL;

/*
Gold Result:
('ザ・ダーク',)
*/

-- Prediction Query
SELECT T4.translation FROM cards AS T1 INNER JOIN sets AS T2 ON T1.setCode = T2.code INNER JOIN set_translations AS T4 ON T2.code = T4.setCode WHERE T1.name = 'Fellwar Stone' AND T4.language = 'Japanese';

/*
Prediction Result:
('ザ・ダーク',)
(None,)
*/