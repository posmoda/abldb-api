-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for abldb
DROP DATABASE IF EXISTS `abldb`;
CREATE DATABASE IF NOT EXISTS `abldb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `abldb`;

-- Dumping structure for table abldb.blood_exam
DROP TABLE IF EXISTS `blood_exam`;
CREATE TABLE IF NOT EXISTS `blood_exam` (
  `patient_serial_number` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `cre` float(10,5) DEFAULT NULL,
  `bnp` float(10,5) DEFAULT NULL,
  PRIMARY KEY (`patient_serial_number`),
  CONSTRAINT `fk_blood_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.doac
DROP TABLE IF EXISTS `doac`;
CREATE TABLE IF NOT EXISTS `doac` (
  `doac_id` int(11) NOT NULL,
  `name` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`doac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.ecg
DROP TABLE IF EXISTS `ecg`;
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

-- Data exporting was unselected.

-- Dumping structure for table abldb.first_ablation
DROP TABLE IF EXISTS `first_ablation`;
CREATE TABLE IF NOT EXISTS `first_ablation` (
  `first_ablation_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `internal_medicine_id` int(11) DEFAULT NULL,
  `patient_serial_number` int(11) NOT NULL,
  `threed_system` varchar(50) DEFAULT NULL,
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
  `contrast_agent_allergy` bit(1) DEFAULT NULL,
  `agent_allergy_detail` varchar(255) DEFAULT NULL,
  `other_medicine_allergy` bit(1) DEFAULT NULL,
  `other_medicine_name_causes_allergy` varchar(255) DEFAULT NULL,
  `other_complications` bit(1) DEFAULT NULL,
  PRIMARY KEY (`first_ablation_id`),
  KEY `fk_firstab_pt_idx` (`patient_serial_number`),
  KEY `fk_firstab_med_idx` (`internal_medicine_id`),
  CONSTRAINT `fk_firstab_med` FOREIGN KEY (`internal_medicine_id`) REFERENCES `internal_medicine` (`internal_medicine_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_firstab_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.following_ablation
DROP TABLE IF EXISTS `following_ablation`;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.follow_up
DROP TABLE IF EXISTS `follow_up`;
CREATE TABLE IF NOT EXISTS `follow_up` (
  `follow_up_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_serial_number` int(11) NOT NULL,
  `date` date NOT NULL,
  `ucg_id` int(11) DEFAULT NULL,
  `recurrence_id` int(11) DEFAULT NULL,
  `oac` bit(1) DEFAULT NULL,
  `stopped_oac` bit(1) DEFAULT NULL,
  `stopped_oac_date` date DEFAULT NULL,
  `restarted_oac` bit(1) DEFAULT NULL,
  `restarted_oac_date` date DEFAULT NULL,
  `antiarrhythmia` bit(1) DEFAULT NULL,
  `stopped_antiarrhythmia` bit(1) DEFAULT NULL,
  `stopped_antiarrhythmia_date` date DEFAULT NULL,
  `restarted_antiarrhythmia` bit(1) DEFAULT NULL,
  `restarted_antiarrhythmia_date` date DEFAULT NULL,
  `follow_up_ct_date` date DEFAULT NULL,
  `pv_stenosis` bit(1) DEFAULT NULL,
  `death_reason` varchar(50) DEFAULT NULL,
  `death_reason_detail` varchar(255) DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `hospital_date_by_heart_failure` date DEFAULT NULL,
  `tia_upset_date` date DEFAULT NULL,
  `death_by_tia` bit(1) DEFAULT NULL,
  `kind_of_tia` varchar(45) DEFAULT NULL,
  `rankin_scale` int(11) DEFAULT NULL,
  `oac_on_tia` int(11) DEFAULT NULL,
  `apt_on_tia` bit(1) DEFAULT NULL,
  `pt_inr_on_tia` double(10,5) DEFAULT NULL,
  `aptt_on_tia` double(10,5) DEFAULT NULL,
  `oac_after_tia` bit(1) DEFAULT NULL,
  `tia_comment` varchar(255) DEFAULT NULL,
  `systemic_embolus` bit(1) DEFAULT NULL,
  `embolus_part` varchar(50) DEFAULT NULL,
  `embolus_upset_date` date DEFAULT NULL,
  `death_by_embolus` bit(1) DEFAULT NULL,
  `oac_on_embolus` int(11) DEFAULT NULL,
  `apt_on_embolus` bit(1) DEFAULT NULL,
  `pt_inr_on_embolus` double(10,5) DEFAULT NULL,
  `aptt_on_embolus` double(10,5) DEFAULT NULL,
  `oac_after_embolus` bit(1) DEFAULT NULL,
  `isth_bleeding` bit(1) DEFAULT NULL,
  `progrematic_breeding` bit(1) DEFAULT NULL,
  `head_bleeding` bit(1) DEFAULT NULL,
  `head_bleeding_date` date DEFAULT NULL,
  `kumomaku_bleeding` bit(1) DEFAULT NULL,
  `acute_subdural_hematoma` bit(1) DEFAULT NULL,
  `chronic_subdural_hematoma` bit(1) DEFAULT NULL,
  `other_head_bleeding` bit(1) DEFAULT NULL,
  `ope_for_head_bleeding` bit(1) DEFAULT NULL,
  `transfusion_for_head_bleeding` bit(1) DEFAULT NULL,
  `death_by_head_bleeding` bit(1) DEFAULT NULL,
  `sequelae_by_head_bleeding` int(11) DEFAULT NULL,
  `oac_on_head_bleeding` int(11) DEFAULT NULL,
  `apt_on_head_bleeding` bit(1) DEFAULT NULL,
  `pt_inr_on_head_bleeding` double(10,5) DEFAULT NULL,
  `aptt_on_head_bleeding` double(10,5) DEFAULT NULL,
  `oac_after_head_bleeding` bit(1) DEFAULT NULL,
  `gastro_bleeding` bit(1) DEFAULT NULL,
  `gastro_bleeding_date` date DEFAULT NULL,
  `gastro_bleeding_low_hb` bit(1) DEFAULT NULL,
  `ope_for_gastro_bleeding` bit(1) DEFAULT NULL,
  `transfusion_for_gastro_bleeding` bit(1) DEFAULT NULL,
  `oac_on_gastro_bleeding` int(11) DEFAULT NULL,
  `apt_on_gastro_bleeding` bit(1) DEFAULT NULL,
  `pt_inr_on_gastro_bleeding` double(10,5) DEFAULT NULL,
  `aptt_on_gastro_bleeding` double(10,5) DEFAULT NULL,
  `oac_after_gastro_bleeding` bit(1) DEFAULT NULL,
  `other_bleeding` bit(1) DEFAULT NULL,
  `other_bleeding_part` varchar(45) DEFAULT NULL,
  `other_bleeding_date` date DEFAULT NULL,
  `other_bleeding_low_hb` double(10,5) DEFAULT NULL,
  `ope_for_other_bleeding` bit(1) DEFAULT NULL,
  `transfusion_for_other_bleeding` bit(1) DEFAULT NULL,
  `death_by_other_bleeding` bit(1) DEFAULT NULL,
  `oac_on_other_bleeding` int(11) DEFAULT NULL,
  `apt_on_other_bleeding` bit(1) DEFAULT NULL,
  `pt_int_on_other_bleeding` double(10,5) DEFAULT NULL,
  `aptt_on_other_bleeding` double(10,5) DEFAULT NULL,
  `oac_after_other_bleeding` bit(1) DEFAULT NULL,
  `device_implantation` bit(1) DEFAULT NULL,
  `device_date` date DEFAULT NULL,
  `pm` bit(1) DEFAULT NULL,
  `icd` bit(1) DEFAULT NULL,
  `crtp` bit(1) DEFAULT NULL,
  `crtd` bit(1) DEFAULT NULL,
  `loop_recorder` bit(1) DEFAULT NULL,
  `sss` bit(1) DEFAULT NULL,
  `avb` bit(1) DEFAULT NULL,
  `avn` bit(1) DEFAULT NULL,
  `hypocardiac` bit(1) DEFAULT NULL,
  `vt_vf` bit(1) DEFAULT NULL,
  `ami` bit(1) DEFAULT NULL,
  `ami_date` date DEFAULT NULL,
  `death_by_ami` bit(1) DEFAULT NULL,
  `oac_on_ami` int(11) DEFAULT NULL,
  `apt_on_ami` bit(1) DEFAULT NULL,
  `pci` bit(1) DEFAULT NULL,
  `pci_date` date DEFAULT NULL,
  `pci_cabg` bit(1) DEFAULT NULL,
  `pci_cabg_date` date DEFAULT NULL,
  `other_ope_on_heart` bit(1) DEFAULT NULL,
  `other_ope_on_heart_date` date DEFAULT NULL,
  `hospitalize_for_heart` bit(1) DEFAULT NULL,
  `hospitalize_for_heart_date` date DEFAULT NULL,
  `end_of_consultation` bit(1) DEFAULT NULL,
  `home_doctor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`follow_up_id`),
  KEY `fk_followup_pt_idx` (`patient_serial_number`),
  KEY `fk_followup_ucg_idx` (`ucg_id`),
  KEY `fk_followup_recurrence_idx` (`recurrence_id`),
  CONSTRAINT `fk_followup_pt` FOREIGN KEY (`patient_serial_number`) REFERENCES `patients` (`patient_serial_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_followup_recurrence` FOREIGN KEY (`recurrence_id`) REFERENCES `recurrence` (`recurrence_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_followup_ucg` FOREIGN KEY (`ucg_id`) REFERENCES `ucg` (`ucg_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.holter
DROP TABLE IF EXISTS `holter`;
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

-- Data exporting was unselected.

-- Dumping structure for table abldb.hospital
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE IF NOT EXISTS `hospital` (
  `hospital_id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital_name` varchar(255) NOT NULL,
  PRIMARY KEY (`hospital_id`),
  UNIQUE KEY `hospital_id_UNIQUE` (`hospital_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.internal_medicine
DROP TABLE IF EXISTS `internal_medicine`;
CREATE TABLE IF NOT EXISTS `internal_medicine` (
  `internal_medicine_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `steroid` bit(1) DEFAULT NULL,
  PRIMARY KEY (`internal_medicine_id`),
  KEY `fk_medicine_doac_idx` (`doac`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table abldb.patients
DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `patient_serial_number` int(11) NOT NULL AUTO_INCREMENT,
  `registered_by` int(11) NOT NULL DEFAULT 0,
  `hospital_id` int(11) DEFAULT NULL,
  `ucg_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `name_kana` varchar(255) DEFAULT NULL,
  `sex` bit(1) DEFAULT b'0',
  `weight` double(4,1) unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `height` double(4,1) unsigned DEFAULT NULL,
  `af_kind` varchar(50) DEFAULT '0',
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
  `tsh` double(10,5) DEFAULT NULL,
  `ft4` double(10,5) DEFAULT NULL,
  PRIMARY KEY (`patient_serial_number`),
  KEY `pt_hospital_id_idx` (`hospital_id`),
  KEY `fk_pt_ucg_idx` (`ucg_id`),
  CONSTRAINT `fk_pt_ucg` FOREIGN KEY (`ucg_id`) REFERENCES `ucg` (`ucg_id`),
  CONSTRAINT `pt_hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for view abldb.patient_list
DROP VIEW IF EXISTS `patient_list`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `patient_list` (
	`patient_serial_number` INT(11) NOT NULL,
	`first_ablation_id` INT(11) NULL,
	`internal_medicine_id` INT(11) NULL
) ENGINE=MyISAM;

-- Dumping structure for table abldb.recurrence
DROP TABLE IF EXISTS `recurrence`;
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

-- Data exporting was unselected.

-- Dumping structure for table abldb.ucg
DROP TABLE IF EXISTS `ucg`;
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
  `ms3grades` tinyint(3) unsigned DEFAULT NULL,
  `as3grades` tinyint(3) unsigned DEFAULT NULL,
  `laa_flow` float(10,5) DEFAULT NULL,
  `sec4grades` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ucg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for view abldb.patient_list
DROP VIEW IF EXISTS `patient_list`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `patient_list`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `patient_list` AS SELECT `patients`.`patient_serial_number`, `first_ablation`.`first_ablation_id`, `first_ablation`.`internal_medicine_id`
FROM `patients`
LEFT JOIN `first_ablation`
	ON `patients`.`patient_serial_number` = `first_ablation`.`patient_serial_number` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
