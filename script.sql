drop table programare;
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
    id_client    int           primary key ,
    id_card      int           null,
    puncte       int default 0 null,
    nume         varchar(20)   not null,
    prenume      varchar(20)   not null,

    # 15 ca sa incapa si prefixul, daca e un strain
    telefon      varchar(15)   null,
    constraint check_telefon
    check (telefon not like '[A-Za-z]%'),

    mail         varchar(30)   null,
    constraint check_mail
        check (mail like '%_@__%.__%'),

    data_nastere date          null,
    unique (id_card)
);

create table oferte
(
    id_oferta     int                              primary key,
    descriere     varchar(30) default ''           not null,
    data_expirare date        default '3000-12-31' null,
    puncte        int         default 0            null
);

create table salon
(
    id_salon int                    primary key,
    nume     varchar(15) default '' not null,
    adresa   varchar(30) default '' not null,

    telefon  varchar(15)            null,
    constraint salon_check_telefon
        check (telefon not like '[A-Za-z]%')
);

create table angajati
(
    id_angajat int                     primary key,
    nume       varchar(20) default ''  not null,
    prenume    varchar(15) default ''  not null,

    mail       varchar(20)             null,
    constraint angajati_check_mail
        check (mail like '%_@__%.__%'),

    telefon    varchar(15)             not null,
    constraint angajati_check_telefon
        check (telefon not like '[A-Za-z]%'),

    id_salon   int                     null,
    constraint id_salon
        foreign key (id_salon) references salon (id_salon) on delete cascade
);

create table serviciu
(
    id_serviciu int                     primary key,

    pret        int  default 0          not null,
    constraint serviciu_check_pret
        check (pret > 0),

    durata      time default '01:00:00' not null
);

create table programare
(
    id_programare   int      primary key,

    data_programare datetime null,
    date_efectuata  datetime null,
    id_angajat      int      not null,
    id_client       int      not null,
    id_serviciu     int      not null,
    constraint Programare_angajat_id_angajat_fk
        foreign key (id_angajat) references angajati (id_angajat) ,
    constraint Programare_clienti_id_client_fk
        foreign key (id_client) references clienti (id_client) on delete cascade ,
    constraint Programare_serviciu_id_serviciu_fk
        foreign key (id_serviciu) references serviciu (id_serviciu) on delete cascade
);

create table stoc
(
    id_stoc   int                    primary key,
    descriere varchar(50) default '' not null
);

create table produse
(
    cod_bare     int                 primary key,
    nr_prod      int      default 0  null,
    nume         char(10) default '' not null,
    pret         int      default 0  not null,
    pret_vanzare int      default 0  not null,
    id_stoc      int                 not null,

    constraint id_stoc_fk
        foreign key (id_stoc) references stoc (id_stoc) on delete cascade
);

# Nu sterg tabelul cos, pentru controalele fiscale.
create table cos
(
    id_cos    int           primary key,
    id_client int           not null,
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
    nr_prod int default 1 not null,

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
    nr_prod int default 0 not null,
    id_stoc int not null,
    cod_bare int not null,
    primary key (id_stoc, cod_bare),
    constraint produse_in_stoc_id_stoc_fk
        foreign key (id_stoc) references stoc (id_stoc) on delete cascade,
    constraint produse_in_stoc_cod_bare_fk
        foreign key (cod_bare) references produse (cod_bare) on delete cascade
);
