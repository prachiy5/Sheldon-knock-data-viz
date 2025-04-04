--overall knocks by sheldon

 WITH knock_lines AS (
    SELECT dialogue
    FROM sheldon
    WHERE person_scene = 'Sheldon'
      AND dialogue LIKE '%(Knock%'  -- Spoken knocks in parentheses
),
split_words AS (
    SELECT 
        value AS word
    FROM knock_lines
    CROSS APPLY STRING_SPLIT(dialogue, ' ')
)
SELECT COUNT(*) AS total_knocks
FROM split_words
WHERE LOWER(REPLACE(REPLACE(REPLACE(word, ',', ''), '.', ''), '!', '')) = 'knock';


-- total knocks on Penny door: 876
SELECT 
  SUM((len(LOWER(dialogue)) - len(REPLACE(LOWER(dialogue), 'knock', ''))) / len('knock')) AS total_knocks
FROM sheldon
WHERE LOWER(person_scene) = 'sheldon'
  AND LOWER(dialogue) LIKE '%knock%';

--number of scenes sheldon knocked on Penny's Door: 55
  SELECT count(*)
FROM sheldon
WHERE LOWER(person_scene) = 'sheldon'
  AND LOWER(dialogue) LIKE '%knock%'
  AND LOWER(dialogue) LIKE '%penny%';



