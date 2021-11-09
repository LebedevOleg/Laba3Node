create TABLE users (
    id SERIAL PRIMARY KEY,
    login VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(30),
    is_admin BOOLEAN DEFAULT FALSE,
    is_block BOOLEAN DEFAULT FALSE
);

create TABLE post
(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    text VARCHAR(255),
    date TIMESTAMP,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users (id)
);