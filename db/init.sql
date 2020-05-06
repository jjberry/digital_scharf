CREATE DATABASE sanskrit;
ALTER DATABASE sanskrit CHARACTER SET utf8 COLLATE utf8_unicode_ci;
use sanskrit;

CREATE TABLE surface (
    surface_id INT NOT NULL AUTO_INCREMENT,
    devanagari NVARCHAR(255),
    roman NVARCHAR(255),
    verse VARCHAR(20),
    position INT,
    line INT,
    PRIMARY KEY (surface_id)
);

CREATE TABLE sandhi (
    sandhi_id INT NOT NULL AUTO_INCREMENT,
    form NVARCHAR(255),
    inflection VARCHAR(30),
    citation NVARCHAR(255),
    PRIMARY KEY (sandhi_id)
);

CREATE TABLE surface_sandhi (
    ss_id INT NOT NULL AUTO_INCREMENT,
    ss_surface INT NOT NULL,
    ss_sandhi INT NOT NULL,
    PRIMARY KEY (ss_id),
    FOREIGN KEY (ss_surface) REFERENCES surface (surface_id),
    FOREIGN KEY (ss_sandhi) REFERENCES sandhi (sandhi_id)
);

CREATE TABLE glossary (
    glossary_id INT NOT NULL AUTO_INCREMENT,
    citation NVARCHAR (255),
    lexical_id VARCHAR(30),
    definition NVARCHAR(255),
    compound_gloss NVARCHAR(255) NULL,
    has_derivation BIT(1),
    PRIMARY KEY (glossary_id)
);

CREATE TABLE sandhi_glossary (
    sg_id INT NOT NULL AUTO_INCREMENT,
    sg_sandhi INT NOT NULL,
    sg_glossary INT NOT NULL,
    PRIMARY KEY (sg_id),
    FOREIGN KEY (sg_sandhi) REFERENCES sandhi (sandhi_id),
    FOREIGN KEY (sg_glossary) REFERENCES glossary (glossary_id)
);

CREATE TABLE derivation (
    derivation_id INT NOT NULL AUTO_INCREMENT,
    parent INT NOT NULL,
    child INT NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (derivation_id),
    FOREIGN KEY (parent) REFERENCES glossary (glossary_id),
    FOREIGN KEY (child) REFERENCES glossary (glossary_id)
);

INSERT INTO surface
    (surface_id, devanagari, roman, verse, position, line)
VALUES
    (1, N'जनमेजय', N'janamejaya', '3.257.1', 1, 0),
    (2, N'उवाच', N'uvāca', '3.257.1', 2, 0),
    (3, N'एवं', N'evaṃ', '3.257.1', 3, 1),
    (4, N'हृतायां', N'hṛtāyāṃ', '3.257.1', 4, 1),
    (5, N'कृष्णायां', N'kṛṣṇāyāṃ', '3.257.1', 5, 1),
    (6, N'प्राप्य', N'prāpya', '3.257.1', 6, 1),
    (7, N'क्लेशमनुत्तमम्', N'kleśamanuttamam', '3.257.1', 7, 1),
    (8, N'अत', N'ata', '3.257.1', 8, 2),
    (9, N'ऊधर्वं', N'ūrdhvaṃ', '3.257.1', 9, 2),
    (10, N'नरव्याघ्राः', N'naravyāghrāḥ', '3.257.1', 10, 2),
    (11, N'किमकुर्वत', N'kimakurvata', '3.257.1', 11, 2),
    (12, N'पाण्डवाः', N'pāṇḍavāḥ', '3.257.1', 12, 2)
;

INSERT INTO sandhi
    (sandhi_id, form, inflection, citation)
VALUES
    (1, N'janamejaya', 'm1s', N'janamejaya'),
    (2, N'uvāca', '3sa prf', N'√vac'),
    (3, N'evaṃ', 'i', N'evam'),
    (4, N'hṛtāyāṃ', 'f7s', N'hṛta'),
    (5, N'kṛṣṇāyāṃ', 'f7s', N'kṛṣṇā'),
    (6, N'prāpya', 'i', N'prāpya'),
    (7, N'kleśam', 'm2s', N'kleśa'),
    (8, N'anuttamam', 'm2s', N'anuttama'),
    (9, N'ataḥ', 'i', N'atas'),
    (10, N'ūrdhvam', 'i', N'ūrdhvam'),
    (11, N'naravyāghrāḥ', 'm1p', N'naravyāghra'),
    (12, N'kim', 'n2s', N'kim'),
    (13, N'akurvata', '3pm ipf', N'√kṛ'),
    (14, N'pāṇḍavāḥ', 'm1p', N'pāṇḍava')
;

INSERT INTO surface_sandhi
    (ss_surface, ss_sandhi)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (7, 8),
    (8, 9),
    (9, 10),
    (10, 11),
    (11, 12),
    (11, 13), 
    (12, 14)
;

INSERT INTO glossary
    (glossary_id, citation, lexical_id, definition, compound_gloss, has_derivation)
VALUES
    (1, N'janamejaya', 'm pn', N'Janamejaya', NULL, 0),
    (2, N'√vac', 'vt2a', N'say', NULL, 0),
    (3, N'evam', 'adv', N'thus', NULL, 0),
    (4, N'hṛta', 'ppp', N'taken', NULL, 1),
    (5, N'√hṛ', 'vt1am', N'take', NULL, 0),
    (6, N'kṛṣṇā', 'f pn', N'Kṛṣṇā', NULL, 1),
    (7, N'kṛṣṇa', 'adj', N'dark', NULL, 0),
    (8, N'prāpya', 'abs', N'having attained', NULL, 1),
    (9, N'pra√āp', 'vt5a', N'attain', NULL, 0)
    (10, N'kleśa', 'm noun', N'affliction', NULL, 0)
    (11, N'anuttama', 'adj cbv', N'unsurpassed',
        N'avidyamānaḥ uttamaḥ yasmāt saḥ, that in relation to which there is no supreme', 1),
    (12, N'na', 'neg pcl', N'not', NULL, 0),
    (13, N'uttama', 'sup adj', N'highest, supreme', NULL, 1),
    (14, N'ud', 'preverb', N'up', NULL, 0),
    (15, N'-tama', 'affix', N'-tamap 5.3.55', NULL, 0),
    (16, N'atas', 'dem adv', N'from this', NULL, 0),
    (17, N'ūrdhvam', 'adv', N'upward, after', NULL, 0),
    (18, N'naravyāghra', 'm noun ck 2.1.56', N'tiger-like man', N'vyāghraḥ iva naraḥ', 1),
    (19, N'nara', 'm noun', 'man', NULL, 0),
    (20, N'vyāghra', 'm noun', 'tiger', NULL, 0),
    (21, N'kim', 'int pron', N'what', NULL, 0),
    (22, N'√kṛ', 'vt8am', N'do, make', NULL, 0),
    (23, N'pāṇḍava', 'patronymic', N'son of Pāṇḍu', NULL, 1),
    (24, N'pāṇḍu', 'm pn', N'Pāṇḍu', NULL, 1),
    (25, N'pāṇḍu', 'adj', N'pale', NULL, 0),
    (26, N'-a', 'affix', N'-aṇ 4.1.83', NULL, 0)
;

INSERT INTO sandhi_glossary
    (sg_sandhi, sg_glossary)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 6),
    (6, 8),
    (7, 10),
    (8, 11),
    (9, 16),
    (10, 17),
    (11, 18),
    (12, 21),
    (13, 22),
    (14, 23)
;

INSERT INTO derivation
    (parent, child, position)
VALUES
    (4, 5, 1),
    (6, 7, 1),
    (8, 9, 1),
    (11, 12, 1),
    (11, 13, 2),
    (13, 14, 1),
    (13, 15, 2),
    (18, 19, 1),
    (18, 20, 2),
    (23, 24, 1),
    (24, 25, 1),
    (24, 26, 2)
;
