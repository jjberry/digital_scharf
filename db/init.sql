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
    (5, N'कृष्णायां', N'kṛṣṇāyāṃ', '3.257.1', 5, 1);


INSERT INTO sandhi
    (sandhi_id, form, inflection, citation)
VALUES
    (1, N'janamejaya', 'm1s', N'janamejaya'),
    (2, N'uvāca', '3sa prf', N'√vac'),
    (3, N'evaṃ', 'i', N'evam'),
    (4, N'hṛtāyāṃ', 'f7s', N'hṛta'),
    (5, N'kṛṣṇāyāṃ', 'f7s', N'kṛṣṇā');

INSERT INTO surface_sandhi
    (ss_surface, ss_sandhi)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO glossary
    (glossary_id, citation, lexical_id, definition, compound_gloss, has_derivation)
VALUES
    (1, N'janamejaya', 'm pn', N'Janamejaya', NULL, 0),
    (2, N'√vac', 'vt2a', N'say', NULL, 0),
    (3, N'evam', 'adv', N'thus', NULL, 0),
    (4, N'hṛta', 'ppp', N'taken', NULL, 1),
    (5, N'√hṛ', 'vt1am', N'take', NULL, 0),
    (6, N'kṛṣṇā', 'f pn', N'Kṛṣṇā', NULL, 1),
    (7, N'kṛṣṇa', 'adj', N'dark', NULL, 0);

INSERT INTO sandhi_glossary
    (sg_sandhi, sg_glossary)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 6);

INSERT INTO derivation
    (parent, child, position)
VALUES
    (4, 5, 1),
    (6, 7, 1);
