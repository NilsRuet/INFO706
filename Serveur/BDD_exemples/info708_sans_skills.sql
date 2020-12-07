-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Lun 07 Décembre 2020 à 09:05
-- Version du serveur :  5.7.32-0ubuntu0.18.04.1
-- Version de PHP :  7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `info708`
--

-- --------------------------------------------------------

--
-- Structure de la table `AssessedSkills`
--

CREATE TABLE `AssessedSkills` (
  `assessment_id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED DEFAULT NULL,
  `skill_id` int(10) UNSIGNED DEFAULT NULL,
  `validationDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `AssessedSkills`
--

INSERT INTO `AssessedSkills` (`assessment_id`, `student_id`, `skill_id`, `validationDate`) VALUES
(1, 1, 1, '2020-11-18'),
(3, 1, 10, '2020-11-11'),
(4, 1, 13, '2019-11-11'),
(7, 1, 10, '2020-12-06');

-- --------------------------------------------------------

--
-- Structure de la table `GlobalSkills`
--

CREATE TABLE `GlobalSkills` (
  `globalSkill_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `GlobalSkills`
--

INSERT INTO `GlobalSkills` (`globalSkill_id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(8),
(10),
(11),
(13),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31);

-- --------------------------------------------------------

--
-- Structure de la table `PersonalSkills`
--

CREATE TABLE `PersonalSkills` (
  `personalSkill_id` int(10) UNSIGNED DEFAULT NULL,
  `student_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `SelfAssessedSkills`
--

CREATE TABLE `SelfAssessedSkills` (
  `assessment_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `SelfAssessedSkills`
--

INSERT INTO `SelfAssessedSkills` (`assessment_id`) VALUES
(1),
(7);

-- --------------------------------------------------------

--
-- Structure de la table `SkillBlocks`
--

CREATE TABLE `SkillBlocks` (
  `skillBlock_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `SkillBlocks`
--

INSERT INTO `SkillBlocks` (`skillBlock_id`, `title`) VALUES
(7, 'Compréhension orale'),
(8, 'Expression orale'),
(9, 'Compréhension écrite'),
(10, 'Expression écrite'),
(11, 'update B Title Block'),
(12, 'empty skill block');

-- --------------------------------------------------------

--
-- Structure de la table `Skills`
--

CREATE TABLE `Skills` (
  `skill_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `id_block` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Skills`
--

INSERT INTO `Skills` (`skill_id`, `name`, `level`, `id_block`) VALUES
(1, 'saluer, dire au revoir', 1, 8),
(2, 'dire comment ça va ou demander comment ça va\r\n', 1, 8),
(3, 'souhaiter un bon anniversaire, une bonne fête à quelqu’un', 1, 8),
(4, 'combler les vides d’une conversation avec des expressions', 2, 8),
(5, 'parler de mon école et ma ville : dire qui sont mes\r\nprofesseurs, dire les bâtiments qu’on y trouve...', 2, 8),
(6, 'parler de ma vie d’écolier : parler de mon emploi du temps,\r\ndes matières scolaires, des horaires ...etc', 2, 8),
(8, 'Comprendre des salutations', 1, 7),
(10, 'Comprendre les questions/informations portant sur mon identité (nom, adresse, lieu de vie, activité, âge... )', 1, 7),
(11, 'Comprendre les nombres jusqu’à 100, les numéros de téléphone, l’âge, l’heure', 1, 7),
(13, 'Comprendre un accord, un désaccord', 2, 7),
(15, 'Comprendre les nombres au delà de 100, les horaires, les prix, les dates', 2, 7),
(16, 'M’appuyer sur des repères culturels connus pour comprendre', 2, 7),
(17, 'Remplir une fiche de renseignements, un questionnaire... etc avec des informations personnelles', 1, 10),
(18, 'Ecrire une carte (carte de vœux, carte d’anniversaire, carte postale pendant les vacances, carte d’invitation ...etc)', 1, 10),
(19, 'Ecrire une description de moi même : identité, physique et caractère.', 1, 10),
(20, 'Raconter une histoire simple avec des connecteurs chronologiques (D’abord, puis, finalement...)', 2, 10),
(21, 'Justifier mes arguments en expliquant la cause, la conséquence, la manière ... etc avec des connecteurs de logique', 2, 10),
(22, 'Réutiliser la méthodologie étudiée en cours pour améliorer mes productions écrites', 2, 10),
(23, 'Comprendre une carte postale, une carte de vœu ou d’anniversaire, une carte d’invitation', 1, 9),
(24, 'Comprendre ce qui est demandé sur une liste (liste de courses, liste de taches domestiques à exécuter ...etc)', 1, 9),
(25, 'Faire les activités scolaires demandées (comprendre les consignes et les appliquer)', 1, 9),
(26, 'Comprendre et identifier différents types de lettres (familière ou formelle)', 2, 9),
(27, 'Dégager le thème principal d’un document écrit (article,fiction, annonce, lettre, ...)', 2, 9),
(28, 'Différencier les personnes ou personnages mentionnés dans un texte en repérant les pronoms et déterminants qui se rapportent à eux.', 2, 9),
(29, 'Ecrire une courte lettre ou un message électronique (email, chat, blog ...etc) pour demander un renseignement ou de l’aide', 2, 10),
(30, 'Ecrire une courte lettre ou un message électronique (email, chat, blog ...etc) pour faire une suggestion / inviter quelqu’un ou réagir à cette suggestion / invitation', 2, 10),
(31, 'Raconter un fait ou une expérience personnelle (réelle ou imaginaire) qui se passe dans le passé, le présent ou le futur', 2, 10);

-- --------------------------------------------------------

--
-- Structure de la table `Students`
--

CREATE TABLE `Students` (
  `student_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Students`
--

INSERT INTO `Students` (`student_id`) VALUES
(1),
(2),
(3),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

-- --------------------------------------------------------

--
-- Structure de la table `TeacherAssessedSkills`
--

CREATE TABLE `TeacherAssessedSkills` (
  `assessment_id` int(10) UNSIGNED DEFAULT NULL,
  `teacher_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `TeacherAssessedSkills`
--

INSERT INTO `TeacherAssessedSkills` (`assessment_id`, `teacher_id`) VALUES
(3, 4),
(4, 4);

-- --------------------------------------------------------

--
-- Structure de la table `Teachers`
--

CREATE TABLE `Teachers` (
  `teacher_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Teachers`
--

INSERT INTO `Teachers` (`teacher_id`) VALUES
(4),
(17);

-- --------------------------------------------------------

--
-- Structure de la table `Users`
--

CREATE TABLE `Users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `picUrl` varchar(500) NOT NULL,
  `google_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Users`
--

INSERT INTO `Users` (`user_id`, `name`, `picUrl`, `google_id`) VALUES
(1, 'Jean', 'https://i.ibb.co/x8M9HH9/1.png', '0'),
(2, 'Pierre', 'https://i.ibb.co/nwJxLQ2/2.png', '0'),
(3, 'Paul', 'https://i.ibb.co/k8H03Fb/3.png', '0'),
(4, 'Jacques', 'https://i.ibb.co/JBQ1y50/4.png', '0'),
(5, 'Charles', 'https://i.ibb.co/vVsrmgz/5.png', '0'),
(17, 'Nils Ruet', 'https://lh4.googleusercontent.com/-xJmdJQQk8xM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmgBXVg-xEp1bGgSIiytGAAU_0_5g/s96-c/photo.jpg', '110017187954083551681'),
(18, 'Justine', 'https://i.ibb.co/zX246sL/6.png', '10'),
(19, 'Gaspard', 'https://i.ibb.co/VxpzTkt/3.png', '20'),
(20, 'Marine', 'https://i.ibb.co/qChVMkB/4.png', '30'),
(21, 'Tony', 'https://i.ibb.co/nfPrj0g/x.png', '40'),
(22, 'Elise', 'https://i.ibb.co/1zRcp5B/2.png', '50'),
(23, 'Gabin', 'https://i.ibb.co/WyqT4Sv/7.png', '60'),
(24, 'Justine', 'https://i.ibb.co/mRLTHC7/10.png', '70'),
(25, 'Antonin', 'https://i.ibb.co/kSsGGNg/9.png', '80'),
(26, 'Fanny', 'https://i.ibb.co/cxx0dHx/5.png', '90'),
(27, 'Aurelien', 'https://i.ibb.co/nmS7qV4/8.png', '100'),
(28, 'Marion', 'https://i.ibb.co/2j8pmD5/11.png', '110'),
(29, 'Sofia', 'https://i.ibb.co/rMPf0DW/12.png', '120'),
(30, 'Elodie', 'https://i.ibb.co/BcmkmhV/13.png', '130');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `AssessedSkills`
--
ALTER TABLE `AssessedSkills`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `fk_as_student_id` (`student_id`),
  ADD KEY `fk_as_skill_id` (`skill_id`);

--
-- Index pour la table `GlobalSkills`
--
ALTER TABLE `GlobalSkills`
  ADD KEY `fk_globalSkill_id` (`globalSkill_id`);

--
-- Index pour la table `PersonalSkills`
--
ALTER TABLE `PersonalSkills`
  ADD KEY `fk_personalSkill_id` (`personalSkill_id`),
  ADD KEY `fk_student_id` (`student_id`);

--
-- Index pour la table `SelfAssessedSkills`
--
ALTER TABLE `SelfAssessedSkills`
  ADD KEY `fk_sas_assessment_id` (`assessment_id`);

--
-- Index pour la table `SkillBlocks`
--
ALTER TABLE `SkillBlocks`
  ADD PRIMARY KEY (`skillBlock_id`);

--
-- Index pour la table `Skills`
--
ALTER TABLE `Skills`
  ADD PRIMARY KEY (`skill_id`),
  ADD KEY `fk_skill_block_id` (`id_block`);

--
-- Index pour la table `Students`
--
ALTER TABLE `Students`
  ADD KEY `fk_student_user_id` (`student_id`);

--
-- Index pour la table `TeacherAssessedSkills`
--
ALTER TABLE `TeacherAssessedSkills`
  ADD KEY `fk_tas_assessment_id` (`assessment_id`),
  ADD KEY `fk_tas_teacher_id` (`teacher_id`);

--
-- Index pour la table `Teachers`
--
ALTER TABLE `Teachers`
  ADD KEY `fk_teacher_user_id` (`teacher_id`);

--
-- Index pour la table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `AssessedSkills`
--
ALTER TABLE `AssessedSkills`
  MODIFY `assessment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `SkillBlocks`
--
ALTER TABLE `SkillBlocks`
  MODIFY `skillBlock_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `Skills`
--
ALTER TABLE `Skills`
  MODIFY `skill_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT pour la table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `AssessedSkills`
--
ALTER TABLE `AssessedSkills`
  ADD CONSTRAINT `fk_as_skill_id` FOREIGN KEY (`skill_id`) REFERENCES `Skills` (`skill_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_as_student_id` FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `GlobalSkills`
--
ALTER TABLE `GlobalSkills`
  ADD CONSTRAINT `fk_globalSkill_id` FOREIGN KEY (`globalSkill_id`) REFERENCES `Skills` (`skill_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `PersonalSkills`
--
ALTER TABLE `PersonalSkills`
  ADD CONSTRAINT `fk_personalSkill_id` FOREIGN KEY (`personalSkill_id`) REFERENCES `Skills` (`skill_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `Students` (`student_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `SelfAssessedSkills`
--
ALTER TABLE `SelfAssessedSkills`
  ADD CONSTRAINT `fk_sas_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `AssessedSkills` (`assessment_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Skills`
--
ALTER TABLE `Skills`
  ADD CONSTRAINT `fk_skill_block_id` FOREIGN KEY (`id_block`) REFERENCES `SkillBlocks` (`skillBlock_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Students`
--
ALTER TABLE `Students`
  ADD CONSTRAINT `fk_student_user_id` FOREIGN KEY (`student_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `TeacherAssessedSkills`
--
ALTER TABLE `TeacherAssessedSkills`
  ADD CONSTRAINT `fk_tas_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `AssessedSkills` (`assessment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tas_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `Teachers` (`teacher_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `Teachers`
--
ALTER TABLE `Teachers`
  ADD CONSTRAINT `fk_teacher_user_id` FOREIGN KEY (`teacher_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
