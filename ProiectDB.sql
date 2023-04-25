-- Crearea tabelelor si a constrangerilor

CREATE TABLE GARI(cod_SIRUES varchar2(5) CONSTRAINT gari_pk PRIMARY KEY,
nume varchar2(60) NOT NULL,
adresa varchar2(75) NOT NULL,
telefon varchar2(10) NOT NULL,
cod_postal_oras varchar2(6) NOT NULL, CONSTRAINT gari_orase_fk FOREIGN KEY(cod_postal_oras) references ORASE(cod_postal)
);


CREATE TABLE REGIUNI(id_regiune varchar2(4) CONSTRAINT regiuni_pk PRIMARY KEY,
nume varchar2(20) NOT NULL,
numar_gari number(3));

CREATE TABLE ORASE(cod_postal varchar2(6) CONSTRAINT orase_pk PRIMARY KEY,
nume varchar2(20) NOT NULL,
id_regiune varchar2(4) NOT NULL, CONSTRAINT orase_regiuni_fk FOREIGN KEY(id_regiune) references REGIUNI(id_regiune)
);


CREATE TABLE CONDUCTORI(
id_conductor number(4) CONSTRAINT conductori_pk PRIMARY KEY,
cod_gara varchar2(5) NOT NULL, CONSTRAINT conductori_gari_fk FOREIGN KEY(cod_gara) REFERENCES GARI(cod_SIRUES),
nume varchar2(40) NOT NULL,
prenume varchar2(40) NOT NULL,
telefon varchar2(10) NOT NULL,
data_angajarii date DEFAULT sysdate NOT NULL,
salariu number(6) NOT NULL
);


CREATE TABLE CONTROLORI(
id_controlor number(4) CONSTRAINT controlori_pk PRIMARY KEY,
cod_gara varchar2(5) NOT NULL, CONSTRAINT controlorii_gari_fk FOREIGN KEY(cod_gara) REFERENCES GARI(cod_SIRUES),
nume varchar2(40) NOT NULL,
prenume varchar2(40) NOT NULL,
telefon varchar2(10) NOT NULL,
data_angajarii date DEFAULT sysdate NOT NULL,
salariu number(6) NOT NULL
);



CREATE TABLE COMPANII(
id_companie number(3) CONSTRAINT companii_pk PRIMARY KEY,
nume varchar2(40) NOT NULL
);


CREATE TABLE TRENURI(
id_tren number(4) CONSTRAINT trenuri_pk PRIMARY KEY,
id_companie number(3) NOT NULL, CONSTRAINT trenuri_companii_fk FOREIGN KEY(id_companie) REFERENCES COMPANII(id_companie),
numar_locuri number(3),
numar_vagoane number(2)
);


CREATE TABLE TRASEE(
id_traseu number(6) CONSTRAINT trasee_pk PRIMARY KEY,
cod_gara_plecare varchar2(5) NOT NULL, CONSTRAINT trasee_gari_fk1 FOREIGN KEY(cod_gara_plecare) REFERENCES GARI(cod_SIRUES),
cod_gara_sosire varchar2(5) NOT NULL, CONSTRAINT trasee_gari_fk2 FOREIGN KEY(cod_gara_sosire) REFERENCES GARI(cod_SIRUES),
id_conductor_principal number(4) NOT NULL, CONSTRAINT trasee_conductori_fk1 FOREIGN KEY(id_conductor_principal) REFERENCES CONDUCTORI(id_conductor),
id_conductor_secundar number(4) NOT NULL, CONSTRAINT trasee_conductori_fk2 FOREIGN KEY(id_conductor_secundar) REFERENCES CONDUCTORI(id_conductor),
id_tren number(4) NOT NULL, CONSTRAINT trasee_trenuri_fk FOREIGN KEY(id_tren) REFERENCES TRENURI(id_tren),
data_plecare date NOT NULL,
data_sosire date NOT NULL
);


CREATE TABLE CLASE(
id_clasa number(2) CONSTRAINT clase_pk PRIMARY KEY,
nume varchar2(25) NOT NULL,
pret_aditional number(5),
facilitati varchar2(75)
);

CREATE TABLE TRENURI_AU_CLASE(
id_tren number(4) NOT NULL, CONSTRAINT trenuri_au_clase_trenuri_fk FOREIGN KEY(id_tren) REFERENCES TRENURI(id_tren),
id_clasa number(2) NOT NULL, CONSTRAINT trenuri_au_clase_clase_fk FOREIGN KEY(id_clasa) REFERENCES CLASE(id_clasa),
CONSTRAINT trenuri_au_clase_pk PRIMARY KEY(id_tren, id_clasa)
);

CREATE TABLE VERIFICA_BILET(
id_controlor number(4), CONSTRAINT verifica_bilete_controlor_fk FOREIGN KEY(id_controlor) REFERENCES CONTROLORI(id_controlor),
id_traseu number(6), CONSTRAINT verifica_bilete_traseu_fk FOREIGN KEY(id_traseu) REFERENCES TRASEE(id_traseu),
CONSTRAINT verifica_bilet_pk PRIMARY KEY(id_controlor, id_traseu)
);



CREATE TABLE PASAGERI(
id_pasager number(4) CONSTRAINT pasageri_pk PRIMARY KEY,
nume varchar2(40) NOT NULL,
prenume varchar2(40) NOT NULL,
telefon varchar2(10) NOT NULL,
mail varchar2(120) NOT NULL,
data_nasterii date NOT NULL
);


CREATE TABLE REZERVA_BILET(
id_clasa number(2) NOT NULL, CONSTRAINT rezerva_bilet_clasa_fk FOREIGN KEY(id_clasa) REFERENCES CLASE(id_clasa),
id_traseu number(6) NOT NULL, CONSTRAINT rezerva_bilet_traseu_fk FOREIGN KEY(id_traseu) REFERENCES TRASEE(id_traseu),
id_pasager number(4) NOT NULL, CONSTRAINT rezerva_bilet_pasager_fk FOREIGN KEY(id_pasager) REFERENCES PASAGERI(id_pasager),
id_rezervare number(8) NOT NULL,
cod_gara_imbarcare varchar2(5) NOT NULL, CONSTRAINT rezerva_bilet_imabrcare_fk FOREIGN KEY(cod_gara_imbarcare) REFERENCES GARI(cod_SIRUES),
cod_gara_coborare varchar2(5) NOT NULL, CONSTRAINT rezerva_bilet_coborare_fk FOREIGN KEY(cod_gara_coborare) REFERENCES GARI(cod_SIRUES),
pret_bilet number(4),
CONSTRAINT rezerva_bilet_pk PRIMARY KEY(id_clasa, id_traseu, id_pasager, id_rezervare)
);


-----------------------------------------------------------------------------------------------------

-- Inserarea de date

INSERT INTO REGIUNI VALUES ('MUN', 'Muntenia', 78);

INSERT INTO REGIUNI VALUES ('TRA', 'Transilvania', 114);

INSERT INTO REGIUNI VALUES ('OLT', 'Oltenia', 67);

INSERT INTO REGIUNI VALUES ('BN', 'Banat', 54);

INSERT INTO REGIUNI VALUES ('CR', 'Crisana', 48);

INSERT INTO REGIUNI VALUES ('MRM', 'Maramures', 37);

INSERT INTO REGIUNI VALUES ('BCV', 'Bucovina', 42);

INSERT INTO REGIUNI VALUES ('MDV', 'Moldova', 107);

INSERT INTO REGIUNI VALUES ('DOB', 'Dobrogea', 82);

SELECT * FROM REGIUNI;



INSERT INTO ORASE VALUES ('625100', 'Iasi', 'MDV');
INSERT INTO ORASE VALUES ('783222', 'Craiova', 'OLT');
INSERT INTO ORASE VALUES ('024667', 'Galati', 'MDV');
INSERT INTO ORASE VALUES ('963323', 'Buzau', 'MUN');
INSERT INTO ORASE VALUES ('349909', 'Bacau', 'MDV');
INSERT INTO ORASE VALUES ('278898', 'Slatina', 'OLT');
INSERT INTO ORASE VALUES ('345556', 'Ramnicu Valcea', 'OLT');
INSERT INTO ORASE VALUES ('455303', 'Sibiu', 'TRA');
INSERT INTO ORASE VALUES ('243344', 'Cluj-Napoca', 'TRA');
INSERT INTO ORASE VALUES ('878866', 'Tulcea', 'DOB');
INSERT INTO ORASE VALUES ('878767', 'Constanta', 'DOB');
INSERT INTO ORASE VALUES ('677723', 'Bucuresti', 'MUN');
INSERT INTO ORASE VALUES ('900459', 'Timisoara', 'BN');
INSERT INTO ORASE VALUES ('324543', 'Oradea', 'CR');
INSERT INTO ORASE VALUES ('876543', 'Satu Mare', 'MRM');


SELECT * FROM ORASE;

INSERT INTO GARI VALUES ('27732', 'Gara de Nord Bucuresti', 'Soseaua Bucuresti 7', '0256022608', '677723');
INSERT INTO GARI VALUES ('27765', 'Gara Bucuresti Baneasa', 'Soseaua Baneasa 15', '0232312111', '677723');
INSERT INTO GARI VALUES ('33444', 'Gara Craiova Dolj', 'Soseaua Craiova 18', '0388737872', '783222');
INSERT INTO GARI VALUES ('33445', 'Gara Galati', 'Soseaua Galati 15', '0243435434', '024667');
INSERT INTO GARI VALUES ('33234', 'Gara Buzau', 'Soseaua Buzau 5', '0245465566', '963323');
INSERT INTO GARI VALUES ('33267', 'Gara Bacau', 'Soseaua Bacau 9', '0344434345', '349909');
INSERT INTO GARI VALUES ('33654', 'Gara Slatina', 'Soseaua Slatina 12', '0344353267', '278898');
INSERT INTO GARI VALUES ('33652', 'Gara Ramnicu Valcea', 'Soseaua Ramnicu Valcea 11', '0376755565', '345556');
INSERT INTO GARI VALUES ('33765', 'Gara Sibiu', 'Soseaua Sibiu 13', '0398765432', '455303');
INSERT INTO GARI VALUES ('45565', 'Gara Cluj-Napoca', 'Soseaua Cluj 19', '0467576657', '243344');
INSERT INTO GARI VALUES ('45325', 'Gara Tulcea', 'Soseaua Tulcea 3', '0468765467', '878866');
INSERT INTO GARI VALUES ('45367', 'Gara Constanta', 'Soseaua Constanta 6', '0567575567', '878767');
INSERT INTO GARI VALUES ('48768', 'Gara Timisoara', 'Soseaua Timisoara 13', '0623343434', '900459');
INSERT INTO GARI VALUES ('48769', 'Gara Oradea', 'Soseaua Oradea 8', '0676664645', '324543');
INSERT INTO GARI VALUES ('48898', 'Gara Satu Mare', 'Soseaua Satu Mare 4', '0676687897', '876543');

SELECT * FROM GARI;

CREATE SEQUENCE CONDUCTORI_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '27765', 'Popescu', 'Ion', '0766749327', to_date('07-12-2020', 'DD-MM-YYYY'), 4500);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '27765', 'Radoiu', 'Vlad', '0766435557', to_date('03-11-2021', 'DD-MM-YYYY'), 3800);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '27765', 'Ionescu', 'George', '0766456445', to_date('07-10-2019', 'DD-MM-YYYY'), 4700);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '27732', 'Florea', 'Cosmin', '0745436673', to_date('10-02-2020', 'DD-MM-YYYY'), 4100);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '27732', 'Dumitru', 'Denis', '0749876656', to_date('12-04-2020', 'DD-MM-YYYY'), 3900);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33444', 'Urzeala', 'Andrei', '0756655675', to_date('06-07-2018', 'DD-MM-YYYY'), 5400);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33445', 'Teodorescu', 'Tudor', '0723303042', to_date('08-09-2018', 'DD-MM-YYYY'), 2300);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33267', 'Costache', 'Gigel', '0704375723', to_date('10-11-2017', 'DD-MM-YYYY'), 3400);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33234', 'Ene', 'Sergiu', '0723438446', to_date('04-05-2017', 'DD-MM-YYYY'), 4700);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33652', 'Popa', 'Alexandru', '0798666743', to_date('10-10-2016', 'DD-MM-YYYY'), 6000);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45325', 'Tudose', 'Petru', '0736664324', to_date('06-08-2016', 'DD-MM-YYYY'), 3500);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45325', 'Moraru', 'Vasile', '0746885480', to_date('04-07-2016', 'DD-MM-YYYY'), 4000);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '33765', 'Dragan', 'Mihai', '0754566643', to_date('06-06-2015', 'DD-MM-YYYY'), 4600);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45565', 'Rusu', 'Gigel', '0796564335', to_date('06-03-2015', 'DD-MM-YYYY'), 3700);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45325', 'Matei', 'Alexandru', '0766788312', to_date('23-04-2014', 'DD-MM-YYYY'), 3900);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45367', 'Stanciu', 'Marian', '0712434112', to_date('25-07-2014', 'DD-MM-YYYY'), 4100);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '45325', 'Dedu', 'Andrei', '0789555732', to_date('13-11-2012', 'DD-MM-YYYY'), 2600);
INSERT INTO CONDUCTORI VALUES (CONDUCTORI_SECV.NEXTVAL, '48898', 'Lengher', 'Ionut', '0708964899', to_date('27-10-2013', 'DD-MM-YYYY'), 4300);


SELECT * FROM CONDUCTORI;


INSERT INTO COMPANII VALUES(1, 'Grup Feroviar Roman');
INSERT INTO COMPANII VALUES(2, 'Transferoviar Calatori');
INSERT INTO COMPANII VALUES(3, 'Regio Calatori');
INSERT INTO COMPANII VALUES(4, 'Softrans');
INSERT INTO COMPANII VALUES(5, 'Astra Trans Carpatic');

SELECT * FROM COMPANII;

CREATE SEQUENCE TRENURI_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 240, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 220, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 200, 9);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 220, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 160, 8);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 2, 180, 8);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 2, 200, 9);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 3, 160, 7);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 3, 180, 9);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 200, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 220, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 4, 210, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 240, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 220, 10);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 5, 180, 8);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 160, 7);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 5, 140, 6);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 1, 150, 6);
INSERT INTO TRENURI VALUES(TRENURI_SECV.NEXTVAL, 4, 200, 9);

SELECT * FROM TRENURI;

INSERT INTO CLASE VALUES(10, 'Clasa I', NULL, NULL);
INSERT INTO CLASE VALUES(11, 'Clasa II', 200, 'aer conditionat');
INSERT INTO CLASE VALUES(12, 'Clasa II pachet exclusive', 500, 'acces vagon restaurant');
INSERT INTO CLASE VALUES(13, 'CLASA II pachet confort', 600, 'loc de dormit');
INSERT INTO CLASE VALUES(14, 'Clasa II pachet premium', 800, 'acces vagon restaurant, loc de dormit, scaune rabatabile cu priza type-C');


SELECT * FROM CLASE;

SELECT * FROM TRENURI_AU_CLASE;

INSERT INTO TRENURI_AU_CLASE VALUES (10, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (10, 11);

INSERT INTO TRENURI_AU_CLASE VALUES (11, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (11, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (11, 12);

INSERT INTO TRENURI_AU_CLASE VALUES (12, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (12, 13);
INSERT INTO TRENURI_AU_CLASE VALUES (12, 14);

INSERT INTO TRENURI_AU_CLASE VALUES (13, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (13, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (13, 12);

INSERT INTO TRENURI_AU_CLASE VALUES (14, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (14, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (14, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (14, 13);
INSERT INTO TRENURI_AU_CLASE VALUES (14, 14);

INSERT INTO TRENURI_AU_CLASE VALUES (15, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (15, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (15, 13);
INSERT INTO TRENURI_AU_CLASE VALUES (15, 14);

INSERT INTO TRENURI_AU_CLASE VALUES (16, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (16, 11);

INSERT INTO TRENURI_AU_CLASE VALUES (17, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (17, 13);

INSERT INTO TRENURI_AU_CLASE VALUES (18, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (18, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (18, 12);

INSERT INTO TRENURI_AU_CLASE VALUES (19, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (19, 13);
INSERT INTO TRENURI_AU_CLASE VALUES (19, 14);

INSERT INTO TRENURI_AU_CLASE VALUES (20, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (20, 11);

INSERT INTO TRENURI_AU_CLASE VALUES (21, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (21, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (21, 13);

INSERT INTO TRENURI_AU_CLASE VALUES (22, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (22, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (22, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (22, 13);

INSERT INTO TRENURI_AU_CLASE VALUES (23, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (23, 11);

INSERT INTO TRENURI_AU_CLASE VALUES (24, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (24, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (24, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (24, 13);

INSERT INTO TRENURI_AU_CLASE VALUES (25, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (25, 11);

INSERT INTO TRENURI_AU_CLASE VALUES (26, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (26, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (26, 12);

INSERT INTO TRENURI_AU_CLASE VALUES (27, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (27, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (27, 12);

INSERT INTO TRENURI_AU_CLASE VALUES (28, 10);
INSERT INTO TRENURI_AU_CLASE VALUES (28, 11);
INSERT INTO TRENURI_AU_CLASE VALUES (28, 12);
INSERT INTO TRENURI_AU_CLASE VALUES (28, 13);


SELECT * FROM CONTROLORI;

CREATE SEQUENCE CONTROLORI_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '27732', 'Georgescu', 'Ion', '0766723327', to_date('07-11-2020', 'DD-MM-YYYY'), 4000);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '27732', 'Panescu', 'Florin', '0735656785', to_date('09-10-2018', 'DD-MM-YYYY'), 4100);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '27765', 'Florescu', 'Mihnea', '0766722327', to_date('10-10-2018', 'DD-MM-YYYY'), 4200);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33444', 'Deleanu', 'Ionut', '0789723327', to_date('12-07-2016', 'DD-MM-YYYY'), 4300);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33445', 'Dascalu', 'David', '0766724456', to_date('09-12-2018', 'DD-MM-YYYY'), 3900);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33234', 'Dragan', 'Liviu', '0766787727', to_date('21-09-2019', 'DD-MM-YYYY'), 3600);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33267', 'Popescu', 'Stefan', '0734523327', to_date('07-03-2020', 'DD-MM-YYYY'), 3400);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33654', 'Banu', 'Marcel', '0766722237', to_date('07-08-2019', 'DD-MM-YYYY'), 3900);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33652', 'Popa', 'Andrei', '0756724237', to_date('05-07-2016', 'DD-MM-YYYY'), 4200);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '33765', 'Andronache', 'Cosmin', '0745524237', to_date('11-09-2017', 'DD-MM-YYYY'), 4100);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '45565', 'Raducu', 'Mircea', '0767724237', to_date('10-05-2017', 'DD-MM-YYYY'), 4000);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '45565', 'Matei', 'Vlad', '0767721137', to_date('24-06-2019', 'DD-MM-YYYY'), 3900);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '45367', 'Rusu', 'Ionut', '0767732335', to_date('21-11-2020', 'DD-MM-YYYY'), 4100);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '48768', 'Costache', 'Antonio', '0723332453', to_date('19-10-2020', 'DD-MM-YYYY'), 4000);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '48769', 'Mihalache', 'George', '0789454323', to_date('29-04-2019', 'DD-MM-YYYY'), 3900);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '48898', 'Ionescu', 'Mihail', '0765556787', to_date('25-05-2020', 'DD-MM-YYYY'), 3600);
INSERT INTO CONTROLORI VALUES (CONTROLORI_SECV.NEXTVAL, '48898', 'Ionescu', 'Marius', '0765556745', to_date('11-05-2020', 'DD-MM-YYYY'), 3700);





CREATE SEQUENCE PASAGERI_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Negoita', 'Mirel', '0765785348', 'negoitamirel@yahoo.com',  to_date('25-05-1985', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Tudor', 'Iulian', '0733533459', 'tudoriulian@yahoo.com',  to_date('12-06-1978', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Fratila', 'Catalin', '0708393404', 'fratilacatalin@yahoo.com',  to_date('05-04-1996', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Munteanu', 'Mirel', '0714729299', 'munteanumirel@yahoo.com',  to_date('07-11-2000', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Moldoveanu', 'David', '0723421367', 'munteanumirel@yahoo.com',  to_date('06-12-1997', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Tomescu', 'Iulian', '0768945678', 'munteanumirel@yahoo.com',  to_date('23-08-1983', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Diaconu', 'David', '0723790210', 'munteanumirel@yahoo.com',  to_date('14-05-1969', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Deaconu', 'Valeriu', '0735464625', 'munteanumirel@yahoo.com',  to_date('18-03-1975', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Georgescu', 'Denis', '0776878877', 'georgescudenis@yahoo.com',  to_date('20-05-2002', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Costache', 'Andrei', '0767534558', 'costacheandrei@yahoo.com',  to_date('13-07-2001', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Albu', 'Iulian', '0743647372', 'albuiulian@yahoo.com',  to_date('10-10-1980', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Dumitru', 'Marius', '0778954658', 'dumitrumarius@yahoo.com',  to_date('15-10-1995', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Popescu', 'Florin', '0716342383', 'popescuflorin@yahoo.com',  to_date('06-07-1997', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Paduraru', 'George', '0747433243', 'padurarugeorge@yahoo.com',  to_date('14-11-1979', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Verdes', 'Silviu', '0765897774', 'verdessilviu@yahoo.com',  to_date('10-09-1979', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Cristea', 'Madalin', '0792004221', 'cristeamadalin@yahoo.com',  to_date('26-04-1995', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Florea', 'Cosmin', '0734275214', 'floreacosmin@yahoo.com',  to_date('12-10-1995', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Radu', 'Stefan', '0714421423', 'radustefan@yahoo.com',  to_date('15-01-1985', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Gheorghe', 'Radu', '0789431478', 'gheorgheradu@yahoo.com',  to_date('20-04-1993', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Paun', 'Andrei', '0774867862', 'paunandrei@yahoo.com',  to_date('23-10-2000', 'DD-MM-YYYY'));
INSERT INTO PASAGERI VALUES (PASAGERI_SECV.NEXTVAL, 'Paun', 'Ilie', '0774834462', 'paunilie@yahoo.com',  to_date('14-09-1997', 'DD-MM-YYYY'));

SELECT * FROM PASAGERI;


CREATE SEQUENCE TRASEE_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;


SELECT * FROM TRASEE;

INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33445', '33267', 17, 18, 12, to_date('23-10-2022', 'DD-MM-YYYY'), to_date('23-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '27732', '45367', 14, 26, 22, to_date('10-07-2022', 'DD-MM-YYYY'), to_date('10-07-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '27765', '33652', 13, 20, 14, to_date('15-11-2022', 'DD-MM-YYYY'), to_date('15-11-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33765', '45565', 23, 24, 15, to_date('07-04-2022', 'DD-MM-YYYY'), to_date('07-04-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '48768', '48898', 28, 24, 18, to_date('25-10-2022', 'DD-MM-YYYY'), to_date('26-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33234', '45325', 19, 21, 11, to_date('19-03-2022', 'DD-MM-YYYY'), to_date('19-03-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '48768', '33654', 16, 28, 17, to_date('17-10-2022', 'DD-MM-YYYY'), to_date('17-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '45565', '48768', 24, 16, 26, to_date('24-09-2022', 'DD-MM-YYYY'), to_date('24-09-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33444', '48769', 16, 28, 14, to_date('27-10-2022', 'DD-MM-YYYY'), to_date('27-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '27765', '48898', 12, 13, 10, to_date('13-10-2022', 'DD-MM-YYYY'), to_date('13-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '45565', '45367', 24, 26, 24, to_date('09-08-2022', 'DD-MM-YYYY'), to_date('10-08-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33267', '27732', 18, 15, 16, to_date('10-12-2022', 'DD-MM-YYYY'), to_date('10-12-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33765', '48768', 16, 13, 21, to_date('16-10-2022', 'DD-MM-YYYY'), to_date('16-10-2022', 'DD-MM-YYYY'));
INSERT INTO TRASEE VALUES (TRASEE_SECV.NEXTVAL, '33445', '45367', 17, 26, 13, to_date('18-06-2022', 'DD-MM-YYYY'), to_date('18-06-2022', 'DD-MM-YYYY'));


SELECT * FROM VERIFICA_BILET;

INSERT INTO VERIFICA_BILET VALUES (14, 10);

INSERT INTO VERIFICA_BILET VALUES (11, 11);
INSERT INTO VERIFICA_BILET VALUES (22, 11);

INSERT INTO VERIFICA_BILET VALUES (18, 12);
INSERT INTO VERIFICA_BILET VALUES (12, 12);

INSERT INTO VERIFICA_BILET VALUES (19, 13);
INSERT INTO VERIFICA_BILET VALUES (21, 13);

INSERT INTO VERIFICA_BILET VALUES (23, 14);

INSERT INTO VERIFICA_BILET VALUES (15, 15);

INSERT INTO VERIFICA_BILET VALUES (23, 16);
INSERT INTO VERIFICA_BILET VALUES (17, 16);

INSERT INTO VERIFICA_BILET VALUES (21, 17);
INSERT INTO VERIFICA_BILET VALUES (20, 17);

INSERT INTO VERIFICA_BILET VALUES (13, 18);
INSERT INTO VERIFICA_BILET VALUES (24, 18);

INSERT INTO VERIFICA_BILET VALUES (12, 19);
INSERT INTO VERIFICA_BILET VALUES (25, 19);
INSERT INTO VERIFICA_BILET VALUES (30, 18);

INSERT INTO VERIFICA_BILET VALUES (21, 20);
INSERT INTO VERIFICA_BILET VALUES (20, 20);

INSERT INTO VERIFICA_BILET VALUES (11, 21);

INSERT INTO VERIFICA_BILET VALUES (19, 22);
INSERT INTO VERIFICA_BILET VALUES (23, 22);

INSERT INTO VERIFICA_BILET VALUES (14, 23);



---------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE REZERVARI_SECV
START WITH 10
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE;

SELECT * FROM REZERVA_BILET;

INSERT INTO REZERVA_BILET VALUES (10, 10, 11, REZERVARI_SECV.NEXTVAL, '33445', '33267', 20);
INSERT INTO REZERVA_BILET VALUES (11, 10, 14, REZERVARI_SECV.NEXTVAL, '33445', '33267', 30);
INSERT INTO REZERVA_BILET VALUES (10, 10, 33, REZERVARI_SECV.NEXTVAL, '33445', '33267', 20);

INSERT INTO REZERVA_BILET VALUES (12, 11, 12, REZERVARI_SECV.NEXTVAL, '27732', '45367', 60);
INSERT INTO REZERVA_BILET VALUES (12, 11, 37, REZERVARI_SECV.NEXTVAL, '27732', '45367', 60);
INSERT INTO REZERVA_BILET VALUES (13, 11, 40, REZERVARI_SECV.NEXTVAL, '27732', '45367', 70);

INSERT INTO REZERVA_BILET VALUES (10, 12, 15, REZERVARI_SECV.NEXTVAL, '27765', '33444', 40);
INSERT INTO REZERVA_BILET VALUES (10, 12, 30, REZERVARI_SECV.NEXTVAL, '27765', '33444', 40);
INSERT INTO REZERVA_BILET VALUES (13, 12, 41, REZERVARI_SECV.NEXTVAL, '27765', '33652', 90);

INSERT INTO REZERVA_BILET VALUES (10, 13, 13, REZERVARI_SECV.NEXTVAL, '33765', '45565', 35);
INSERT INTO REZERVA_BILET VALUES (10, 13, 33, REZERVARI_SECV.NEXTVAL, '33765', '45565', 35);
INSERT INTO REZERVA_BILET VALUES (14, 13, 38, REZERVARI_SECV.NEXTVAL, '33765', '45565', 85);

INSERT INTO REZERVA_BILET VALUES (10, 14, 10, REZERVARI_SECV.NEXTVAL, '48768', '48898', 50);
INSERT INTO REZERVA_BILET VALUES (12, 14, 12, REZERVARI_SECV.NEXTVAL, '48768', '48769', 65);
INSERT INTO REZERVA_BILET VALUES (12, 14, 39, REZERVARI_SECV.NEXTVAL, '48768', '48769', 65);

INSERT INTO REZERVA_BILET VALUES (10, 15, 17, REZERVARI_SECV.NEXTVAL, '33234', '45325', 40);
INSERT INTO REZERVA_BILET VALUES (11, 15, 16, REZERVARI_SECV.NEXTVAL, '33234', '45325', 50);
INSERT INTO REZERVA_BILET VALUES (11, 15, 34, REZERVARI_SECV.NEXTVAL, '33234', '45325', 50);

INSERT INTO REZERVA_BILET VALUES (10, 16, 14, REZERVARI_SECV.NEXTVAL, '48768', '33654', 40);
INSERT INTO REZERVA_BILET VALUES (10, 16, 31, REZERVARI_SECV.NEXTVAL, '48768', '33444', 40);
INSERT INTO REZERVA_BILET VALUES (10, 16, 32, REZERVARI_SECV.NEXTVAL, '48768', '33444', 40);

INSERT INTO REZERVA_BILET VALUES (12, 17, 15, REZERVARI_SECV.NEXTVAL, '45565', '48768', 75);
INSERT INTO REZERVA_BILET VALUES (12, 17, 37, REZERVARI_SECV.NEXTVAL, '45565', '48768', 75);
INSERT INTO REZERVA_BILET VALUES (13, 17, 38, REZERVARI_SECV.NEXTVAL, '45565', '48768', 85);

INSERT INTO REZERVA_BILET VALUES (10, 18, 13, REZERVARI_SECV.NEXTVAL, '33444', '48769', 50);
INSERT INTO REZERVA_BILET VALUES (11, 18, 33, REZERVARI_SECV.NEXTVAL, '33444', '48769', 60);
INSERT INTO REZERVA_BILET VALUES (14, 18, 36, REZERVARI_SECV.NEXTVAL, '33444', '48768', 80);

INSERT INTO REZERVA_BILET VALUES (10, 19, 12, REZERVARI_SECV.NEXTVAL, '27765', '48898', 50);
INSERT INTO REZERVA_BILET VALUES (10, 19, 17, REZERVARI_SECV.NEXTVAL, '27765', '48898', 50);
INSERT INTO REZERVA_BILET VALUES (10, 19, 39, REZERVARI_SECV.NEXTVAL, '27765', '45565', 50);

INSERT INTO REZERVA_BILET VALUES (10, 20, 33, REZERVARI_SECV.NEXTVAL, '45565', '45367', 55);
INSERT INTO REZERVA_BILET VALUES (11, 20, 34, REZERVARI_SECV.NEXTVAL, '45565', '27732', 65);
INSERT INTO REZERVA_BILET VALUES (11, 20, 41, REZERVARI_SECV.NEXTVAL, '45565', '27765', 65);

INSERT INTO REZERVA_BILET VALUES (10, 21, 35, REZERVARI_SECV.NEXTVAL, '33267', '27732', 30);
INSERT INTO REZERVA_BILET VALUES (12, 21, 38, REZERVARI_SECV.NEXTVAL, '33267', '27732', 45);
INSERT INTO REZERVA_BILET VALUES (12, 21, 10, REZERVARI_SECV.NEXTVAL, '33267', '27732', 45);

INSERT INTO REZERVA_BILET VALUES (10, 22, 12, REZERVARI_SECV.NEXTVAL, '33765', '48768', 40);
INSERT INTO REZERVA_BILET VALUES (13, 22, 35, REZERVARI_SECV.NEXTVAL, '33765', '48768', 65);
INSERT INTO REZERVA_BILET VALUES (14, 22, 36, REZERVARI_SECV.NEXTVAL, '33765', '48768', 75);

INSERT INTO REZERVA_BILET VALUES (10, 23, 17, REZERVARI_SECV.NEXTVAL, '33445', '45367', 40);
INSERT INTO REZERVA_BILET VALUES (12, 23, 30, REZERVARI_SECV.NEXTVAL, '33445', '45367', 60);
INSERT INTO REZERVA_BILET VALUES (10, 23, 31, REZERVARI_SECV.NEXTVAL, '33445', '45367', 40);


SELECT * FROM GARI;

-----------------------------------------------------------------------------------------------

-- Cerinta 6

-- Sa se afiseze media salariilor conductorilor pentru fiecare gara si numele garii

CREATE OR REPLACE PROCEDURE cerinta6 IS

    
    TYPE gara_rec IS RECORD (cod GARI.COD_SIRUES%TYPE, denumire GARI.NUME%TYPE, salariu CONDUCTORI.SALARIU%TYPE);
    
    TYPE tablou IS TABLE OF gara_rec;
    
    TYPE vector IS VARRAY(20) OF CONDUCTORI.SALARIU%TYPE;
    
    CURSOR crs IS
        SELECT COD_SIRUES 
        FROM GARI;

   
    t tablou := tablou();
    v vector := vector();
    g gara_rec;
   
BEGIN        
    FOR c IN crs LOOP
        
        SELECT COD_SIRUES, NUME
        INTO g.cod, g.denumire
        FROM GARI
        WHERE c.COD_SIRUES = COD_SIRUES;
        
        v.EXTEND;
        SELECT AVG(SALARIU)
        INTO v(v.LAST)
        FROM CONDUCTORI
        WHERE COD_GARA = c.COD_SIRUES;
        
        g.salariu := v(v.LAST);
        
        t.EXTEND;
        t(t.LAST) := g;
        
        IF (t(t.LAST).salariu IS NULL) THEN 
            DBMS_OUTPUT.PUT_LINE ('Nu avem angajati disponibili in aceasta gara');
        ELSE
            DBMS_OUTPUT.PUT_LINE ('Pentru gara ' || t(t.LAST).denumire || ' media salariilor este ' || t(t.LAST).salariu);
        END IF;
    END LOOP;

END cerinta6;
/

EXECUTE cerinta6;


-----------------------------------------------------------------------------------------------------------------------------

-- Cerinta 7
-- Sa se mareasca salariul cu 25% conductorilor care lucreaza in regiuni ce contin cel putin 50 de gari


CREATE OR REPLACE PROCEDURE cerinta7 IS

    TYPE tab_regiuni IS TABLE OF REGIUNI.NUME%TYPE;
    t_reg tab_regiuni;

    CURSOR reg IS 
        SELECT NUME
        FROM REGIUNI
        WHERE NUMAR_GARI >=50
        ORDER BY NUME;
    
    CURSOR cond (region_name VARCHAR2) IS 
        SELECT * FROM CONDUCTORI
        WHERE COD_GARA IN (SELECT COD_SIRUES FROM GARI WHERE COD_POSTAL_ORAS IN
        (SELECT COD_POSTAL FROM ORASE WHERE ID_REGIUNE = 
        (SELECT ID_REGIUNE FROM REGIUNI WHERE NUME LIKE region_name )))
        FOR UPDATE OF SALARIU NOWAIT;

BEGIN
    OPEN reg;
    FETCH reg BULK COLLECT INTO t_reg;
    CLOSE reg;

    FOR r in t_reg.FIRST..t_reg.LAST LOOP
        FOR c in cond(t_reg(r)) LOOP
            UPDATE CONDUCTORI
            SET SALARIU = SALARIU + ((SALARIU * 25)/100)
            WHERE CURRENT OF cond;
        END LOOP;
    END LOOP;

END cerinta7;
/
EXECUTE cerinta7;    
        
SELECT * FROM CONDUCTORI;


------------------------------------------------------------------------------------------------------

-- Cerinta 8
-- Sa se afiseze costul rezervarilor facute de un pasager unde numele sau este dat ca input. 
-- Costul rezervarilor presupune suma biletelor achizitionate de acesta, adaugandu-se preturile aditionale in functie de clasa la care s-a facut rezervarea.
-- Sa se trateze cazurile in care avem prea multi pasageri cu acelasi nume, in care nu exista persoana data ca input si cel in care nu s-au facut rezervari de persoana data.



SELECT * FROM PASAGERI;
SELECT * FROM REZERVA_BILET
WHERE ID_PASAGER = 15;


CREATE OR REPLACE FUNCTION cerinta8 (input_name PASAGERI.NUME%TYPE)
RETURN REZERVA_BILET.PRET_BILET%TYPE IS

    counter NUMBER;
    final_price REZERVA_BILET.PRET_BILET%TYPE;
    no_persons EXCEPTION;
    too_many_persons EXCEPTION;
    no_rezervations EXCEPTION;
    
    
BEGIN

    SELECT COUNT(*) INTO counter
    FROM PASAGERI 
    WHERE LOWER(input_name) = LOWER(NUME);
    
    IF (counter = 0) 
    THEN RAISE no_persons;
    ELSIF (counter > 1) 
    THEN RAISE too_many_persons;
    END IF;

    SELECT COUNT(*) INTO counter
    FROM REZERVA_BILET INNER JOIN PASAGERI USING (ID_PASAGER)
    WHERE LOWER(PASAGERI.NUME) = LOWER(input_name);
    
    IF (counter = 0)
    THEN RAISE no_rezervations;
    END IF;
    
    
    SELECT SUM (PRET_BILET + NVL(PRET_ADITIONAL,0))
    INTO final_price
    FROM REZERVA_bilet JOIN CLASE USING (ID_CLASA) JOIN PASAGERI USING (ID_PASAGER)
    WHERE LOWER(input_name) = LOWER(PASAGERI.NUME);
    
    RETURN final_price;
    
    
EXCEPTION 
    WHEN no_persons THEN 
        DBMS_OUTPUT.PUT_LINE('Nu exista persoane cu numele dat');
        RETURN -1;
--        RAISE_APPLICATION_ERROR(-20015,'Nu exista persoane cu numele dat');
            
    WHEN too_many_persons THEN 
        DBMS_OUTPUT.PUT_LINE('Prea multe persoane cu acelasi nume');
        RETURN -2;
--        RAISE_APPLICATION_ERROR(-20016,'Prea multe persoane cu acelasi nume');
        
    WHEN no_rezervations THEN 
        DBMS_OUTPUT.PUT_LINE('Nu exista rezervari cu numele dat');
        RETURN -3;
--        RAISE_APPLICATION_ERROR(-20017,'Nu exista rezervari cu numele dat');
         

    
    
END cerinta8;
/

    
SELECT cerinta8('Tomescu') FROM DUAL;
-- un bilet de 40 RON fara cost aditional + un bilet de 75 RON cu un cost aditional de 50 RON = 165 RON suma rezervarilor

SELECT cerinta8('Besliu') FROM DUAL;
-- nu exista acest nume in baza de date

SELECT cerinta8('Paun') FROM DUAL;
-- exista doua persoane cu acest nume


-------------------------------------------------------------------------------------------------------------------

-- Cerinta 9
-- Se da numele unui controlor ca input.
-- Sa se afiseze numarul de trasee unde acesta a verificat bilete, gara, orasul si regiunea de unde vine.
-- Sa se trateze cazurile in care exista prea multi controlori cu numele dat ca input sau nu exista controlori cu numele dat.

SELECT * FROM VERIFICA_BILET;
SELECT * FROM CONTROLORI;
SELECT * FROM GARI;
SELECT * FROM REGIUNI;



CREATE OR REPLACE PROCEDURE cerinta9 (input_name CONTROLORI.NUME%TYPE) IS
    
    reg_name REGIUNI.NUME%TYPE;
    ors_name ORASE.NUME%TYPE;
    gr_name GARI.NUME%TYPE;
    nr_trasee NUMBER;
    
    
BEGIN

    SELECT COUNT(vf.ID_TRASEU), gr.NUME, ors.NUME, reg.NUME
    INTO nr_trasee, gr_name, ors_name, reg_name
    FROM VERIFICA_BILET vf RIGHT JOIN CONTROLORI cn ON (cn.ID_CONTROLOR = vf.ID_CONTROLOR)
    JOIN GARI gr ON (cn.COD_GARA = gr.COD_SIRUES)
    JOIN ORASE ors ON (ors.COD_POSTAL = gr.COD_POSTAL_ORAS)
    JOIN REGIUNI reg ON (reg.ID_REGIUNE = ors.ID_REGIUNE)
    WHERE LOWER(input_name) = LOWER(cn.NUME)
    GROUP BY  gr.NUME, ors.NUME, reg.NUME;
    
    IF (nr_trasee = 1)
    THEN DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' a verificat bilete pe un singur traseu si apartine garii ' || gr_name || ' din orasul ' || ors_name || ', regiunea ' || reg_name);
    ELSIF (nr_trasee > 1)
    THEN DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' a verificat bilete pe ' || nr_trasee || ' trasee si apartine garii ' || gr_name || ' din orasul ' || ors_name || ', regiunea ' || reg_name);
    ELSIF (nr_trasee = 0)
    THEN  DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' nu a verificat bilete pe niciun traseu');
    END IF;

EXCEPTION

    WHEN TOO_MANY_ROWS
    THEN RAISE_APPLICATION_ERROR(-20008, 'Prea multe persoane cu acelasi nume dat ca input');
    WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20009, 'Nu exista persoane cu numele dat ca input');
END cerinta9;
/

-- nu a verificat niciun bilet
EXECUTE cerinta9('Georgescu');

-- nu exista controlor cu acest nume
EXECUTE cerinta9('Orlando');

-- exista 2 persoane cu acest nume
EXECUTE cerinta9('Ionescu');



-----------------------------------------------------------------------------------------------------------------------------------

-- Cerinta 10
-- Trigger ce impiedica stergerea de date din tabelul ORASE

CREATE OR REPLACE TRIGGER cerinta10 
    BEFORE DELETE ON ORASE
BEGIN
    RAISE_APPLICATION_ERROR(-20011, 'Nu este permisa stergerea de date din tabelul ORASE');
END;
/

DELETE FROM ORASE
WHERE NUME = 'Craiova';
------------------------------------------------------------------------------------------------------------------------------------

-- Cerinta 11
-- Trigger care impiedica cresterea salariului controlorilor care au verificat bilete la mai putin de 5 trasee cu mai mult de 1000

CREATE OR REPLACE TRIGGER cerinta11
    BEFORE UPDATE ON CONTROLORI
    FOR EACH ROW
DECLARE 
    nr_trasee NUMBER :=0;
BEGIN 
    SELECT COUNT(*) INTO nr_trasee
    FROM VERIFICA_BILET
    WHERE ID_CONTROLOR = :OLD.ID_CONTROLOR;
    
    IF(:NEW.SALARIU > :OLD.SALARIU +1000) AND (nr_trasee < 5)
    THEN RAISE_APPLICATION_ERROR (-20012, 'Salariul nu poate fi marit cu mai mult de 1000 unui controlor care a verificat bilete la mai putin de 5 trasee');
    END IF;
    
END;
/

SELECT * FROM CONTROLORI

UPDATE CONTROLORI
SET SALARIU = 8000
WHERE ID_CONTROLOR = 30;



---------------------------------------------------------------------------------------------------------------------------------------

-- Cerinta 12
-- Trigger care afiseaza un mesaj in momentul rularii unei comenzi de tip LDD

CREATE OR REPLACE TRIGGER cerinta12
    AFTER CREATE OR ALTER OR DROP ON SCHEMA
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('S-a rulat o comanda de tip LDD');
END;
/

ALTER TABLE PASAGERI
ADD nr_bagaje NUMBER(2);

ALTER TABLE PASAGERI
DROP COLUMN nr_bagaje;

----------------------------------------------------------------------------------------------------------------

-- Cerinta 13 cu pachet ce contine toate obiectele din cadrul proiectului.

CREATE OR REPLACE PACKAGE cerinta13 AS
    FUNCTION cerinta8 (input_name PASAGERI.NUME%TYPE) RETURN REZERVA_BILET.PRET_BILET%TYPE;
    PROCEDURE cerinta6;
    PROCEDURE cerinta7;
    PROCEDURE cerinta9 (input_name CONTROLORI.NUME%TYPE);
    
END cerinta13;
/
CREATE OR REPLACE PACKAGE BODY cerinta13 AS
    
    -- costul rezervarilor facute de un pasager unde numele sau este dat ca input
    
    FUNCTION cerinta8 (input_name PASAGERI.NUME%TYPE)
    RETURN REZERVA_BILET.PRET_BILET%TYPE IS

        counter NUMBER;
        final_price REZERVA_BILET.PRET_BILET%TYPE;
    
    
    BEGIN

        SELECT COUNT(*) INTO counter
        FROM PASAGERI 
        WHERE LOWER(input_name) = LOWER(NUME);
        
        IF (counter = 0) 
        THEN RAISE_APPLICATION_ERROR(-20001, 'Nu s-au gasit persoane cu numele dat ca input.');
        ELSIF (counter > 1) 
        THEN RAISE_APPLICATION_ERROR ( -20001 , 'S-au gasit prea multe persoane cu numele dat ca input.');
        END IF;
    
        SELECT COUNT(*) INTO counter
        FROM REZERVA_BILET INNER JOIN PASAGERI USING (ID_PASAGER)
        WHERE LOWER(PASAGERI.NUME) = LOWER(input_name);
        
        IF (counter = 0)
        THEN RAISE_APPLICATION_ERROR (-20003, 'Nu s-au gasit rezervari pentru numele dat ca input.');
        END IF;
        
        
        SELECT SUM (PRET_BILET + NVL(PRET_ADITIONAL,0))
        INTO final_price
        FROM REZERVA_bilet JOIN CLASE USING (ID_CLASA) JOIN PASAGERI USING (ID_PASAGER)
        WHERE LOWER(input_name) = LOWER(PASAGERI.NUME);
        
        RETURN final_price;
    
    END cerinta8;
    
    

    -- media salariilor conductorilor pentru fiecare gara , cat si numele garii
    
    PROCEDURE cerinta6 IS
        TYPE gara_rec IS RECORD (cod GARI.COD_SIRUES%TYPE, denumire GARI.NUME%TYPE, salariu CONDUCTORI.SALARIU%TYPE);
        TYPE tablou IS TABLE OF gara_rec;
        TYPE vector IS VARRAY(20) OF CONDUCTORI.SALARIU%TYPE;
    
        CURSOR crs IS
            SELECT COD_SIRUES 
            FROM GARI;
   
        t tablou := tablou();
        v vector := vector();
        g gara_rec;
   
    BEGIN        
        FOR c IN crs LOOP
            
            SELECT COD_SIRUES, NUME
            INTO g.cod, g.denumire
            FROM GARI
            WHERE c.COD_SIRUES = COD_SIRUES;
            
            v.EXTEND;
            SELECT AVG(SALARIU)
            INTO v(v.LAST)
            FROM CONDUCTORI
            WHERE COD_GARA = c.COD_SIRUES;
            
            g.salariu := v(v.LAST);
            
            t.EXTEND;
            t(t.LAST) := g;
            
            IF (t(t.LAST).salariu IS NULL) THEN 
                DBMS_OUTPUT.PUT_LINE ('Nu avem angajati disponibili in aceasta gara');
            ELSE
                DBMS_OUTPUT.PUT_LINE ('Pentru gara ' || t(t.LAST).denumire || ' media salariilor este ' || t(t.LAST).salariu);
            END IF;
        END LOOP;

    END cerinta6;

    -- marirea salariul cu 25% conductorilor care lucreaza in regiuni ce contin cel putin 50 de gari
    
    PROCEDURE cerinta7 IS

        CURSOR reg IS 
            SELECT NUME
            FROM REGIUNI
            WHERE NUMAR_GARI >=50
            ORDER BY NUME;
    
        CURSOR cond (region_name VARCHAR2) IS 
            SELECT * FROM CONDUCTORI
            WHERE COD_GARA IN (SELECT COD_SIRUES FROM GARI WHERE COD_POSTAL_ORAS IN
            (SELECT COD_POSTAL FROM ORASE WHERE ID_REGIUNE = 
            (SELECT ID_REGIUNE FROM REGIUNI WHERE NUME LIKE region_name )))
            FOR UPDATE OF SALARIU NOWAIT;

    BEGIN

        FOR r in reg LOOP
            FOR c in cond(r.NUME) LOOP
                UPDATE CONDUCTORI
                SET SALARIU = SALARIU + ((SALARIU * 25)/100)
                WHERE CURRENT OF cond;
            END LOOP;
        END LOOP;

    END cerinta7;
    
    
    -- afisarea numarului de trasee unde un controlor a verificat bilete, gara, orasul si regiunea de unde vine.
    
    PROCEDURE cerinta9 (input_name CONTROLORI.NUME%TYPE) IS
        
        reg_name REGIUNI.NUME%TYPE;
        ors_name ORASE.NUME%TYPE;
        gr_name GARI.NUME%TYPE;
        nr_trasee NUMBER;
    
    BEGIN

        SELECT COUNT(ID_TRASEU), gr.NUME, ors.NUME, reg.NUME
        INTO nr_trasee, gr_name, ors_name, reg_name
        FROM VERIFICA_BILET vf RIGHT JOIN CONTROLORI cn ON (vf.ID_CONTROLOR = cn.ID_CONTROLOR)
        JOIN GARI gr ON (cn.COD_GARA = gr.COD_SIRUES)
        JOIN ORASE ors ON (ors.COD_POSTAL = gr.COD_POSTAL_ORAS)
        JOIN REGIUNI reg ON (reg.ID_REGIUNE = ors.ID_REGIUNE)
        WHERE LOWER(cn.NUME) = LOWER(input_name)
        GROUP BY  gr.NUME, ors.NUME, reg.NUME;
        
        IF (nr_trasee = 1)
        THEN DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' a verificat bilete pe un singur traseu si apartine garii ' || gr_name || ' din orasul ' || ors_name || ', regiunea ' || reg_name);
        ELSIF (nr_trasee > 1)
        THEN DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' a verificat bilete pe ' || nr_trasee || ' trasee si apartine garii ' || gr_name || ' din orasul ' || ors_name || ', regiunea ' || reg_name);
        ELSIF (nr_trasee = 0)
        THEN  DBMS_OUTPUT.PUT_LINE('Controlorul ' || input_name || ' nu a verificat bilete pe niciun traseu');
        END IF;

    EXCEPTION

        WHEN TOO_MANY_ROWS
        THEN RAISE_APPLICATION_ERROR(-20008, 'Prea multe persoane cu acelasi nume dat ca input');
        WHEN NO_DATA_FOUND
        THEN RAISE_APPLICATION_ERROR(-20009, 'Nu exista persoane cu numele dat ca input');
    END cerinta9;

END cerinta13;
/

EXECUTE cerinta13.cerinta6;

EXECUTE cerinta13.cerinta7;
SELECT * FROM CONDUCTORI;

ROLLBACK;

SELECT cerinta13.cerinta8('Tomescu') FROM DUAL;

EXECUTE cerinta13.cerinta9('Georgescu');


-------------------------------------------------------------------------------------------------------------------------

-- Cerinta 14 cu pachet cu obiecte necesare unui flux de actiuni.
-- Creati un tabel imbricat cu o coloana de tip record ce contine date despre angajati.
-- Se folosesc 2 proceduri pentru a stoca datele despre controlori si conductori si 2 functii,
-- una pentru a calcula media salariilor angajatilor si alta pentru a calcula numarul de angajati care au salariul peste medie.

SELECT * FROM CONDUCTORI;

CREATE OR REPLACE PACKAGE cerinta14 AS
    TYPE record_employees IS RECORD
    (last_name CONDUCTORI.NUME%TYPE, first_name CONDUCTORI.PRENUME%TYPE, id_station CONDUCTORI.COD_GARA%TYPE, salary CONDUCTORI.SALARIU%TYPE, job_name VARCHAR2(30));
    
    TYPE employees_table IS TABLE OF record_employees;
    
    t employees_table := employees_table();
    
    PROCEDURE parser_conductori;
    
    PROCEDURE parser_controlori;
    
    FUNCTION get_avarage RETURN NUMBER;
    
    FUNCTION get_counter RETURN NUMBER;
    
END cerinta14;
/

CREATE OR REPLACE PACKAGE BODY cerinta14 AS
    
    -- preia conductorii
    PROCEDURE parser_conductori IS
        r record_employees;
        CURSOR c IS
        SELECT ID_CONDUCTOR FROM CONDUCTORI;
    BEGIN
        FOR emp IN c LOOP
            SELECT NUME, PRENUME, COD_GARA, SALARIU, 'Conductor'
            INTO r.last_name, r.first_name, r.id_station, r.salary, r.job_name
            FROM CONDUCTORI WHERE ID_CONDUCTOR = emp.ID_CONDUCTOR;
            
            t.EXTEND;
            
            t(t.LAST) := r;
            
        END LOOP;
    END parser_conductori;
    
    -- preia controlorii
    PROCEDURE parser_controlori IS
        r record_employees;
        CURSOR c IS
        SELECT ID_CONTROLOR FROM CONTROLORI;
    BEGIN
        FOR emp IN c LOOP
            SELECT NUME, PRENUME, COD_GARA, SALARIU, 'Controlor'
            INTO r.last_name, r.first_name, r.id_station, r.salary, r.job_name
            FROM CONTROLORI WHERE ID_CONTROLOR = emp.ID_CONTROLOR;
            
            t.EXTEND;
            
            t(t.LAST) := r;
            
        END LOOP;
    END parser_controlori;
    
    
    -- calculeaza media salariilor
    FUNCTION get_avarage RETURN NUMBER IS
        salary NUMBER := 0;
    BEGIN
        FOR sl IN t.FIRST .. t.LAST LOOP
            salary := salary + t(sl).SALARY;
        END LOOP;
        
        salary := ROUND(salary/t.COUNT);
        
        RETURN salary;
    END get_avarage;
    
    
    -- numarul de angajati care au salariul peste medie
    
    FUNCTION get_counter RETURN NUMBER IS
        counter NUMBER := 0;
    BEGIN
        FOR emp IN t.FIRST .. t.LAST LOOP
            IF (t(emp).salary > get_avarage)
            THEN counter := counter +1;
            END IF;
        END LOOP;
        RETURN counter;
    END get_counter;
    
END cerinta14;
/

EXECUTE cerinta14.parser_conductori;

EXECUTE cerinta14.parser_controlori;

SELECT cerinta14.get_counter FROM DUAL;

DROP PACKAGE cerinta14;

        

            
SELECT tr.ID_TREN , COUNT(*) AS nr_utilizari
FROM TRENURI tr
JOIN TRASEE trs ON tr.ID_TREN = trs.ID_TREN 
JOIN GARI gr ON (gr.COD_SIRUES = trs.COD_GARA_PLECARE OR gr.COD_SIRUES = trs.COD_GARA_SOSIRE)
JOIN ORASE ors ON gr.COD_POSTAL_ORAS = ors.COD_POSTAL
JOIN REGIUNI rg ON rg.ID_REGIUNE = ors.ID_REGIUNE
WHERE UPPER(rg.NUME) LIKE UPPER('Moldova')
GROUP BY tr.ID_TREN
ORDER BY nr_utilizari DESC
FETCH FIRSt 1 ROWS ONLY;
        

    
    
    







