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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 0, '2023-01-01 00:00:00.000000', 'default2', NULL, 'Citizen Patrol', 'default1', 'Citizen Patrol', 0, 0, 0, 0, NULL, 'default2'), (1, NULL, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 1, 1, 0, 1, NULL, 'default2'), (2, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', NULL, 'default2', 1, NULL, NULL, 1, 1, NULL), (3, 0, NULL, 'Citizen Patrol', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 0, NULL, 1, 1, 0, 'default1'), (4, 0, NULL, 'default2', '2023-01-01 00:00:00.000000', 'Citizen Patrol', 'default2', NULL, 0, 0, NULL, NULL, NULL, NULL), (5, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'Citizen Patrol', 'default1', NULL, 0, 1, NULL, 0, NULL, NULL), (6, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Citizen Patrol', 'default1', 'default2', NULL, NULL, NULL, 0, NULL, 'default2'), (7, 1, '2023-01-01 00:00:00.000000', 'Citizen Patrol', '2023-01-01 01:00:00.000000', 'Citizen Patrol', 'default2', NULL, 0, NULL, 0, 1, 0, NULL), (8, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Citizen Patrol', 'default2', NULL, 0, 0, 1, NULL, NULL, 'default1'), (9, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'Citizen Patrol', 'default2', 1, 0, NULL, 0, NULL, NULL), (10, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'Citizen Patrol', 'Citizen Patrol', NULL, 0, NULL, 0, 0, 0, NULL), (11, NULL, '2023-01-01 01:00:00.000000', 'Citizen Patrol', NULL, 'default1', NULL, 'default2', NULL, 0, 0, 0, 1, NULL), (12, 0, NULL, 'Citizen Patrol', NULL, 'default1', 'default2', 'Citizen Patrol', NULL, 1, NULL, 1, 0, 'default1');
INSERT INTO badges (id, userid, name, date) VALUES (1, 11, NULL, NULL), (0, 7, 'default2', '2023-01-01 00:00:00.000000'), (2, 0, 'default2', NULL), (3, 3, NULL, '2023-01-01 01:00:00.000000'), (4, 1, 'Citizen Patrol', NULL), (5, NULL, 'Citizen Patrol', '2023-01-01 00:00:00.000000'), (6, 11, 'default1', '2023-01-01 00:00:00.000000'), (7, 9, 'default2', NULL), (8, 7, 'default1', '2023-01-01 01:00:00.000000'), (9, 3, 'Citizen Patrol', '2023-01-01 01:00:00.000000'), (10, NULL, 'default2', '2023-01-01 00:00:00.000000'), (11, 12, 'default1', NULL), (12, 7, 'Citizen Patrol', NULL), (13, 11, 'Citizen Patrol', NULL), (14, 7, 'default2', NULL), (15, 10, 'Citizen Patrol', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(id) FROM badges WHERE "Name" = 'Citizen Patrol';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(UserId) FROM badges WHERE Name = 'Citizen Patrol';

/*
Prediction Result:
(5,)
*/