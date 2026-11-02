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
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (1, 9999, 'QuestionOwner', 500);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (2, 8000, 'LowScoreAnswerer', 400);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (3, 100, 'TopAnswerer', 10);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (4, 500, 'MidScoreAnswerer', 200);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (5, 7000, 'EditorUser', 300);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (1, 1, 500, 1000, 1, 5, NULL, 'WrongName1');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (2, 2, 10, 800, 2, 5, 1, 'WrongName2');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (3, 2, 50, 20, 3, 5, 1, 'WrongName3');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (4, 2, 30, 500, 4, 5, 1, 'WrongName4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE Id = (SELECT OwnerUserId FROM posts WHERE NOT ParentId IS NULL ORDER BY Score DESC, posts.id NULLS LAST LIMIT 1);

/*
Gold Result:
('TopAnswerer',)
*/

-- Prediction Query
SELECT p2.OwnerDisplayName FROM posts AS p1 JOIN posts AS p2 ON p1.ParentId = p2.Id WHERE NOT p1.ParentId IS NULL AND NOT p2.OwnerDisplayName IS NULL ORDER BY p1.Score DESC, p1.id NULLS LAST, p2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('WrongName1',)
*/