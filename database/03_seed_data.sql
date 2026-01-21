-- 3. Seed Product Categories (Enhanced for Better Coverage)
-- Version: 2.0 - Expanded keyword list to reduce uncategorized products
-- Target: <10% uncategorized products (down from 73.66%)

INSERT INTO staging.product_category_lookup (keyword, category, priority)
VALUES
    -- Kitchenware (Priority 1) - Items used in cooking, dining, food storage
    ('MUG', 'Kitchenware', 1),
    ('CUP', 'Kitchenware', 1),
    ('PLATE', 'Kitchenware', 1),
    ('TEAPOT', 'Kitchenware', 1),
    ('BOWL', 'Kitchenware', 1),
    ('SPOON', 'Kitchenware', 1),
    ('FORK', 'Kitchenware', 1),
    ('KNIFE', 'Kitchenware', 1),
    ('GLASS', 'Kitchenware', 1),
    ('DINNER', 'Kitchenware', 1),
    ('EGG CUP', 'Kitchenware', 1),
    ('SAUCER', 'Kitchenware', 1),
    ('BREAKFAST', 'Kitchenware', 1),
    ('CAKE', 'Kitchenware', 1),
    ('BAKING', 'Kitchenware', 1),
    ('KITCHEN', 'Kitchenware', 1),
    ('JAR', 'Kitchenware', 1),
    ('CONTAINER', 'Kitchenware', 1),
    ('BOTTLE', 'Kitchenware', 1),
    ('TIN', 'Kitchenware', 1),  -- For storage tins
    ('COASTER', 'Kitchenware', 1),
    ('PLACEMAT', 'Kitchenware', 1),
    ('TEA TOWEL', 'Kitchenware', 1),
    ('OVEN GLOVE', 'Kitchenware', 1),
    ('WASHING UP', 'Kitchenware', 1),
    ('APRON', 'Kitchenware', 1),
    ('TABLE CLOTH', 'Kitchenware', 1),
    ('NAPKIN', 'Kitchenware', 1),
    ('MEASURING', 'Kitchenware', 1),
    ('STRAINER', 'Kitchenware', 1),
    ('TRAY', 'Kitchenware', 1),
    -- Additional cooking items
    ('CUTTER', 'Kitchenware', 1),  -- Cookie cutters
    ('LUNCH BOX', 'Kitchenware', 1),
    ('PICNIC', 'Kitchenware', 1),
    ('COFFEE', 'Kitchenware', 1),
    ('TEA', 'Kitchenware', 1),
    ('SUGAR', 'Kitchenware', 1),
    ('PETIT FOUR', 'Kitchenware', 1),  -- Baking cases
    ('CASES', 'Kitchenware', 1),  -- When combined with baking context
    
    -- Décor (Priority 2) - Home decoration items, wall art, ornaments
    ('HEART', 'Décor', 2),
    ('CANDLE', 'Décor', 2),
    ('FRAME', 'Décor', 2),
    ('LANTERN', 'Décor', 2),
    ('DECORATION', 'Décor', 2),
    ('HANGING', 'Décor', 2),
    ('HOLDER', 'Décor', 2),
    ('T-LIGHT', 'Décor', 2),
    ('WREATH', 'Décor', 2),
    ('GARLAND', 'Décor', 2),
    ('WALL', 'Décor', 2),
    ('MIRROR', 'Décor', 2),
    ('VASE', 'Décor', 2),
    ('PHOTO', 'Décor', 2),
    ('PICTURE', 'Décor', 2),
    ('ORNAMENT', 'Décor', 2),
    ('LAMP', 'Décor', 2),
    ('LAMPSHADE', 'Décor', 2),
    ('LIGHT', 'Décor', 2),  -- Fairy lights, string lights
    ('CLOCK', 'Décor', 2),
    ('CUSHION', 'Décor', 2),
    ('MOBILE', 'Décor', 2),  -- Hanging mobiles
    ('SCREEN', 'Décor', 2),  -- Room dividers/screens
    ('HANGER', 'Décor', 2),  -- Wall hangers
    ('HOOK', 'Décor', 2),
    ('PRINT', 'Décor', 2),  -- Wall prints
    ('SIGN', 'Décor', 2),  -- Metal signs, door signs
    ('DOORMAT', 'Décor', 2),
    ('CURTAIN', 'Décor', 2),
    ('CABINET', 'Décor', 2),
    ('DRAWER', 'Décor', 2),
    ('KNOB', 'Décor', 2),  -- Drawer knobs
    ('TOADSTOOL', 'Décor', 2),  -- Decorative items
    ('FAIRY', 'Décor', 2),
    ('PAINTED WOOD', 'Décor', 2),
    ('ARTIFICIAL FLOWER', 'Décor', 2),
    ('CHANDELIER', 'Décor', 2),
    ('OIL BURNER', 'Décor', 2),
    ('NIGHT LIGHT', 'Décor', 2),
    ('INCENSE', 'Décor', 2),
    ('BOOKEND', 'Décor', 2),
    ('PAPERWEIGHT', 'Décor', 2),
    ('MAGAZINE RACK', 'Décor', 2),
    
    -- Seasonal (Priority 3) - Holiday and seasonal items
    ('CHRISTMAS', 'Seasonal', 3),
    ('HALLOWEEN', 'Seasonal', 3),
    ('XMAS', 'Seasonal', 3),
    ('TREE', 'Seasonal', 3),
    ('STOCKING', 'Seasonal', 3),
    ('BAUBLE', 'Seasonal', 3),
    ('EASTER', 'Seasonal', 3),
    ('ADVENT', 'Seasonal', 3),
    ('BUNTING', 'Seasonal', 3),
    ('CHICK', 'Seasonal', 3),  -- Easter chicks
    
    -- Accessories (Priority 4) - Fashion accessories, bags, jewelry
    ('BAG', 'Accessories', 4),
    ('PURSE', 'Accessories', 4),
    ('HANDBAG', 'Accessories', 4),
    ('SHOULDER BAG', 'Accessories', 4),
    ('TOTE', 'Accessories', 4),
    ('BRACELET', 'Accessories', 4),
    ('NECKLACE', 'Accessories', 4),
    ('EARRING', 'Accessories', 4),
    ('WASHBAG', 'Accessories', 4),
    ('COSMETIC', 'Accessories', 4),
    -- Fashion accessories
    ('CHARM', 'Accessories', 4),  -- Phone charms
    ('PHONE CHARM', 'Accessories', 4),
    ('KEY RING', 'Accessories', 4),
    ('KEYRING', 'Accessories', 4),
    ('KEY CHAIN', 'Accessories', 4),
    ('BROOCH', 'Accessories', 4),
    ('HAIRSLIDE', 'Accessories', 4),
    ('HAIR CLIP', 'Accessories', 4),
    ('HAIR COMB', 'Accessories', 4),
    ('UMBRELLA', 'Accessories', 4),
    ('SCARF', 'Accessories', 4),
    ('GLOVES', 'Accessories', 4),
    ('SOCKS', 'Accessories', 4),
    ('SLIPPER', 'Accessories', 4),
    ('LUGGAGE TAG', 'Accessories', 4),
    ('PASSPORT', 'Accessories', 4),
    ('WALLET', 'Accessories', 4),
    ('DIAMANTE', 'Accessories', 4),
    ('BLING', 'Accessories', 4),
    ('TIARA', 'Accessories', 4),
    ('EXPANDABLE RING', 'Accessories', 4),
    ('ENAMEL', 'Accessories', 4),  -- Enamel jewelry
    
    -- Stationery (Priority 5) - Office and writing supplies
    ('NOTEBOOK', 'Stationery', 5),
    ('CARD', 'Stationery', 5),
    ('STICKER', 'Stationery', 5),
    ('PAPER', 'Stationery', 5),
    ('PEN', 'Stationery', 5),
    ('PENCIL', 'Stationery', 5),
    ('GREETING', 'Stationery', 5),
    ('BIRTHDAY CARD', 'Stationery', 5),
    -- Office & writing supplies
    ('JOURNAL', 'Stationery', 5),
    ('SKETCHBOOK', 'Stationery', 5),
    ('POCKET BOOK', 'Stationery', 5),
    ('BOOK BOX', 'Stationery', 5),
    ('SCRAP BOOK', 'Stationery', 5),
    ('BOOKMARK', 'Stationery', 5),
    ('TAPE', 'Stationery', 5),  -- Scotch tape, bookcover tape
    ('STENCIL', 'Stationery', 5),
    ('STAMP', 'Stationery', 5),  -- Rubber stamps
    ('RULER', 'Stationery', 5),
    ('HOLE PUNCH', 'Stationery', 5),
    ('OFFICE', 'Stationery', 5),  -- Office supplies
    ('GIFT TAG', 'Stationery', 5),
    ('WRAP', 'Stationery', 5),  -- Gift wrap
    ('GIFT WRAP', 'Stationery', 5),
    ('ENVELOPE', 'Stationery', 5),

    -- Toys & Games (Priority 6) - Children's toys and games
    ('TOY', 'Toys & Games', 6),
    ('GAME', 'Toys & Games', 6),
    ('SOFT TOY', 'Toys & Games', 6),
    ('PLAYING', 'Toys & Games', 6),
    ('DOLL', 'Toys & Games', 6),
    ('BALLOON', 'Toys & Games', 6),
    ('SPINNING TOP', 'Toys & Games', 6),
    ('JIGSAW', 'Toys & Games', 6),
    ('PUZZLE', 'Toys & Games', 6),
    ('FLYING DISC', 'Toys & Games', 6),
    ('KITE', 'Toys & Games', 6),
    ('MOUSE', 'Toys & Games', 6),  -- Toy mice
    ('TEDDY', 'Toys & Games', 6),
    ('FELTCRAFT', 'Toys & Games', 6),
    ('SPACEBOY', 'Toys & Games', 6),  -- Character toys
    ('CHARLIE', 'Toys & Games', 6),  -- Charlie & Lola
    ('LOLA', 'Toys & Games', 6),
    ('MAGIC DRAWING', 'Toys & Games', 6),
    ('COOKIE CUTTER SET', 'Toys & Games', 6),  -- Children's baking toys
    ('BABY', 'Toys & Games', 6),  -- Baby items
    ('CHILDRENS', 'Toys & Games', 6),
    ('KNITTING KIT', 'Toys & Games', 6),
    ('CRAFT', 'Toys & Games', 6),

    -- Storage & Organization
    ('STORAGE', 'Home & Living', 7),
    ('BASKET', 'Home & Living', 7),
    ('CHEST', 'Home & Living', 7),
    ('BOX', 'Home & Living', 7),
    ('TISSUE BOX', 'Home & Living', 7),

    -- Bedroom & Bathroom
    ('TOWEL', 'Home & Living', 7),
    ('HOT WATER BOTTLE', 'Home & Living', 7),
    ('BATH', 'Home & Living', 7),
    ('SPONGE', 'Home & Living', 7),
    ('TOILET', 'Home & Living', 7),
    ('SOAP', 'Home & Living', 7),

    -- Textiles & Soft Furnishings
    ('BLANKET', 'Home & Living', 7),
    ('THROW', 'Home & Living', 7),
    ('RUG', 'Home & Living', 7),
    ('MAT', 'Home & Living', 7),
    ('PILLOW', 'Home & Living', 7),

    ('GARDEN', 'Garden & Outdoor', 8),
    ('WATERING', 'Garden & Outdoor', 8),
    ('SPADE', 'Garden & Outdoor', 8),
    ('PARASOL', 'Garden & Outdoor', 8),  -- Could be dual-category
    ('SECATEURS', 'Garden & Outdoor', 8),
    ('PLANTER', 'Garden & Outdoor', 8),
    ('OUTDOOR', 'Garden & Outdoor', 8),
    ('HAMMOCK', 'Garden & Outdoor', 8),

    ('CALCULATOR', 'Electronics & Gadgets', 9),
    ('ALARM CLOCK', 'Electronics & Gadgets', 9),
    ('HEADPHONES', 'Electronics & Gadgets', 9),
    ('EAR MUFF', 'Electronics & Gadgets', 9),
    ('TORCH', 'Electronics & Gadgets', 9),
    ('LED', 'Electronics & Gadgets', 9),
    ('PHONE', 'Electronics & Gadgets', 9)
ON CONFLICT (keyword) DO NOTHING;
