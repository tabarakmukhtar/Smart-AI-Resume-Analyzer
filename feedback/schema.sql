CREATE TABLE IF NOT EXISTS feedback (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rating INTEGER NOT NULL,
    usability_score INTEGER NOT NULL,
    feature_satisfaction INTEGER NOT NULL,
    missing_features TEXT,
    improvement_suggestions TEXT,
    user_experience TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
