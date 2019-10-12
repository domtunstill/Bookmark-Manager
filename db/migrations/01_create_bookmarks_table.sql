CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));
CREATE TABLE comments(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks (id), contents VARCHAR(240));
