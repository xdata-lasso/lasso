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
-- DATASET 1
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO users (Id, DisplayName) VALUES (2, 'User2');
INSERT INTO users (Id, DisplayName) VALUES (3, 'User3');
INSERT INTO posts (Id, Title, OwnerUserId) VALUES (3720, 'Target Post', 1);
INSERT INTO posts (Id, Title, OwnerUserId) VALUES (9999, 'Other Post', 2);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (10, 1, 3720, 1);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (11, 2, 3720, 2);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (12, 1, 3720, 1);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (13, 3, 9999, 1);
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (100, 3720, 1, 'Comment 1 by User 1');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (101, 3720, 1, 'Comment 2 by User 1');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (102, 3720, 2, 'Comment 3 by User 2');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (103, 3720, NULL, 'Anonymous Comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (104, 9999, 3, 'Comment on other post');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostHistoryTypeId, (SELECT COUNT(DISTINCT UserId) FROM comments WHERE PostId = 3720) AS NumberOfUsers FROM postHistory AS T1 WHERE T1.PostId = 3720;

/*
Gold Result:
(1, 2)
(2, 2)
(1, 2)
*/

-- Prediction Query
SELECT (SELECT GROUP_CONCAT(DISTINCT PostHistoryTypeId) FROM postHistory WHERE PostId = 3720) AS PostHistoryTypeIDs, (SELECT COUNT(DISTINCT UserId) FROM comments WHERE PostId = 3720) AS UniqueUserCount;

/*
Prediction Result:
('1,2', 2)
*/