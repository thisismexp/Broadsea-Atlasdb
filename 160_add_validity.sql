create table ETL_LOCK
(
    semaphore SERIAL NOT NULL,
    hostname varchar(255),
    username varchar(255),
    lock_datetime TIMESTAMP NOT NULL
);
ALTER TABLE ETL_LOCK ADD CONSTRAINT xpk_ETL_LOCK PRIMARY KEY (semaphore);


create table VALIDITY
(
    validity_id SERIAL NOT NULL,
	DATA_SRC       varchar(512),
    DATA_SRC_HASH  bytea,
    VALIDITY_START TIMESTAMP not null,
    VALIDITY_END   TIMESTAMP not null,
    DESCRIPTOR_ID  varchar(512) not null
);
ALTER TABLE VALIDITY ADD CONSTRAINT VALIDITY_HASH_VEND_DESCID_UNIQ unique (DATA_SRC_HASH, VALIDITY_END, DESCRIPTOR_ID);
ALTER TABLE VALIDITY ADD CONSTRAINT xpk_VALIDITY PRIMARY KEY (validity_id);


ALTER TABLE OBSERVATION_PERIOD ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT FK_OBSERVATION_PERIOD_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE VISIT_OCCURRENCE ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT FK_VISIT_OCCURRENCE_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);
ALTER TABLE VISIT_OCCURRENCE ADD COLUMN IF NOT EXISTS currently_valid_id integer NULL;
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT FK_VISIT_OCCURRENCE_CURRENTLY_VALID_ID FOREIGN KEY (currently_valid_id) references VISIT_OCCURRENCE(VISIT_OCCURRENCE_ID);

ALTER TABLE VISIT_DETAIL ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT FK_VISIT_DETAIL_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);
ALTER TABLE VISIT_DETAIL ADD COLUMN IF NOT EXISTS currently_valid_id integer NULL;
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT FK_VISIT_DETAIL_CURRENTLY_VALID_ID FOREIGN KEY (currently_valid_id) references VISIT_DETAIL(VISIT_DETAIL_ID);

ALTER TABLE CONDITION_OCCURRENCE ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT FK_CONDITION_OCCURRENCE_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE DRUG_EXPOSURE ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT FK_DRUG_EXPOSURE_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE PROCEDURE_OCCURRENCE ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT FK_PROCEDURE_OCCURRENCE_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE DEVICE_EXPOSURE ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT FK_DEVICE_EXPOSURE_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE MEASUREMENT ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE MEASUREMENT ADD CONSTRAINT FK_MEASUREMENT_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE OBSERVATION ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE OBSERVATION ADD CONSTRAINT FK_OBSERVATION_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE DEATH ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE DEATH ADD CONSTRAINT FK_DEATH_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);

ALTER TABLE SPECIMEN ADD COLUMN IF NOT EXISTS validity_id integer NULL;
ALTER TABLE SPECIMEN ADD CONSTRAINT FK_SPECIMEN_VALIDITY_ID FOREIGN KEY (validity_id) references validity(validity_id);
