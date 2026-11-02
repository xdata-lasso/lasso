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
-- Tests basic join, column confusion (OwnerUserId vs LastEditorUserId vs Id), DisplayName confusion (users.DisplayName vs posts.OwnerDisplayName), and WHERE filtering (exact match vs LIKE/substring).
INSERT INTO users (Id, Reputation, DisplayName, Location, AboutMe) VALUES (1, 100, 'WrongByPostId', 'Loc1', 'About1');
INSERT INTO users (Id, Reputation, DisplayName, Location, AboutMe) VALUES (2, 200, 'CorrectOwner', 'Loc2', 'About2');
INSERT INTO users (Id, Reputation, DisplayName, Location, AboutMe) VALUES (3, 300, 'WrongByEditor', 'Loc3', 'About3');
INSERT INTO users (Id, Reputation, DisplayName, Location, AboutMe) VALUES (4, 400, 'OtherPostOwner', 'Loc4', 'About4');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName) VALUES (1, 1, 2, 3, 'Open source tools for visualizing multi-dimensional data?', 'Target body', 'FakeOwnerDisplay', 'FakeEditorDisplay');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName) VALUES (2, 1, 4, 1, 'Other title', 'Open source tools for visualizing multi-dimensional data?', 'OtherDisplay', 'OtherEditor');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Body, OwnerDisplayName, LastEditorDisplayName) VALUES (3, 1, 4, 1, 'Prefix Open source tools for visualizing multi-dimensional data? Suffix', 'Body 3', 'Display3', 'Editor3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Title = 'Open source tools for visualizing multi-dimensional data?';

/*
Gold Result:
('CorrectOwner',)
*/

-- Prediction Query
SELECT LastEditorDisplayName FROM posts WHERE UPPER(Title) = UPPER('Open source tools for visualizing multi-dimensional data');

/*
Prediction Result:
*/