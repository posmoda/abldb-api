-- --------------------------------------------------------
-- ホスト:                          127.0.0.1
-- サーバーのバージョン:                   10.4.12-MariaDB - mariadb.org binary distribution
-- サーバー OS:                      Win64
-- HeidiSQL バージョン:               11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- abldb のデータベース構造をダンプしています
CREATE DATABASE IF NOT EXISTS `abldb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `abldb`;

--  テーブル abldb.blood_exam の構造をダンプしています
CREATE TABLE IF NOT EXISTS `blood_exam` (
  `patient_serial_number` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `cre` float(10,5) DEFAULT NULL,
  `bnp` float(10,5) DEFAULT NULL,
  PRIMARY KEY (`patient_serial_number`),
  CONSTRAINT `fk_blood_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.blood_exam: ~0 rows (約) のデータをダンプしています
DELETE FROM `blood_exam`;
/*!40000 ALTER TABLE `blood_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `blood_exam` ENABLE KEYS */;

--  テーブル abldb.doac の構造をダンプしています
CREATE TABLE IF NOT EXISTS `doac` (
  `doac_id` int(11) NOT NULL,
  `name` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`doac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.doac: ~0 rows (約) のデータをダンプしています
DELETE FROM `doac`;
/*!40000 ALTER TABLE `doac` DISABLE KEYS */;
/*!40000 ALTER TABLE `doac` ENABLE KEYS */;

--  テーブル abldb.ecg の構造をダンプしています
CREATE TABLE IF NOT EXISTS `ecg` (
  `ecg_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_serial_number` int(11) NOT NULL,
  `date` date NOT NULL,
  `hr` double(10,5) DEFAULT NULL,
  `pq` double(10,5) DEFAULT NULL,
  `qrs` double(10,5) DEFAULT NULL,
  `beta_blocker` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ecg_id`),
  KEY `fk_ecg_pt_idx` (`patient_serial_number`),
  CONSTRAINT `fk_ecg_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.ecg: ~0 rows (約) のデータをダンプしています
DELETE FROM `ecg`;
/*!40000 ALTER TABLE `ecg` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecg` ENABLE KEYS */;

--  テーブル abldb.first_ablation の構造をダンプしています
CREATE TABLE IF NOT EXISTS `first_ablation` (
  `first_ablation_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `internal_medicine_id` int(11) DEFAULT NULL,
  `patient_serial_number` int(11) NOT NULL,
  `threed_system` varchar(50) DEFAULT NULL,
  `abl_kind` varchar(50) DEFAULT NULL,
  `contrast` bit(1) DEFAULT NULL,
  `operation_duration` int(11) DEFAULT NULL,
  `perspective_duration` int(11) DEFAULT NULL,
  `skin_dose` int(11) DEFAULT NULL,
  `total_dose` int(11) DEFAULT NULL,
  `left_low_voltage_ratio05v` double(10,5) DEFAULT NULL,
  `left_low_voltage_ratio08v` double(10,5) DEFAULT NULL,
  `left_low_voltage_ratio10v` double(10,5) DEFAULT NULL,
  `left_angiography` bit(1) DEFAULT NULL,
  `eepvi` bit(1) DEFAULT NULL,
  `completed_eepvi` bit(1) DEFAULT NULL,
  `box_one_ring` bit(1) DEFAULT NULL,
  `box_eepvi` bit(1) DEFAULT NULL,
  `posterior_center_line` bit(1) DEFAULT NULL,
  `completed_box` bit(1) DEFAULT NULL,
  `dormant_conduction` bit(1) DEFAULT NULL,
  `af_by_atp` bit(1) DEFAULT NULL,
  `only_pvi` bit(1) DEFAULT NULL,
  `svci` bit(1) DEFAULT NULL,
  `completed_svci` bit(1) DEFAULT NULL,
  `plsvc` bit(1) DEFAULT NULL,
  `completed_plsvc` bit(1) DEFAULT NULL,
  `non_pv_foci` bit(1) DEFAULT NULL,
  `non_pv_foci_place` varchar(255) DEFAULT NULL,
  `low_voltage_abl` bit(1) DEFAULT NULL,
  `la_cfae` bit(1) DEFAULT NULL,
  `ra_cfae` bit(1) DEFAULT NULL,
  `cs_cfae` bit(1) DEFAULT NULL,
  `gp` bit(1) DEFAULT NULL,
  `chemical` bit(1) DEFAULT NULL,
  `roof_line` bit(1) DEFAULT NULL,
  `completed_roof_line` bit(1) DEFAULT NULL,
  `bottom_line` bit(1) DEFAULT NULL,
  `completed_bottom_line` bit(1) DEFAULT NULL,
  `post_mitral_line` bit(1) DEFAULT NULL,
  `ant_mitral_line` bit(1) DEFAULT NULL,
  `mitral_line_cs` bit(1) DEFAULT NULL,
  `completed_mitral_line` bit(1) DEFAULT NULL,
  `cti` bit(1) DEFAULT NULL,
  `completed_cti` bit(1) DEFAULT NULL,
  `past_cti` bit(1) DEFAULT NULL,
  `cb_pvi` bit(1) DEFAULT NULL,
  `roof_line_by_cb` bit(1) DEFAULT NULL,
  `bottom_line_by_cb` bit(1) DEFAULT NULL,
  `laser_pvi` bit(1) DEFAULT NULL,
  `hot_pvi` bit(1) DEFAULT NULL,
  `other` bit(1) DEFAULT NULL,
  `other_detail` varchar(255) DEFAULT NULL,
  `conversion_to_sr` bit(1) DEFAULT NULL,
  `conversion_to_at` bit(1) DEFAULT NULL,
  `cardioversion` bit(1) DEFAULT NULL,
  `antiarrhythmia` bit(1) DEFAULT NULL,
  `burst_pacing` bit(1) DEFAULT NULL,
  `isp` bit(1) DEFAULT NULL,
  `complications` bit(1) DEFAULT NULL,
  `death_by_ope` bit(1) DEFAULT NULL,
  `death_on` date DEFAULT NULL,
  `reason_of_death` varchar(255) DEFAULT NULL,
  `heart_swell_needs_puncture` bit(1) DEFAULT NULL,
  `heart_swell_needs_open_chest` bit(1) DEFAULT NULL,
  `heart_swell_needs_no_ope` bit(1) DEFAULT NULL,
  `left_fistula` bit(1) DEFAULT NULL,
  `esophageal_disorder` bit(1) DEFAULT NULL,
  `phrenic_disorder` bit(1) DEFAULT NULL,
  `tia` bit(1) DEFAULT NULL,
  `other_embolism` bit(1) DEFAULT NULL,
  `other_embolism_part` varchar(255) DEFAULT NULL,
  `air_embolism` bit(1) DEFAULT NULL,
  `delayed_hypotension` bit(1) DEFAULT NULL,
  `infarction_around_ope` bit(1) DEFAULT NULL,
  `stenosis_around_ope` bit(1) DEFAULT NULL,
  `endocarditis` bit(1) DEFAULT NULL,
  `sepsis` bit(1) DEFAULT NULL,
  `heart_failure` bit(1) DEFAULT NULL,
  `respirator_failure` bit(1) DEFAULT NULL,
  `pseudoaneurysm` bit(1) DEFAULT NULL,
  `arteriovenous_fistula` bit(1) DEFAULT NULL,
  `puncture_hematoma` bit(1) DEFAULT NULL,
  `retroperitoneal_hematoma` bit(1) DEFAULT NULL,
  `transfusion` bit(1) DEFAULT NULL,
  `transfusion_reason` varchar(255) DEFAULT NULL,
  `pulmonary_vein_stenosis` bit(1) DEFAULT NULL,
  `pulmonary_embolism` bit(1) DEFAULT NULL,
  `temporary_pm_by_sss` bit(1) DEFAULT NULL,
  `unexpected_sinus_failure` bit(1) DEFAULT NULL,
  `temporary_pm_by_avb` bit(1) DEFAULT NULL,
  `unexpected_atrioventricular_block` bit(1) DEFAULT NULL,
  `pneumothorax` bit(1) DEFAULT NULL,
  `hemothorax` bit(1) DEFAULT NULL,
  `sinus_dissection` bit(1) DEFAULT NULL,
  `sinus_stenosis` bit(1) DEFAULT NULL,
  `hold_damaged_valve` bit(1) DEFAULT NULL,
  `cured_damaged_valve` bit(1) DEFAULT NULL,
  `aortic_dissection` bit(1) DEFAULT NULL,
  `allergy` bit(1) DEFAULT NULL,
  `agent_allergy_detail` varchar(255) DEFAULT NULL,
  `other_medicine_allergy` bit(1) DEFAULT NULL,
  `other_medicine_name_causes_allergy` varchar(255) DEFAULT NULL,
  `other_complications` bit(1) DEFAULT NULL,
  PRIMARY KEY (`first_ablation_id`),
  KEY `fk_firstab_pt_idx` (`patient_serial_number`),
  KEY `fk_firstab_med_idx` (`internal_medicine_id`),
  CONSTRAINT `fk_firstab_med` FOREIGN KEY (`internal_medicine_id`) REFERENCES `internal_medicine` (`internal_medicine_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_firstab_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- テーブル abldb.first_ablation: ~0 rows (約) のデータをダンプしています
DELETE FROM `first_ablation`;
/*!40000 ALTER TABLE `first_ablation` DISABLE KEYS */;
INSERT INTO `first_ablation` (`first_ablation_id`, `date`, `internal_medicine_id`, `patient_serial_number`, `threed_system`, `abl_kind`, `contrast`, `operation_duration`, `perspective_duration`, `skin_dose`, `total_dose`, `left_low_voltage_ratio05v`, `left_low_voltage_ratio08v`, `left_low_voltage_ratio10v`, `left_angiography`, `eepvi`, `completed_eepvi`, `box_one_ring`, `box_eepvi`, `posterior_center_line`, `completed_box`, `dormant_conduction`, `af_by_atp`, `only_pvi`, `svci`, `completed_svci`, `plsvc`, `completed_plsvc`, `non_pv_foci`, `non_pv_foci_place`, `low_voltage_abl`, `la_cfae`, `ra_cfae`, `cs_cfae`, `gp`, `chemical`, `roof_line`, `completed_roof_line`, `bottom_line`, `completed_bottom_line`, `post_mitral_line`, `ant_mitral_line`, `mitral_line_cs`, `completed_mitral_line`, `cti`, `completed_cti`, `past_cti`, `cb_pvi`, `roof_line_by_cb`, `bottom_line_by_cb`, `laser_pvi`, `hot_pvi`, `other`, `other_detail`, `conversion_to_sr`, `conversion_to_at`, `cardioversion`, `antiarrhythmia`, `burst_pacing`, `isp`, `complications`, `death_by_ope`, `death_on`, `reason_of_death`, `heart_swell_needs_puncture`, `heart_swell_needs_open_chest`, `heart_swell_needs_no_ope`, `left_fistula`, `esophageal_disorder`, `phrenic_disorder`, `tia`, `other_embolism`, `other_embolism_part`, `air_embolism`, `delayed_hypotension`, `infarction_around_ope`, `stenosis_around_ope`, `endocarditis`, `sepsis`, `heart_failure`, `respirator_failure`, `pseudoaneurysm`, `arteriovenous_fistula`, `puncture_hematoma`, `retroperitoneal_hematoma`, `transfusion`, `transfusion_reason`, `pulmonary_vein_stenosis`, `pulmonary_embolism`, `temporary_pm_by_sss`, `unexpected_sinus_failure`, `temporary_pm_by_avb`, `unexpected_atrioventricular_block`, `pneumothorax`, `hemothorax`, `sinus_dissection`, `sinus_stenosis`, `hold_damaged_valve`, `cured_damaged_valve`, `aortic_dissection`, `allergy`, `agent_allergy_detail`, `other_medicine_allergy`, `other_medicine_name_causes_allergy`, `other_complications`) VALUES
	(1, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `first_ablation` ENABLE KEYS */;

--  テーブル abldb.following_ablation の構造をダンプしています
CREATE TABLE IF NOT EXISTS `following_ablation` (
  `following_ablation_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `patient_serial_number` int(11) NOT NULL,
  `ucg_id` int(11) DEFAULT NULL,
  `internal_medicine_id` int(11) DEFAULT NULL,
  `threed_system` varchar(50) DEFAULT NULL,
  `left_low_voltage_ratio05v` float(10,5) DEFAULT NULL,
  `left_low_voltage_ratio08v` float(10,5) DEFAULT NULL,
  `left_low_voltage_ratio10v` float(10,5) DEFAULT NULL,
  `lpv_reisolation` bit(1) DEFAULT NULL,
  `only_lspv` bit(1) DEFAULT NULL,
  `only_lipv` bit(1) DEFAULT NULL,
  `rpv_reisolation` bit(1) DEFAULT NULL,
  `only_rspv` bit(1) DEFAULT NULL,
  `only_ripv` bit(1) DEFAULT NULL,
  `re_box` bit(1) DEFAULT NULL,
  `pw_reisolation_roof` bit(1) DEFAULT NULL,
  `pw_reisolation_bottom` bit(1) DEFAULT NULL,
  `dormant_conduction` bit(1) DEFAULT NULL,
  `af_by_atp` bit(1) DEFAULT NULL,
  `svc_rec` bit(1) DEFAULT NULL,
  `svc_reisolation` bit(1) DEFAULT NULL,
  `completed_svc_reisolation` bit(1) DEFAULT NULL,
  `new_svci` bit(1) DEFAULT NULL,
  `completed_new_svci` bit(1) DEFAULT NULL,
  `plsvc_reisolation` bit(1) DEFAULT NULL,
  `completed_plsvc_reisolation` bit(1) DEFAULT NULL,
  `new_plsvc_reisolation` bit(1) DEFAULT NULL,
  `non_pv_foci` bit(1) DEFAULT NULL,
  `non_pv_foci_place` varchar(50) DEFAULT NULL,
  `low_voltage_abl` bit(1) DEFAULT NULL,
  `la_cfae` bit(1) DEFAULT NULL,
  `ra_cfae` bit(1) DEFAULT NULL,
  `cs_cfae` bit(1) DEFAULT NULL,
  `gp` bit(1) DEFAULT NULL,
  `chemical` bit(1) DEFAULT NULL,
  `roof_line_rec` bit(1) DEFAULT NULL,
  `roof_line_reablation` bit(1) DEFAULT NULL,
  `completed_roof_line_reablation` bit(1) DEFAULT NULL,
  `new_roof_line` bit(1) DEFAULT NULL,
  `completed_new_roof_line` bit(1) DEFAULT NULL,
  `bottom_line_rec` bit(1) DEFAULT NULL,
  `bottom_line_reablation` bit(1) DEFAULT NULL,
  `completed_bottom_line_reablation` bit(1) DEFAULT NULL,
  `new_bottom_line` bit(1) DEFAULT NULL,
  `completed_new_bottom_line` bit(1) DEFAULT NULL,
  `mitral_line_rec` bit(1) DEFAULT NULL,
  `mitral_line_reablation` bit(1) DEFAULT NULL,
  `mitral_line_reablation_cs` bit(1) DEFAULT NULL,
  `completed_mitral_line_reablation` bit(1) DEFAULT NULL,
  `new_post_mitral_line` bit(1) DEFAULT NULL,
  `new_post_mitral_line_cs` bit(1) DEFAULT NULL,
  `new_anterior_mitral_line` bit(1) DEFAULT NULL,
  `completed_new_anterior_mitral_line` bit(1) DEFAULT NULL,
  `completed_new_mitral_line` bit(1) DEFAULT NULL,
  `cti_rec` bit(1) DEFAULT NULL,
  `cti_reablation` bit(1) DEFAULT NULL,
  `completed_cti_reablation` bit(1) DEFAULT NULL,
  `new_cti` bit(1) DEFAULT NULL,
  `completed_new_cti` bit(1) DEFAULT NULL,
  `avn_ablation` bit(1) DEFAULT NULL,
  `other_things` varchar(255) DEFAULT NULL,
  `conversion_to_sr` bit(1) DEFAULT NULL,
  `conversion_to_at` bit(1) DEFAULT NULL,
  `conversion_execution` bit(1) DEFAULT NULL,
  `antiarrhythmic_during_ope` bit(1) DEFAULT NULL,
  `burst_pacing` bit(1) DEFAULT NULL,
  `isp` bit(1) DEFAULT NULL,
  `complications` bit(1) DEFAULT NULL,
  `complications_detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`following_ablation_id`),
  KEY `fk_followab_pt_idx` (`patient_serial_number`),
  KEY `fk_followab_ucg_idx` (`ucg_id`),
  KEY `fk_followab_med_idx` (`internal_medicine_id`),
  CONSTRAINT `fk_followab_med` FOREIGN KEY (`internal_medicine_id`) REFERENCES `internal_medicine` (`internal_medicine_id`),
  CONSTRAINT `fk_followab_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_followab_ucg` FOREIGN KEY (`ucg_id`) REFERENCES `ucg` (`ucg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- テーブル abldb.following_ablation: ~0 rows (約) のデータをダンプしています
DELETE FROM `following_ablation`;
/*!40000 ALTER TABLE `following_ablation` DISABLE KEYS */;
INSERT INTO `following_ablation` (`following_ablation_id`, `date`, `patient_serial_number`, `ucg_id`, `internal_medicine_id`, `threed_system`, `left_low_voltage_ratio05v`, `left_low_voltage_ratio08v`, `left_low_voltage_ratio10v`, `lpv_reisolation`, `only_lspv`, `only_lipv`, `rpv_reisolation`, `only_rspv`, `only_ripv`, `re_box`, `pw_reisolation_roof`, `pw_reisolation_bottom`, `dormant_conduction`, `af_by_atp`, `svc_rec`, `svc_reisolation`, `completed_svc_reisolation`, `new_svci`, `completed_new_svci`, `plsvc_reisolation`, `completed_plsvc_reisolation`, `new_plsvc_reisolation`, `non_pv_foci`, `non_pv_foci_place`, `low_voltage_abl`, `la_cfae`, `ra_cfae`, `cs_cfae`, `gp`, `chemical`, `roof_line_rec`, `roof_line_reablation`, `completed_roof_line_reablation`, `new_roof_line`, `completed_new_roof_line`, `bottom_line_rec`, `bottom_line_reablation`, `completed_bottom_line_reablation`, `new_bottom_line`, `completed_new_bottom_line`, `mitral_line_rec`, `mitral_line_reablation`, `mitral_line_reablation_cs`, `completed_mitral_line_reablation`, `new_post_mitral_line`, `new_post_mitral_line_cs`, `new_anterior_mitral_line`, `completed_new_anterior_mitral_line`, `completed_new_mitral_line`, `cti_rec`, `cti_reablation`, `completed_cti_reablation`, `new_cti`, `completed_new_cti`, `avn_ablation`, `other_things`, `conversion_to_sr`, `conversion_to_at`, `conversion_execution`, `antiarrhythmic_during_ope`, `burst_pacing`, `isp`, `complications`, `complications_detail`) VALUES
	(2, NULL, 1, 5, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `following_ablation` ENABLE KEYS */;

--  テーブル abldb.follow_up の構造をダンプしています
CREATE TABLE IF NOT EXISTS `follow_up` (
  `follow_up_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_serial_number` int(11) NOT NULL,
  `af_in_three_months` bit(1) DEFAULT NULL,
  `af_in_three_months_kind` varchar(50) DEFAULT NULL,
  `af_in_three_monhs_date` date DEFAULT NULL,
  `af_after_three_months` bit(1) DEFAULT NULL,
  `af_after_three_months_kind` varchar(50) DEFAULT NULL,
  `af_after_three_months_date` date DEFAULT NULL,
  `af_antiarrhythmic` bit(1) DEFAULT NULL,
  `af_antiarrhythmic_still_af` bit(1) DEFAULT NULL,
  `af_ninety_days_after_second` bit(1) DEFAULT NULL,
  `af_ninety_days_after_second_date` date DEFAULT NULL,
  `af_after_second_kind` varchar(50) DEFAULT NULL,
  `af_after_second_antiarrhythmic` bit(1) DEFAULT NULL,
  `af_after_second_antiarrhythmic_start` bit(1) DEFAULT NULL,
  `af_after_second_antiarrhythmic_still_af` bit(1) DEFAULT NULL,
  `af_final_status_kind` varchar(50) DEFAULT NULL,
  `oac_final_follow` bit(1) DEFAULT NULL,
  `oac_off_after_final_session` bit(1) DEFAULT NULL,
  `oac_off_after_final_session_date` date DEFAULT NULL,
  `oac_restart_after_final_session` bit(1) DEFAULT NULL,
  `oac_re_off_after_final_session_date` date DEFAULT NULL,
  `oac_restart_after_final_session_date` date DEFAULT NULL,
  `anti_arrhythmic_final_follow` bit(1) DEFAULT NULL,
  `anti_arrhythmic_after_final_session_off_date` date DEFAULT NULL,
  `anti_arrhythmic_after_final_session_start_date` date DEFAULT NULL,
  `anti_arrhythmic_after_final_session_re_off_date` date DEFAULT NULL,
  `anti_arrhythmic_after_final_session_restart_date` date DEFAULT NULL,
  `pvct` bit(1) DEFAULT NULL,
  `ct_date` date DEFAULT NULL,
  `pv_stenosis` bit(1) DEFAULT NULL,
  `heart_failure` bit(1) DEFAULT NULL,
  `heart_failoure_admission_date` date DEFAULT NULL,
  `cerebral_infarction` bit(1) DEFAULT NULL,
  `cerebral_infarction_date` date DEFAULT NULL,
  `cerebral_infarction_comment` varchar(50) DEFAULT NULL,
  `embolus` bit(1) DEFAULT NULL,
  `embolus_part` varchar(50) DEFAULT NULL,
  `embolus_date` date DEFAULT NULL,
  `bleeding` bit(1) DEFAULT NULL,
  `bleeding_date` date DEFAULT NULL,
  `bleeding_detail` varchar(50) DEFAULT NULL,
  `isth` bit(1) DEFAULT NULL,
  `head_bleed` bit(1) DEFAULT NULL,
  `head_bleed_date` date DEFAULT NULL,
  `gastro_bleed` bit(1) DEFAULT NULL,
  `gastro_bleed_date` date DEFAULT NULL,
  `death` varchar(50) DEFAULT NULL,
  `death_detail` varchar(50) DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `new_device` varchar(50) DEFAULT NULL,
  `new_device_date` date DEFAULT NULL,
  `pci` bit(1) DEFAULT NULL,
  `pci_date` date DEFAULT NULL,
  `cabg` bit(1) DEFAULT NULL,
  `cabg_date` date DEFAULT NULL,
  `heart_ope` bit(1) DEFAULT NULL,
  `heart_ope_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `primary_doctor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`follow_up_id`),
  KEY `FK_patients_followup` (`patient_serial_number`),
  CONSTRAINT `FK_patients_followup` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- テーブル abldb.follow_up: ~0 rows (約) のデータをダンプしています
DELETE FROM `follow_up`;
/*!40000 ALTER TABLE `follow_up` DISABLE KEYS */;
INSERT INTO `follow_up` (`follow_up_id`, `patient_serial_number`, `af_in_three_months`, `af_in_three_months_kind`, `af_in_three_monhs_date`, `af_after_three_months`, `af_after_three_months_kind`, `af_after_three_months_date`, `af_antiarrhythmic`, `af_antiarrhythmic_still_af`, `af_ninety_days_after_second`, `af_ninety_days_after_second_date`, `af_after_second_kind`, `af_after_second_antiarrhythmic`, `af_after_second_antiarrhythmic_start`, `af_after_second_antiarrhythmic_still_af`, `af_final_status_kind`, `oac_final_follow`, `oac_off_after_final_session`, `oac_off_after_final_session_date`, `oac_restart_after_final_session`, `oac_re_off_after_final_session_date`, `oac_restart_after_final_session_date`, `anti_arrhythmic_final_follow`, `anti_arrhythmic_after_final_session_off_date`, `anti_arrhythmic_after_final_session_start_date`, `anti_arrhythmic_after_final_session_re_off_date`, `anti_arrhythmic_after_final_session_restart_date`, `pvct`, `ct_date`, `pv_stenosis`, `heart_failure`, `heart_failoure_admission_date`, `cerebral_infarction`, `cerebral_infarction_date`, `cerebral_infarction_comment`, `embolus`, `embolus_part`, `embolus_date`, `bleeding`, `bleeding_date`, `bleeding_detail`, `isth`, `head_bleed`, `head_bleed_date`, `gastro_bleed`, `gastro_bleed_date`, `death`, `death_detail`, `death_date`, `new_device`, `new_device_date`, `pci`, `pci_date`, `cabg`, `cabg_date`, `heart_ope`, `heart_ope_date`, `last_date`, `primary_doctor`) VALUES
	(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `follow_up` ENABLE KEYS */;

--  テーブル abldb.holter の構造をダンプしています
CREATE TABLE IF NOT EXISTS `holter` (
  `holter_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_serial_number` int(11) NOT NULL,
  `date` date NOT NULL,
  `recorded_hours` int(11) DEFAULT NULL,
  `recorded_minutes` int(11) DEFAULT NULL,
  `total_pac` int(11) DEFAULT NULL,
  `pac_ratio` double(10,5) DEFAULT NULL,
  `single_pac_number` int(11) DEFAULT NULL,
  `double_pac_number` int(11) DEFAULT NULL,
  `many_pac_number` int(11) DEFAULT NULL,
  `max_pac_number` int(11) DEFAULT NULL,
  `fastest_bpm_by_many_pac` int(11) DEFAULT NULL,
  `single_pac_ratio` double(10,5) DEFAULT NULL,
  PRIMARY KEY (`holter_id`),
  KEY `fk_holter_pt_idx` (`patient_serial_number`),
  CONSTRAINT `fk_holter_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.holter: ~0 rows (約) のデータをダンプしています
DELETE FROM `holter`;
/*!40000 ALTER TABLE `holter` DISABLE KEYS */;
/*!40000 ALTER TABLE `holter` ENABLE KEYS */;

--  テーブル abldb.hospital の構造をダンプしています
CREATE TABLE IF NOT EXISTS `hospital` (
  `hospital_id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital_name` varchar(255) NOT NULL,
  PRIMARY KEY (`hospital_id`),
  UNIQUE KEY `hospital_id_UNIQUE` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- テーブル abldb.hospital: ~1 rows (約) のデータをダンプしています
DELETE FROM `hospital`;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` (`hospital_id`, `hospital_name`) VALUES
	(1, '京大病院');
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;

--  テーブル abldb.internal_medicine の構造をダンプしています
CREATE TABLE IF NOT EXISTS `internal_medicine` (
  `internal_medicine_id` int(11) NOT NULL AUTO_INCREMENT,
  `admission_wf` bit(1) DEFAULT NULL,
  `admission_doac` varchar(50) DEFAULT NULL,
  `admission_doac_amount` int(11) DEFAULT NULL,
  `admission_asa` bit(1) DEFAULT NULL,
  `admission_thienopyridine` bit(1) DEFAULT NULL,
  `admission_prasugurel` bit(1) DEFAULT NULL,
  `admission_other_antiplatelet` bit(1) DEFAULT NULL,
  `admission_beta_blocker` bit(1) DEFAULT NULL,
  `admission_verapamil` bit(1) DEFAULT NULL,
  `admission_digitalis` bit(1) DEFAULT NULL,
  `admission_aad` bit(1) DEFAULT NULL,
  `admission_ia` bit(1) DEFAULT NULL,
  `admission_ib` bit(1) DEFAULT NULL,
  `admission_ic` bit(1) DEFAULT NULL,
  `admission_amiodarone` bit(1) DEFAULT NULL,
  `admission_sotalol` bit(1) DEFAULT NULL,
  `admission_bepridil` bit(1) DEFAULT NULL,
  `admission_arb` bit(1) DEFAULT NULL,
  `admission_ace` bit(1) DEFAULT NULL,
  `admission_anti_ca` bit(1) DEFAULT NULL,
  `admission_antihypertensive_diuretic` bit(1) DEFAULT NULL,
  `admission_diuretic` bit(1) DEFAULT NULL,
  `admission_spironolactone` bit(1) DEFAULT NULL,
  `admission_statine` bit(1) DEFAULT NULL,
  `admission_dm_insulin` bit(1) DEFAULT NULL,
  `admission_sglt2` bit(1) DEFAULT NULL,
  `admission_ppi` bit(1) DEFAULT NULL,
  `admission_h2_blocker` bit(1) DEFAULT NULL,
  `admission_nsaids` bit(1) DEFAULT NULL,
  `admission_steroid` bit(1) DEFAULT NULL,
  `wf` bit(1) DEFAULT NULL,
  `doac` varchar(50) DEFAULT NULL,
  `doac_amount` int(11) DEFAULT NULL,
  `asa` bit(1) DEFAULT NULL,
  `thienopyridine` bit(1) DEFAULT NULL,
  `prasugurel` bit(1) DEFAULT NULL,
  `other_antiplatelet` bit(1) DEFAULT NULL,
  `beta_blocker` bit(1) DEFAULT NULL,
  `verapamil` bit(1) DEFAULT NULL,
  `digitalis` bit(1) DEFAULT NULL,
  `aad` bit(1) DEFAULT NULL,
  `ia` bit(1) DEFAULT NULL,
  `ib` bit(1) DEFAULT NULL,
  `ic` bit(1) DEFAULT NULL,
  `amiodarone` bit(1) DEFAULT NULL,
  `sotalol` bit(1) DEFAULT NULL,
  `bepridil` bit(1) DEFAULT NULL,
  `arb` bit(1) DEFAULT NULL,
  `ace` bit(1) DEFAULT NULL,
  `anti_ca` bit(1) DEFAULT NULL,
  `antihypertensive_diuretic` bit(1) DEFAULT NULL,
  `diuretic` bit(1) DEFAULT NULL,
  `spironolactone` bit(1) DEFAULT NULL,
  `statine` bit(1) DEFAULT NULL,
  `dm_insulin` bit(1) DEFAULT NULL,
  `sglt2` bit(1) DEFAULT NULL,
  `ppi` bit(1) DEFAULT NULL,
  `h2_blocker` bit(1) DEFAULT NULL,
  `nsaids` bit(1) DEFAULT NULL,
  `steroid` bit(1) DEFAULT NULL,
  PRIMARY KEY (`internal_medicine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- テーブル abldb.internal_medicine: ~0 rows (約) のデータをダンプしています
DELETE FROM `internal_medicine`;
/*!40000 ALTER TABLE `internal_medicine` DISABLE KEYS */;
INSERT INTO `internal_medicine` (`internal_medicine_id`, `admission_wf`, `admission_doac`, `admission_doac_amount`, `admission_asa`, `admission_thienopyridine`, `admission_prasugurel`, `admission_other_antiplatelet`, `admission_beta_blocker`, `admission_verapamil`, `admission_digitalis`, `admission_aad`, `admission_ia`, `admission_ib`, `admission_ic`, `admission_amiodarone`, `admission_sotalol`, `admission_bepridil`, `admission_arb`, `admission_ace`, `admission_anti_ca`, `admission_antihypertensive_diuretic`, `admission_diuretic`, `admission_spironolactone`, `admission_statine`, `admission_dm_insulin`, `admission_sglt2`, `admission_ppi`, `admission_h2_blocker`, `admission_nsaids`, `admission_steroid`, `wf`, `doac`, `doac_amount`, `asa`, `thienopyridine`, `prasugurel`, `other_antiplatelet`, `beta_blocker`, `verapamil`, `digitalis`, `aad`, `ia`, `ib`, `ic`, `amiodarone`, `sotalol`, `bepridil`, `arb`, `ace`, `anti_ca`, `antihypertensive_diuretic`, `diuretic`, `spironolactone`, `statine`, `dm_insulin`, `sglt2`, `ppi`, `h2_blocker`, `nsaids`, `steroid`) VALUES
	(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `internal_medicine` ENABLE KEYS */;

--  テーブル abldb.logins の構造をダンプしています
CREATE TABLE IF NOT EXISTS `logins` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `token` varchar(64) NOT NULL DEFAULT '0',
  `is_logged_out` bit(1) NOT NULL DEFAULT b'0',
  `logged_in_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`login_id`),
  KEY `FK_logins_users` (`user_id`),
  CONSTRAINT `FK_logins_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- テーブル abldb.logins: ~5 rows (約) のデータをダンプしています
DELETE FROM `logins`;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` (`login_id`, `user_id`, `token`, `is_logged_out`, `logged_in_at`) VALUES
	(1, 'test', 'tmwc7nPx5DKoUGj36wwn3wUb5AYBTR1pZ54A1VQMlVklGIlHywU1aKXjfTVgEtpV', b'0', '2021-05-12 14:48:59'),
	(2, 'test', 'DAbApx3z41idAFcCwoeasyx9ivhUmjjn2NXw4L13wzap1dlvqRj16iyUFWjuL6qB', b'0', '2021-05-20 12:05:38'),
	(3, 'test', 'P4DgQOWf88Ibdla27aC7XDQgODF5vEhzqKlEKfJueY004azSXRpvh5CJMBtbxjhk', b'0', '2021-05-20 12:05:39'),
	(4, 'test', 'XfwCI2ZCwyJtY2bXo0oiAHCP2P9xmZF4q2uDTHLHlwSnGlQY7awAcCXYHKOmU48A', b'0', '2021-05-20 12:05:44'),
	(5, 'test', 'DE79mjNmJQLfz8ltNeUBGB1xQbwOwzWit9Zi5mZnZkGMzzuBgYQ3ufJHmSa1TfVL', b'0', '2021-05-20 12:06:18'),
	(6, 'test', '1HvSUgcNpJ7thbRSi2bEyWltNonRUSDBV1bBKdtPMIGTLk3vkntLKBYdmScgMuIg', b'0', '2021-05-20 14:46:09');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;

--  テーブル abldb.patients の構造をダンプしています
CREATE TABLE IF NOT EXISTS `patients` (
  `patient_serial_number` int(11) NOT NULL AUTO_INCREMENT,
  `registered_by` varchar(50) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `patient_number` int(11) NOT NULL,
  `ucg_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `name_kana` varchar(255) DEFAULT NULL,
  `sex` bit(1) DEFAULT NULL,
  `weight` double(4,1) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `height` double(4,1) DEFAULT NULL,
  `af_kind` varchar(50) DEFAULT NULL,
  `rfca_cb` varchar(50) DEFAULT NULL,
  `ehra_score` varchar(10) DEFAULT NULL,
  `has_symptom` bit(1) DEFAULT NULL,
  `frality_scale` int(11) DEFAULT NULL,
  `rhythm` varchar(50) DEFAULT NULL,
  `heart_rate` int(10) unsigned DEFAULT NULL,
  `pr_gap` int(11) DEFAULT NULL,
  `qrs` int(11) DEFAULT NULL,
  `sss` tinyint(3) unsigned DEFAULT NULL,
  `av_block` tinyint(3) unsigned DEFAULT NULL,
  `pm` bit(1) DEFAULT NULL,
  `icd` bit(1) DEFAULT NULL,
  `crtp` bit(1) DEFAULT NULL,
  `crtd` bit(1) DEFAULT NULL,
  `af_onset_on` date DEFAULT NULL,
  `af_immobilized_on` date DEFAULT NULL,
  `maze` bit(1) DEFAULT NULL,
  `open_heart` bit(1) DEFAULT NULL,
  `open_heart_detail` varchar(255) DEFAULT NULL,
  `ht` bit(1) DEFAULT NULL,
  `dm` bit(1) DEFAULT NULL,
  `dyslip` bit(1) DEFAULT NULL,
  `hu` bit(1) DEFAULT NULL,
  `smoking_history` tinyint(3) unsigned DEFAULT NULL,
  `dialysys` bit(1) DEFAULT NULL,
  `thrombosis` bit(1) DEFAULT NULL,
  `ischemic_stroke` bit(1) DEFAULT NULL,
  `tia` bit(1) DEFAULT NULL,
  `hemorrhagic_stroke` bit(1) DEFAULT NULL,
  `isth_bleeding` bit(1) DEFAULT NULL,
  `problematic_bleeding` bit(1) DEFAULT NULL,
  `chf_nyha` bit(1) DEFAULT NULL,
  `blood_vessel_disease` bit(1) DEFAULT NULL,
  `sas` bit(1) DEFAULT NULL,
  `omi` bit(1) DEFAULT NULL,
  `ihd` bit(1) DEFAULT NULL,
  `hcm` bit(1) DEFAULT NULL,
  `dcm` bit(1) DEFAULT NULL,
  `other_cardiomiopathy` bit(1) DEFAULT NULL,
  `mr` bit(1) DEFAULT NULL,
  `ms` bit(1) DEFAULT NULL,
  `valvular_disease` bit(1) DEFAULT NULL,
  `hyperthyroidism` bit(1) DEFAULT NULL,
  `hypothyreosis` bit(1) DEFAULT NULL,
  `asd` bit(1) DEFAULT NULL,
  `other_congenital` bit(1) DEFAULT NULL,
  `ctd` bit(1) DEFAULT NULL,
  `malignancy` bit(1) DEFAULT NULL,
  `hba1c` double(10,5) DEFAULT NULL,
  `cre` double(10,5) DEFAULT NULL,
  `egfr` double(10,5) DEFAULT NULL,
  `ccr` double(10,5) DEFAULT NULL,
  `nt_pro_bnp` double(10,5) DEFAULT NULL,
  `bnp` double(10,5) DEFAULT NULL,
  `aptt` double(10,5) DEFAULT NULL,
  `pt_inr` double(10,5) DEFAULT NULL,
  `d_dimer` double(10,5) DEFAULT NULL,
  `hb` double(10,5) DEFAULT NULL,
  `hmt` double(10,5) DEFAULT NULL,
  `tsh` double(10,5) DEFAULT NULL,
  `ft4` double(10,5) DEFAULT NULL,
  `ast` int(11) DEFAULT NULL,
  `alt` int(11) DEFAULT NULL,
  `tbil` double(10,5) DEFAULT NULL,
  PRIMARY KEY (`patient_serial_number`),
  UNIQUE KEY `hospital_id_patient_number` (`hospital_id`,`patient_number`),
  KEY `pt_hospital_id_idx` (`hospital_id`),
  KEY `fk_pt_ucg_idx` (`ucg_id`),
  CONSTRAINT `fk_pt_ucg` FOREIGN KEY (`ucg_id`) REFERENCES `ucg` (`ucg_id`),
  CONSTRAINT `pt_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- テーブル abldb.patients: ~0 rows (約) のデータをダンプしています
DELETE FROM `patients`;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` (`patient_serial_number`, `registered_by`, `hospital_id`, `patient_number`, `ucg_id`, `name`, `name_kana`, `sex`, `weight`, `birthday`, `height`, `af_kind`, `rfca_cb`, `ehra_score`, `has_symptom`, `frality_scale`, `rhythm`, `heart_rate`, `pr_gap`, `qrs`, `sss`, `av_block`, `pm`, `icd`, `crtp`, `crtd`, `af_onset_on`, `af_immobilized_on`, `maze`, `open_heart`, `open_heart_detail`, `ht`, `dm`, `dyslip`, `hu`, `smoking_history`, `dialysys`, `thrombosis`, `ischemic_stroke`, `tia`, `hemorrhagic_stroke`, `isth_bleeding`, `problematic_bleeding`, `chf_nyha`, `blood_vessel_disease`, `sas`, `omi`, `ihd`, `hcm`, `dcm`, `other_cardiomiopathy`, `mr`, `ms`, `valvular_disease`, `hyperthyroidism`, `hypothyreosis`, `asd`, `other_congenital`, `ctd`, `malignancy`, `hba1c`, `cre`, `egfr`, `ccr`, `nt_pro_bnp`, `bnp`, `aptt`, `pt_inr`, `d_dimer`, `hb`, `hmt`, `tsh`, `ft4`, `ast`, `alt`, `tbil`) VALUES
	(1, 'test', 1, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.40000, 0.06000, 0.70000, 1.20000, 1.40000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'test', 1, 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'test', 1, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;

--  ビュー abldb.patient_list の構造をダンプしています
-- VIEW 依存エラーを克服するために、一時テーブルを作成
CREATE TABLE `patient_list` (
	`patient_serial_number` INT(11) NOT NULL,
	`hospital_id` INT(11) NOT NULL,
	`patient_number` INT(11) NOT NULL,
	`first_ablation_id` INT(11) NULL,
	`internal_medicine_id` INT(11) NULL,
	`follow_up_id` INT(11) NULL
) ENGINE=MyISAM;

--  テーブル abldb.recurrence の構造をダンプしています
CREATE TABLE IF NOT EXISTS `recurrence` (
  `recurrence_id` int(11) NOT NULL AUTO_INCREMENT,
  `af_at_after_antiarrhythmia` bit(1) DEFAULT NULL,
  `patient_serial_number` int(11) DEFAULT NULL,
  `recurrence_date` date DEFAULT NULL,
  `paf` bit(1) DEFAULT NULL,
  `peaf` bit(1) DEFAULT NULL,
  `pat` bit(1) DEFAULT NULL,
  `persistent_at` bit(1) DEFAULT NULL,
  `antiarrhythmia_on_recurrence` bit(1) DEFAULT NULL,
  `antiarrhythmia_by_recurrence` bit(1) DEFAULT NULL,
  PRIMARY KEY (`recurrence_id`),
  KEY `fk_recurrence_pt_idx` (`patient_serial_number`),
  CONSTRAINT `fk_recurrence_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.recurrence: ~0 rows (約) のデータをダンプしています
DELETE FROM `recurrence`;
/*!40000 ALTER TABLE `recurrence` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurrence` ENABLE KEYS */;

--  テーブル abldb.ucg の構造をダンプしています
CREATE TABLE IF NOT EXISTS `ucg` (
  `ucg_id` int(11) NOT NULL AUTO_INCREMENT,
  `lvef_teichholz` float(10,5) DEFAULT NULL,
  `lvef_simpson` float(10,5) DEFAULT NULL,
  `lvdd` float(10,5) DEFAULT NULL,
  `lvds` float(10,5) DEFAULT NULL,
  `lad` float(10,5) DEFAULT NULL,
  `la_diameter_vertical` float(10,5) DEFAULT NULL,
  `la_diameter_horizontal` float(10,5) DEFAULT NULL,
  `mr4grades` tinyint(3) unsigned DEFAULT NULL,
  `mr3grades` tinyint(3) unsigned DEFAULT NULL,
  `e_e` float(10,5) DEFAULT NULL,
  `e_wave` float(10,5) DEFAULT NULL,
  `a_wave` float(10,5) DEFAULT NULL,
  `dct` float(10,5) DEFAULT NULL,
  `ar4grades` tinyint(3) unsigned DEFAULT NULL,
  `ar3grades` tinyint(3) unsigned DEFAULT NULL,
  `tr4grades` tinyint(3) unsigned DEFAULT NULL,
  `tr3grades` tinyint(3) unsigned DEFAULT NULL,
  `tr_pg` int(11) DEFAULT NULL,
  `ms` bit(1) DEFAULT NULL,
  `as` bit(1) DEFAULT NULL,
  `laa_flow` float(10,5) DEFAULT NULL,
  `sec4grades` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ucg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- テーブル abldb.ucg: ~0 rows (約) のデータをダンプしています
DELETE FROM `ucg`;
/*!40000 ALTER TABLE `ucg` DISABLE KEYS */;
INSERT INTO `ucg` (`ucg_id`, `lvef_teichholz`, `lvef_simpson`, `lvdd`, `lvds`, `lad`, `la_diameter_vertical`, `la_diameter_horizontal`, `mr4grades`, `mr3grades`, `e_e`, `e_wave`, `a_wave`, `dct`, `ar4grades`, `ar3grades`, `tr4grades`, `tr3grades`, `tr_pg`, `ms`, `as`, `laa_flow`, `sec4grades`) VALUES
	(1, 0.50000, 0.90000, 1.00000, 1.30000, 0.80000, NULL, NULL, NULL, NULL, 0.80000, 0.08000, 0.24000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `ucg` ENABLE KEYS */;

--  テーブル abldb.users の構造をダンプしています
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` varchar(50) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  `password_hash` binary(64) DEFAULT NULL,
  `salt` char(64) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK1_users_hospital` (`hospital_id`),
  CONSTRAINT `FK1_users_hospital` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- テーブル abldb.users: ~0 rows (約) のデータをダンプしています
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `hospital_id`, `password_hash`, `salt`) VALUES
	('test', 1, _binary 0x65663230343330343361323166393961616536663034353735363465376165333163356336626236396431656231363131396530383766626338303030626435, 'BSMhA9DX3EMKdQxbkp74cg4uwUPnkLCUZgteUs8WUkfkSSjHicji53ShM7SjB3SG');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

--  ビュー abldb.patient_list の構造をダンプしています
-- 一時テーブルを削除して、最終的な VIEW 構造を作成
DROP TABLE IF EXISTS `patient_list`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `patient_list` AS SELECT `patients`.`patient_serial_number`,
	`patients`.`hospital_id`,
	`patients`.`patient_number`,
	`first_ablation`.`first_ablation_id`,
	`first_ablation`.`internal_medicine_id`, 
	`follow_up`.`follow_up_id`
FROM `patients`
LEFT JOIN `first_ablation`
	ON `patients`.`patient_serial_number` = `first_ablation`.`patient_serial_number`
LEFT JOIN `follow_up`
	ON `patients`.`patient_serial_number` = `follow_up`.`patient_serial_number` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
