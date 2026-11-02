-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', NULL, 'default1', NULL, 0, 1, 1, 0, 'default2'), (0, NULL, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Sharpie', 'default1', 'default1', NULL, NULL, 0, NULL, 1, 'default2'), (2, 0, '2023-01-01 00:00:00.000000', 'Sharpie', NULL, 'default2', 'Sharpie', 'Sharpie', 1, NULL, 1, 1, 1, NULL), (3, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'Sharpie', 'default2', 0, NULL, 0, 0, 0, 'Sharpie'), (4, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 0, 0, 0, 1, NULL, NULL), (5, 0, NULL, 'Sharpie', '2023-01-01 00:00:00.000000', NULL, NULL, 'Sharpie', 1, NULL, 0, 1, 0, 'Sharpie'), (6, 1, NULL, 'default2', NULL, 'default2', 'default2', 'default1', 1, 0, 0, NULL, NULL, 'Sharpie'), (7, NULL, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 1, NULL, NULL, 0, NULL, 'Sharpie'), (8, 0, '2023-01-01 01:00:00.000000', 'Sharpie', '2023-01-01 01:00:00.000000', 'Sharpie', 'default1', NULL, 0, 1, 1, 0, 0, 'default2'), (9, NULL, NULL, 'Sharpie', '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, 0, 0, 0, 1, 0, 'Sharpie'), (10, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'Sharpie', NULL, 1, 0, 0, 1, 1, 'Sharpie'), (11, 0, NULL, 'default1', '2023-01-01 01:00:00.000000', 'Sharpie', 'Sharpie', 'default2', NULL, NULL, 0, 0, NULL, 'default1'), (12, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default2', NULL, 1, 0, NULL, 0, 'Sharpie'), (13, 0, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'default2', 'Sharpie', 0, 0, 0, 0, 0, NULL), (14, NULL, '2023-01-01 00:00:00.000000', 'Sharpie', '2023-01-01 00:00:00.000000', 'Sharpie', 'default2', 'Sharpie', 0, 1, 1, 1, 0, 'default1'), (15, NULL, NULL, 'Sharpie', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default1', 0, 0, 0, NULL, 1, 'default1'), (16, 0, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'Sharpie', 0, 0, NULL, 0, 1, NULL), (17, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', NULL, NULL, 1, NULL, NULL, NULL, 'Sharpie'), (18, 0, '2023-01-01 01:00:00.000000', 'Sharpie', '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 0, NULL, 1, NULL, NULL, 'Sharpie'), (19, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'Sharpie', 1, 0, 0, NULL, 0, 'Sharpie'), (20, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, 'default1', 'default1', 1, 0, NULL, NULL, 0, 'Sharpie'), (21, 1, NULL, 'default2', NULL, 'default1', 'default1', 'Sharpie', 1, 0, 0, NULL, 0, 'default1'), (22, NULL, '2023-01-01 00:00:00.000000', 'Sharpie', NULL, 'default2', 'Sharpie', NULL, 1, 0, NULL, 1, 1, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (1, 6, 'default1', NULL), (0, NULL, NULL, '2023-01-01 00:00:00.000000'), (2, 7, 'default1', NULL), (3, 14, NULL, NULL), (4, 9, 'default1', NULL), (5, 12, 'default2', '2023-01-01 01:00:00.000000'), (6, 17, 'default2', '2023-01-01 00:00:00.000000'), (7, 22, 'default1', '2023-01-01 00:00:00.000000'), (8, 7, 'Sharpie', NULL), (9, 11, 'default1', NULL), (10, 0, 'default2', '2023-01-01 00:00:00.000000'), (11, 13, NULL, NULL), (12, 4, 'default2', '2023-01-01 01:00:00.000000'), (13, 19, 'Sharpie', '2023-01-01 00:00:00.000000'), (14, 2, 'default1', '2023-01-01 01:00:00.000000'), (15, 16, 'default1', '2023-01-01 00:00:00.000000'), (16, 16, 'Sharpie', NULL), (17, NULL, 'default1', '2023-01-01 01:00:00.000000'), (18, 12, NULL, '2023-01-01 00:00:00.000000'), (19, 3, NULL, NULL), (20, 11, NULL, '2023-01-01 00:00:00.000000'), (21, 3, 'Sharpie', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Sharpie';

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."displayname" = 'Sharpie';

/*
Prediction Result:
(None,)
('default1',)
*/