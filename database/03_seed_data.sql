-- 3. Seed Product Categories
INSERT INTO staging.product_category_lookup (keyword, category, priority)
VALUES
    ('MUG', 'Kitchenware', 1),
    ('CUP', 'Kitchenware', 1),
    ('PLATE', 'Kitchenware', 1),
    ('TEAPOT', 'Kitchenware', 1),
    ('HEART', 'Décor', 2),
    ('CANDLE', 'Décor', 2),
    ('FRAME', 'Décor', 2),
    ('LANTERN', 'Décor', 2),
    ('CHRISTMAS', 'Seasonal', 3),
    ('HALLOWEEN', 'Seasonal', 3),
    ('BAG', 'Accessories', 4),
    ('PURSE', 'Accessories', 4),
    ('NOTEBOOK', 'Stationery', 5),
    ('CARD', 'Stationery', 5),
    ('TOY', 'Toys & Games', 6),
    ('GAME', 'Toys & Games', 6)
ON CONFLICT (keyword) DO NOTHING;