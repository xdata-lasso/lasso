-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO cards (id, name, originalType, colors, setCode, uuid) VALUES (1, 'Executioner''s Capsule', 'Artifact', 'B', 'ALA', 'uuid-201');
INSERT INTO cards (id, name, originalType, colors, setCode, uuid) VALUES (2, 'Executioner''s Capsule', 'Artifact', 'B', 'MMA', 'uuid-202');
INSERT INTO cards (id, name, originalType, colors, setCode, uuid) VALUES (3, 'Nihil Spellbomb', 'Artifact', 'B', 'SOM', 'uuid-203');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (1, 'German', 'Kapsel des Henkers', 'Artefakt', 'uuid-201');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (2, 'French', 'Capsule de l''exécuteur', 'Artefact', 'uuid-201');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (3, 'Spanish', 'Cápsula del verdugo', 'Artefacto', 'uuid-201');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (4, 'Japanese', '処刑人のカプセル', 'アーティファクト', 'uuid-202');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (5, 'Italian', 'Capsula del Carnefice', 'Artefatto', 'uuid-202');
INSERT INTO foreign_data (id, language, name, type, uuid) VALUES (6, 'Russian', 'Нигилистическая Бомба', 'Артефакт', 'uuid-203');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.originalType = 'Artifact' AND T1.colors = 'B';

/*
Gold Result:
("Executioner's Capsule",)
('Nihil Spellbomb',)
*/

-- Prediction Query
SELECT "cards"."name" FROM "cards" INNER JOIN "foreign_data" ON "cards"."uuid" = "foreign_data"."uuid" WHERE "cards"."originaltype" = 'Artifact' AND "cards"."colors" = 'B';

/*
Prediction Result:
("Executioner's Capsule",)
("Executioner's Capsule",)
("Executioner's Capsule",)
("Executioner's Capsule",)
("Executioner's Capsule",)
('Nihil Spellbomb',)
*/