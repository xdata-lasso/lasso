-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'Creature', 't1__f44359', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 452.630377, '94gth', 333302050, 193.695314, 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274, -1140595602, 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'C', 'ma', 'q3qdpua');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', 597.166359, 'omizt', 1793241362, 17.438617, '4iz7', 'aqqlud8ft', '8', '9114q', 'r', '6b', -1537647691, 364280973, 1592061050, -1451520332, -55270062, -1101814296, 1939337883, -996196097, 986268139, 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 697582781, 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', 'A', '7k10', 'z2my1ogyv1r');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 192.956867, '1l2o3ak16', 1562909425, 224.501855, 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', -699425950, -432771718, 516500236, 171585273, 1870044139, -1147311649, 1599672055, 745344960, -563021857, -2062902911, -1809620481, -1963064871, 8608094, -1863057592, -538774731, 'hcf46cfperxa', '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', '_', 'mxwdb7o', 'p5qo1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'c3i', 'kax', 'r90nhsp', 'gobb6nrn5', 'jphybn', 'a', 'vhvyx8s', 'r', 'fs3qn0b', 835.467188, 'm2rlxcrw', 1839708185, 368.867616, '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 1636393410, 1939546744, 1290157948, 2014227445, -1133072015, -243587307, 1147327289, 770112293, -261109897, -555808510, -2091367850, 1367239582, 579664554, -463551703, -1030741026, 'u', '023lwh9', '4fqc1m9gr', 'xjqbloxd4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', '3dkdipt', 'fbl10q', '6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', 'v3r3u', 'doxa0o', 'l1zmjrssbh', '2404qpp33', '3a1ngqu', '8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'O', 'pg1lcg', 'a4gkjog8d');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd', 'w89qy', 'sru4eufio', '8o', 854.858382, '6b', 1388472267, 102.316664, 'adfhj', '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', -130254436, -1765864585, 1358642481, -273635449, 680304659, -115971578, 774567335, -30821492, 455841204, -200145376, 1696094807, 598317289, -471858269, 419954312, 1673358342, 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', 'Q', '42p20g', 'tfhk1l');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483642, 'c2vfghixbugx', 'slq', 'isdq44u2', 'kz', 'w', '3q5br3', 'qobvbj26k', 'xc56', 'pvp0h2fln', 311.980946, 'cor', -1042280380, 179.888512, 'uodbvf3ya6l4', '1gfeg6q6', 'if', 'tvx', '41zjf', '1qj3se4dpb4l', 2033372614, 270795691, -264694280, 196492760, -1127007729, 2144707422, -1434769338, -15764418, -1814058838, -29054318, 1450323131, 934708702, 302385175, 1767626260, -1624769339, '0w', 'tzip2a6', 'd2hqs4zc192', '82rnfvkr', 'foqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 'wraqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '7swb3349kf', '5l6rnd3rhb', 'nmbp96v512', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', 'I', '75w5nag', 'rj6o317kajtw');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483641, '94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', '7wggg', '0zchdq8o', 'xze42', 175.689558, 'enn4ilc3kspw', -1690083994, 790.288711, 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', '1whx1dlzbb', '27z', 1833037259, 1037475941, -662103113, -1862877787, -1585814665, -270409176, 1211763656, -1068238654, -237981586, -1831394002, 1327838637, 1460090168, 2134974396, -674436733, 1405721813, 'axg0g', 'xot6v', '1lrh', 'qsxyubeyhmlr', 'ycz8', '5', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', '80z', 'qe9rs1z82tw', '4o1sqir', 'hj1', 'xi', 'o9km29vphx5v', '7jo', 'y', '1skvh4q', 'y4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc', '84vxo5', 't2__c6db06', 'ddfra', '2n0lwczduqt0');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483640, '8ol79cnlvwnz', 'kcpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', '1864', '9', '9n', 581.585134, '6bb6tec', -2122365401, 231.5989, 'mpzf5tuls', 'ok6vhgc3b0v', '93muo9o5', 'cwanc56gwfu', 'y2vtctr95snh', 'c1jc1', 470534297, -197507241, 155279221, -1034567822, -1615622566, 2112315535, 372754157, 1074058348, -1639499826, -310973108, 178806106, -1752787984, 1620805288, -656263235, -1276271585, 'vftaq6', '5qvero7mfr86', 'ok7p', '50qbw', 'hbiszzg8eiz', '0', 'u', 'hg8m', 'vz', 'qiwb', 'o', '90a5nxzf', 'as9e', 'zdfe0r841i6v', '9a6h', 'qzy', 'etff9znz5', 'a', 'yzmae7whkuxo', '6stk1uxpevo', 'sy9i6bswqb', 'oyhady', '3jap', 'pzj', '2', 'zxpmaspu0abl', 'jufkhq6sd', 'hg28jca', 'wtu', 'mvp19dvetw', 'ec1zu80x72pb', 'z2fp2sr', 's', 'd57xpoym', '4yz', 'effs4e', 't3__a59e34', 'yc4ssva8', '6iviizc5');

-- Inserting into table: legalities --
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483648, '8507cvtjp', 'Legal', 't1__f44359');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483647, '96rn', 'Legal', 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483646, 'xc1clupgly', 'Legal', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483645, 'w16f5tqhjd', 'Legal', 'O');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483644, 'r2tzdlb6i4', 'Legal', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483643, 'bjksuye6', 'Legal', 'Q');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483642, '60sijuf', 'Legal', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483641, 'ig197gelrrul', 'Legal', 't2__c6db06');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (2, 'd', 'Legal', 't3__a59e34');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (3, 'lp4', 'Legal', 't3__a59e34');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483638, '506p6790', 'Legal', 't2__c6db06');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483637, 'fs830rj63fqs', 'Legal', 't2__c6db06');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483636, 'paop643z', 't3__7e1db2', 't1__f44359');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483635, 'p091mps38ve', 'Legal', 't1__f44359');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483634, '5f', 'Legal', 't1__f44359');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (4, 'qcgsk9', 'Legal', 't1__f44359');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (5, 'hria2ypu', 'Legal', 't1__f44359');

-- Inserting into table: rulings --
INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483648, '2023-06-01', 'tg6bnou5zi', 't1__f44359');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483647, '2021-02-18', 'za', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483646, '2021-10-22', 'c6gwnkd4', '_');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483645, '2025-06-19', 'abmk', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483644, '2024-12-26', 'tew5c29d', 'O');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483643, '2021-05-03', 'zboodl', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483642, '2025-11-12', 'qiuj9', 'I');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (2, '2023-12-30', 'l', 't2__c6db06');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (3, '2021-05-08', 'kbtog', 't2__c6db06');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483639, '2022-01-04', '1l0q4nksw', 't3__a59e34');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483638, '2025-05-30', '0da', 't3__a59e34');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483637, '2024-06-24', 'mbwzk', 't3__a59e34');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483636, '2025-06-26', 'p37ekwhfm81', 't1__f44359');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483635, '2023-09-27', '5utc4wz1h52', 't1__f44359');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483634, '2024-01-30', '5rr8lvq', 't1__f44359');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (4, '2025-06-17', '5sw', 't1__f44359');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (5, '2022-04-27', '8c4pgu7vfe', 't1__f44359');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid INNER JOIN legalities AS T3 ON T1.uuid = T3.uuid WHERE T3.status = 'Legal' AND T1.types = 'Creature';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT cards.id FROM cards INNER JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.type = 'Creature' AND legalities.status = 'Legal';

/*
Prediction Result:
*/