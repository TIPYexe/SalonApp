drop table programari;
drop table nr_prod;
drop table produse_in_stoc;
drop table cos;
drop table oferte_disponibile;
drop table meserie;
drop table clienti;
drop table angajati;
drop table oferte;
drop table produse;
drop table salon;
drop table serviciu;
drop table stoc;


create table clienti
(
    id_client int auto_increment,
    primary key (id_client),

    id_card int null,
    puncte int null,
    nume varchar(20) not null,
    prenume varchar(20) not null,

    # 15 ca sa incapa si prefixul, daca e un strain
    telefon varchar(15) null,
    constraint check_telefon
    check (telefon not like '[A-Za-z]%'),

    mail varchar(30) null,
    constraint check_mail
        check (mail like '%_@__%.__%'),

    data_nastere date null,
    unique (id_card)
);

create table oferte
(
    id_oferta int auto_increment,
    primary key (id_oferta),

    descriere varchar(100) not null,
    data_expirare date null,
    puncte int not null
);

create table salon
(
    id_salon int auto_increment,
    primary key (id_salon),

    nume varchar(15) not null,
    adresa varchar(30) not null,

    mail varchar(20) null,
    constraint salon_check_mail
        check (mail like '%_@__%.__%'),
    telefon varchar(15) null,
    constraint salon_check_telefon
        check (telefon not like '[A-Za-z]%')
);

create table angajati
(
    id_angajat int auto_increment,
    primary key (id_angajat),

    nume varchar(20) not null,
    prenume varchar(15) not null,

    mail varchar(20) null,
    constraint angajati_check_mail
        check (mail like '%_@__%.__%'),

    telefon varchar(15) not null,
    constraint angajati_check_telefon
        check (telefon not like '[A-Za-z]%'),

    id_salon int null,
    constraint id_salon
        foreign key (id_salon) references salon (id_salon) on delete cascade
);

create table serviciu
(
    id_serviciu int auto_increment,
    primary key (id_serviciu),

    pret int not null,
    constraint serviciu_check_pret
        check (pret > 0),

    #durata e in minute
    durata int not null
);

create table programari
(
    id_programare int auto_increment,
    primary key (id_programare),

    data_programare datetime default NOW() not null,
    date_efectuata datetime null,

    id_angajat int not null,
    id_client int not null,
    id_serviciu int not null,
    constraint programari_angajat_id_angajat_fk
        foreign key (id_angajat) references angajati (id_angajat) ,
    constraint programari_clienti_id_client_fk
        foreign key (id_client) references clienti (id_client) on delete cascade ,
    constraint programari_serviciu_id_serviciu_fk
        foreign key (id_serviciu) references serviciu (id_serviciu) on delete cascade
);

create table stoc
(
    id_stoc int auto_increment,
    primary key (id_stoc),

    descriere varchar(100) not null
);

create table produse
(
    cod_bare int primary key,

    nr_prod int null,
    nume char(10) not null,
    pret int not null,
    pret_vanzare int not null
);

# Nu sterg tabelul cos, pentru controalele fiscale.
create table cos
(
    id_cos int auto_increment,
    primary key (id_cos),
    id_client int not null,
    constraint Cos_clienti_id_client_fk
        foreign key (id_client) references clienti (id_client)
);

create table oferte_disponibile
(
    id_oferta int,
    id_card int,
    primary key (id_card, id_oferta),
    constraint oferte_disponibile_oferta_fk
        foreign key (id_oferta) references oferte (id_oferta) on delete cascade,
    constraint oferte_disponibile_card_fk
        foreign key (id_card) references clienti (id_card) on delete cascade
);

create table meserie
(
    id_angajat int,
    id_serviciu int,
    primary key (id_angajat, id_serviciu),
    constraint meserie_id_angajat_fk
        foreign key (id_angajat) references angajati (id_angajat) on delete cascade,
    constraint meserie_id_serviciu_fk
        foreign key (id_serviciu) references serviciu (id_serviciu) on delete cascade
);

create table nr_prod
(
    nr_prod int not null,
    constraint nr_prod_conex
        check ( nr_prod > 0 ),

    id_cos int not null,
    cod_bare int not null,
    primary key (id_cos, cod_bare),

    constraint nr_prod_id_cos_fk
        foreign key (id_cos) references cos (id_cos) on delete cascade,
    constraint nr_prod_cod_bare_fk
        foreign key (cod_bare) references produse (cod_bare) on delete cascade
);

create table produse_in_stoc
(
    nr_prod int not null,

    id_stoc int not null,
    cod_bare int not null,
    primary key (id_stoc, cod_bare),
    constraint produse_in_stoc_id_stoc_fk
        foreign key (id_stoc) references stoc (id_stoc) on delete cascade,
    constraint produse_in_stoc_cod_bare_fk
        foreign key (cod_bare) references produse (cod_bare) on delete cascade
);

insert into salon (nume, adresa, telefon, mail) values ('Katz', '83500 Trailsway Street', '3679496629', 'ablemen0@hexun.com');
insert into salon (nume, adresa, telefon, mail) values ('Gigashots', '9 Anhalt Street', '6487441428', 'zragbourne1@vinaora.com');
insert into salon (nume, adresa, telefon, mail) values ('Skynoodle', '585 Sommers Point', '1494916939', 'aspooner2@blogspot.com');
insert into salon (nume, adresa, telefon, mail) values ('Jayo', '93 Namekagon Alley', '1591003381', 'efitzsimon3@woothemes.com');
insert into salon (nume, adresa, telefon, mail) values ('Shuffletag', '1130 Sundown Court', '7571939370', 'mbehning4@bizjournals.com');
insert into salon (nume, adresa, telefon, mail) values ('Flashpoint', '8734 Corry Lane', '8657395661', 'ssails5@hibu.com');
insert into salon (nume, adresa, telefon, mail) values ('Flipbug', '91 Alpine Center', '3384592918', 'rdewitt6@scientificamerican.com');
insert into salon (nume, adresa, telefon, mail) values ('Wikibox', '89728 Debra Drive', '1501722542', 'ovauls7@nifty.com');
insert into salon (nume, adresa, telefon, mail) values ('Mydo', '89753 Elmside Road', '1424989779', 'htissier8@zdnet.com');
insert into salon (nume, adresa, telefon, mail) values ('Avaveo', '1 Quincy Avenue', '4982822411', 'mduthie9@microsoft.com');

insert into angajati (nume, prenume, telefon, mail) values ('Darcy', 'Anderton', '8958376545', 'danderton0@wikipedia.org');
insert into angajati (nume, prenume, telefon, mail) values ('Olav', 'Gallally', '7403536816', 'ogallally1@sogou.com');
insert into angajati (nume, prenume, telefon, mail) values ('Lark', 'Tomaselli', '2872717486', 'ltomaselli2@yale.edu');
insert into angajati (nume, prenume, telefon, mail) values ('Cinnamon', 'Hazleton', '4356961234', 'chazleton3@pagesperso-orange.fr');
insert into angajati (nume, prenume, telefon, mail) values ('Micah', 'Mashal', '1831332754', 'mmashal4@edublogs.org');
insert into angajati (nume, prenume, telefon, mail) values ('Mitchael', 'Shepeard', '3188398343', 'mshepeard5@army.mil');
insert into angajati (nume, prenume, telefon, mail) values ('Harriett', 'Ravenscraft', '5598384304', 'hravenscraft6@vimeo.com');
insert into angajati (nume, prenume, telefon, mail) values ('Filbert', 'Clowes', '3196376234', 'fclowes7@e-recht24.de');
insert into angajati (nume, prenume, telefon, mail) values ('Gerladina', 'Silverson', '3682264586', 'gsilverson8@nifty.com');
insert into angajati (nume, prenume, telefon, mail) values ('Faunie', 'Gobat', '4963906168', 'fgobat9@sfgate.com');

insert into serviciu (pret, durata) values (95, 58);
insert into serviciu (pret, durata) values (102, 55);
insert into serviciu (pret, durata) values (136, 53);
insert into serviciu (pret, durata) values (132, 67);
insert into serviciu (pret, durata) values (84, 58);
insert into serviciu (pret, durata) values (103, 114);
insert into serviciu (pret, durata) values (110, 101);
insert into serviciu (pret, durata) values (99, 107);
insert into serviciu (pret, durata) values (83, 85);
insert into serviciu (pret, durata) values (140, 105);

#5 fara card si 10 cu card
insert into clienti (nume, prenume, telefon, mail) values ('Glenn', 'Le Quesne', '5321326795', 'glequesne0@usnews.com');
insert into clienti (nume, prenume, telefon, mail) values ('Gusti', 'Labern', '7313540295', 'glabern1@jiathis.com');
insert into clienti (nume, prenume, telefon, mail) values ('Jacky', 'Cammacke', '6152284155', 'jcammacke2@miibeian.gov.cn');
insert into clienti (nume, prenume, telefon, mail) values ('Daisy', 'Killiner', '2589386885', 'dkilliner3@ebay.com');
insert into clienti (nume, prenume, telefon, mail) values ('Aylmar', 'Munehay', '9627320159', 'amunehay4@nifty.com');
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (1, 'Ynez', 'Walkey', 'ywalkey0@redcross.org', '5416820259', '1970-09-22', 47);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (2, 'Chelsy', 'Altoft', 'caltoft1@hugedomains.com', '1019980724', '1979-08-08', 101);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (3, 'Victoria', 'Allcock', 'vallcock2@networksolutions.com', '3781493150', '1979-04-02', 80);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (4, 'Brandise', 'Jendrach', 'bjendrach3@oracle.com', '1801304617', '1980-06-21', 134);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (5, 'Clerc', 'Egginton', 'cegginton4@prlog.org', '7221223429', '1984-05-04', 31);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (6, 'Weber', 'Goadbie', 'wgoadbie5@cisco.com', '6343055942', '1955-11-13', 32);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (7, 'Donnajean', 'Pentelow', 'dpentelow6@foxnews.com', '8435815026', '1970-10-19', 117);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (8, 'Morry', 'Tregale', 'mtregale7@t.co', '8592208545', '1994-07-11', 64);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (9, 'Rancell', 'Gyrgorcewicx', 'rgyrgorcewicx8@biblegateway.com', '7739738301', '1984-12-11', 73);
insert into clienti (id_card, nume, prenume, mail, telefon, data_nastere, puncte) values (10, 'Nickolaus', 'Gumb', 'ngumb9@histats.com', '4061504705', '1964-07-26', 65);

insert into programari (data_programare) values ('2021-02-22');
insert into programari (data_programare) values ('2021-02-04');
insert into programari (data_programare) values ('2021-02-22');
insert into programari (data_programare) values ('2021-01-26');
insert into programari (data_programare) values ('2021-01-20');
insert into programari (data_programare) values ('2020-12-30');
insert into programari (data_programare) values ('2021-01-14');
insert into programari (data_programare) values ('2021-02-01');
insert into programari (data_programare) values ('2021-01-25');
insert into programari (data_programare) values ('2021-02-08');

insert into stoc (descriere) values ('Pellentesque at nulla. Suspendisse potenti.');
insert into stoc (descriere) values ('Proin at turpis a pede posuere nonummy.');
insert into stoc (descriere) values ('Quisque ut erat. Curabitur gravida nisi at nibh.');
insert into stoc (descriere) values ('Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.');
insert into stoc (descriere) values ('Duis aliquam convallis nunc.');
insert into stoc (descriere) values ('Aliquam sit amet diam in magna bibendum imperdiet.');
insert into stoc (descriere) values ('Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
insert into stoc (descriere) values ('Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.');
insert into stoc (descriere) values ('Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.');
insert into stoc (descriere) values ('Nulla tempus.');

insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Oxaliplatin', 55, 85, 169951);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Bite Beauty SPF 15 Sheer Balm', 143, 173, 575738);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Imipramine Hydrochloride', 60, 90, 631696);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Diclofenac Sodium', 239, 269, 142129);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Chelidonium Curcuma Thuja', 119, 149, 665725);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Standardized Grass Pollen, Bermuda Grass', 73, 103, 505636);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('muscle rub', 204, 234, 520601);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Nadolol and Bendroflumethiazide', 212, 242, 224387);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Kroger Cold Sore Treatment', 190, 220, 771758);
insert into produse (nume, pret, pret_vanzare, cod_bare) values ('Metoprolol Tartrate', 204, 234, 156737);

insert into oferte (descriere, data_expirare, puncte) values ('Donec posuere metus vitae ipsum.', '2021-11-08', 42);
insert into oferte (descriere, data_expirare, puncte) values ('Integer a nibh. In quis justo.', '2021-04-12', 12);
insert into oferte (descriere, data_expirare, puncte) values ('Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2021-03-29', 120);
insert into oferte (descriere, data_expirare, puncte) values ('Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2021-06-06', 6);
insert into oferte (descriere, data_expirare, puncte) values ('Donec semper sapien a libero. Nam dui.', '2021-02-14', 137);
insert into oferte (descriere, data_expirare, puncte) values ('Vivamus tortor.', '2021-02-09', 22);
insert into oferte (descriere, data_expirare, puncte) values ('Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-05-18', 40);
insert into oferte (descriere, data_expirare, puncte) values ('Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '2021-08-12', 4);
insert into oferte (descriere, data_expirare, puncte) values ('Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '2021-07-23', 57);
insert into oferte (descriere, data_expirare, puncte) values ('In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2021-02-16', 48);




