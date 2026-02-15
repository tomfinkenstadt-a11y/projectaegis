PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS articles (
  id TEXT PRIMARY KEY,
  category_id TEXT NOT NULL,
  title TEXT NOT NULL,
  summary TEXT NOT NULL,
  body_markdown TEXT,
  sort_order INTEGER NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS article_steps (
  id TEXT PRIMARY KEY,
  article_id TEXT NOT NULL,
  step_number INTEGER NOT NULL,
  step_text TEXT NOT NULL,
  FOREIGN KEY (article_id) REFERENCES articles(id)
);

CREATE TABLE IF NOT EXISTS meta (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

INSERT INTO categories (id, name, sort_order) VALUES
('cat-first-aid', 'First Aid', 1),
('cat-fire', 'Fire', 2),
('cat-shelter', 'Shelter', 3),
('cat-water', 'Water', 4);

INSERT INTO articles (id, category_id, title, summary, body_markdown, sort_order) VALUES
('a-fa-1','cat-first-aid','Stop Bleeding: Direct Pressure & Packing','Control severe bleeding fast using pressure and wound packing.',NULL,1),
('a-fa-2','cat-first-aid','Splinting a Limb','Stabilize suspected fractures before moving.',NULL,2),
('a-fa-3','cat-first-aid','CPR Basics (Compression Focus)','Hands-only compression workflow for adults.',NULL,3),
('a-fi-1','cat-fire','Tinder → Kindling → Fuel: Building a Fire','Build in layers so ignition scales reliably.',NULL,1),
('a-fi-2','cat-fire','One-Match Fire Planning','Prepare everything before striking your only match.',NULL,2),
('a-fi-3','cat-fire','Wet Weather Fire: What Actually Works','Methods to light and sustain flame in rain.',NULL,3),
('a-sh-1','cat-shelter','Rule of 3: Shelter First','Prioritize shelter when exposure risk is high.',NULL,1),
('a-sh-2','cat-shelter','Tarp Shelter: A-Frame Setup','Fast A-frame pitch for wind and rain.',NULL,2),
('a-sh-3','cat-shelter','Windbreak + Ground Insulation','Reduce heat loss from wind and ground contact.',NULL,3),
('a-wa-1','cat-water','Find Water: Terrain & Vegetation Signals','Use land clues to locate likely water sources.',NULL,1),
('a-wa-2','cat-water','Purify Water: Boil, Filter, Chemical','Compare practical purification options.',NULL,2),
('a-wa-3','cat-water','Cold Weather Hydration Risk','Avoid dehydration when thirst cues are weak.',NULL,3);

INSERT INTO article_steps (id, article_id, step_number, step_text) VALUES
('s1','a-fa-1',1,'Expose the wound and remove obvious debris.'),
('s2','a-fa-1',2,'Apply firm direct pressure with clean cloth.'),
('s3','a-fa-1',3,'Pack deep wounds with gauze while maintaining pressure.'),
('s4','a-fa-1',4,'Secure with bandage and monitor for re-bleeding.'),
('s5','a-fa-2',1,'Immobilize above and below the injury site.'),
('s6','a-fa-2',2,'Pad rigid supports before placing on limb.'),
('s7','a-fa-2',3,'Tie snugly without cutting off circulation.'),
('s8','a-fa-2',4,'Re-check pulse, warmth, and sensation after splinting.'),
('s9','a-fa-3',1,'Call emergency services or direct someone to call.'),
('s10','a-fa-3',2,'Place hands center chest and lock elbows.'),
('s11','a-fa-3',3,'Compress hard and fast at 100–120/min.'),
('s12','a-fa-3',4,'Continue until help arrives or person recovers.'),
('s13','a-fi-1',1,'Gather dry tinder, pencil-size kindling, then fuel wood.'),
('s14','a-fi-1',2,'Create airflow gap in fire lay.'),
('s15','a-fi-1',3,'Ignite tinder and feed kindling gradually.'),
('s16','a-fi-1',4,'Add larger fuel only after stable flame forms.'),
('s17','a-fi-2',1,'Prep site and all materials before lighting.'),
('s18','a-fi-2',2,'Feather sticks and split damp wood interior.'),
('s19','a-fi-2',3,'Shield flame from wind with your body or wall.'),
('s20','a-fi-2',4,'Strike once and commit immediately to tinder core.'),
('s21','a-fi-3',1,'Harvest dead standing wood, not ground wood.'),
('s22','a-fi-3',2,'Use bark pockets or resin-rich shavings as tinder.'),
('s23','a-fi-3',3,'Build elevated platform to keep fire off wet soil.'),
('s24','a-fi-3',4,'Protect with tarp edge while preserving ventilation.'),
('s25','a-sh-1',1,'Assess weather, wind, and exposure immediately.'),
('s26','a-sh-1',2,'Pick site above flood line and away from hazards.'),
('s27','a-sh-1',3,'Establish overhead cover before fire tasks.'),
('s28','a-sh-1',4,'Insulate ground contact to reduce heat loss.'),
('s29','a-sh-2',1,'Run ridgeline between two anchors at waist height.'),
('s30','a-sh-2',2,'Drape tarp evenly over ridgeline.'),
('s31','a-sh-2',3,'Stake corners at 45° for tension and runoff.'),
('s32','a-sh-2',4,'Adjust one side lower to block prevailing wind.'),
('s33','a-sh-3',1,'Create windbreak with tarp, brush, or terrain.'),
('s34','a-sh-3',2,'Lay dry insulation layer: boughs, leaves, pad.'),
('s35','a-sh-3',3,'Keep sleep system dry with ground barrier.'),
('s36','a-sh-3',4,'Vent moisture to avoid condensation chill.'),
('s37','a-wa-1',1,'Search valley bottoms and green corridors.'),
('s38','a-wa-1',2,'Track animal paths converging downhill.'),
('s39','a-wa-1',3,'Look for seep lines on shaded slopes.'),
('s40','a-wa-1',4,'Collect from clearest source available.'),
('s41','a-wa-2',1,'Boil rolling for 1 minute (longer at altitude).'),
('s42','a-wa-2',2,'Filter particulates before chemical treatment.'),
('s43','a-wa-2',3,'Use tablets per label contact time strictly.'),
('s44','a-wa-2',4,'Store treated water in clean covered container.'),
('s45','a-wa-3',1,'Set drinking intervals; do not rely on thirst.'),
('s46','a-wa-3',2,'Insulate bottle to reduce freezing.'),
('s47','a-wa-3',3,'Monitor urine color and energy levels.'),
('s48','a-wa-3',4,'Warm fluids when possible to encourage intake.');
