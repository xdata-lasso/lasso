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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 1, NULL, NULL, 0, NULL, 'default2'), (1, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 'default1', 'default1', NULL, 1, 0, 0, NULL, 'Organizer'), (2, 1, '2023-01-01 01:00:00.000000', 'Organizer', '2023-01-01 00:00:00.000000', 'default2', 'Organizer', 'default2', NULL, 1, 1, NULL, 0, 'default1'), (3, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Organizer', NULL, 'Organizer', NULL, NULL, 1, 0, NULL, NULL), (4, 1, NULL, 'default2', '2023-01-01 01:00:00.000000', 'Organizer', 'Organizer', 'Organizer', NULL, 0, NULL, 1, NULL, 'Organizer'), (5, 1, NULL, 'default2', NULL, NULL, 'default1', 'default2', NULL, NULL, 1, NULL, 0, 'default1'), (6, 1, '2023-01-01 01:00:00.000000', 'default2', NULL, NULL, 'default1', NULL, 1, 1, 0, 1, 1, 'default2'), (7, 1, NULL, 'Organizer', '2023-01-01 01:00:00.000000', 'default1', 'default2', NULL, NULL, 0, NULL, NULL, 0, 'Organizer'), (8, 0, '2023-01-01 01:00:00.000000', 'Organizer', NULL, 'default1', 'Organizer', 'Organizer', 0, 1, 0, NULL, 0, NULL), (9, 0, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', NULL, 'default1', 1, 1, 0, 0, NULL, NULL), (10, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'Organizer', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL), (11, NULL, NULL, 'Organizer', '2023-01-01 00:00:00.000000', NULL, 'Organizer', 'Organizer', 0, NULL, 1, NULL, 1, 'Organizer');
INSERT INTO badges (id, userid, name, date) VALUES (0, 11, 'Organizer', '2023-01-01 00:00:00.000000'), (1, NULL, 'default1', '2023-01-01 01:00:00.000000'), (2, 1, 'default2', NULL), (3, 4, 'Organizer', NULL), (4, 8, 'Organizer', '2023-01-01 01:00:00.000000'), (5, 4, 'default2', '2023-01-01 01:00:00.000000'), (6, 10, 'default1', '2023-01-01 01:00:00.000000'), (7, 1, 'Organizer', '2023-01-01 00:00:00.000000'), (8, 5, 'default2', '2023-01-01 00:00:00.000000'), (9, 4, 'Organizer', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2."Name" = 'Organizer';

/*
Gold Result:
('Organizer',)
('default2',)
('Organizer',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT u.DisplayName FROM badges AS b JOIN users AS u ON b.UserId = u.Id WHERE b.Name = 'Organizer';

/*
Prediction Result:
('Organizer',)
('default2',)
(None,)
*/