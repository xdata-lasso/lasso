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
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (1, 'uuid-1', 'Boros Recruit', 'Creature — Goblin Soldier', 'boros');
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (2, 'uuid-2', 'Boros Recruit', 'Creature — Goblin Soldier', 'boros');
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (3, 'uuid-3', 'Aurelia, the Warleader', 'Legendary Creature — Angel', 'boros');
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (4, 'uuid-4', 'Dimir Signet', 'Artifact', 'dimir');
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (5, 'uuid-5', 'Grizzly Bears', 'Creature — Bear', NULL);
INSERT INTO cards (id, uuid, name, type, watermark) VALUES (6, 'uuid-6', 'Sunhome Guildmage', 'Creature — Human Wizard', 'Boros');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (10, 'uuid-1', 'Boros-Rekrut', 'Kreatur — Goblin, Soldat', 'German');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (11, 'uuid-1', 'Recrue boros', 'Créature : gobelin et soldat', 'French');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (12, 'uuid-2', 'Recluta Boros', 'Criatura — Soldado trasgo', 'Spanish');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (13, 'uuid-4', 'Cachet de Dimir', 'Artefact', 'French');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (14, 'uuid-5', 'Grizzlybären', 'Kreatur — Bär', 'German');
INSERT INTO foreign_data (id, uuid, name, type, language) VALUES (15, 'uuid-6', 'Gildenmagier von Sonnenheim', 'Kreatur — Mensch, Zauberer', 'German');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name, T1.type FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.watermark = 'boros';

/*
Gold Result:
('Boros Recruit', 'Creature — Goblin Soldier')
*/

-- Prediction Query
SELECT fd.name, fd.type FROM foreign_data AS fd JOIN cards AS c ON fd.uuid = c.uuid WHERE c.watermark = 'boros';

/*
Prediction Result:
('Boros-Rekrut', 'Kreatur — Goblin, Soldat')
('Recrue boros', 'Créature : gobelin et soldat')
('Recluta Boros', 'Criatura — Soldado trasgo')
*/