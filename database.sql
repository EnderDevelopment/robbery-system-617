CREATE TABLE IF NOT EXISTS player_robberies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    target_id INT NOT NULL,
    amount INT NOT NULL,
    item_type VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO player_robberies (player_id, target_id, amount, item_type) VALUES
(1, 2, 100, 'money'),
(2, 1, 50, 'black_money');