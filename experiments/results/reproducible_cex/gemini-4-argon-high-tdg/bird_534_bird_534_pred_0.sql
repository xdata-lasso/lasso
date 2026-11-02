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
-- DATASET 2
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (1, 100, 'Alice', 50, 10, 2, 101, 25);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (2, 200, 'Bob', 50, 20, 1, 102, 30);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (3, 300, 'Charlie', 10, 30, 0, 103, 35);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, Title, OwnerDisplayName) VALUES (1, 1, 10, 50, 1, 'Alice Post 1', 'Alice');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, Title, OwnerDisplayName) VALUES (2, 1, 20, 50, 1, 'Alice Post 2', 'Alice');
INSERT INTO badges (Id, UserId, Name) VALUES (1, 1, 'Badge 1');
INSERT INTO badges (Id, UserId, Name) VALUES (2, 1, 'Badge 2');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1, 1, 5, 'C1', 1, 'Alice');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (2, 2, 5, 'C2', 1, 'Alice');
INSERT INTO votes (Id, PostId, VoteTypeId, UserId) VALUES (1, 1, 2, 1);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId) VALUES (2, 2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE Views = (SELECT MAX(Views) FROM users);

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT DisplayName FROM users ORDER BY Views DESC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/