--1a
select count(nazov) as count, nazov
from obec
group by nazov
having count(nazov) > 1
order by count desc;

-- --1b
select count(nazov) as count, nazov
from obec
group by nazov
having count(nazov) > 1
order by count desc
limit 1;
--
--
--2
select count(*)
from okres
         inner join kraj k on k.id = okres.id_kraj
where k.nazov = 'Kosicky kraj';

-- 3
select count(*)
from obec
         inner join okres on obec.id_okres = okres.id
         inner join kraj k on k.id = okres.id_kraj
where k.nazov = 'Kosicky kraj';

--4
select nazov
from obec
         inner join populacia p on p.id_obec = obec.id
where rok = '2012'
group by nazov
order by max(p.muzi + p.zeny) desc
limit 1;
--
-- --5
select sum(p.zeny + p.muzi)
from populacia p
         inner join obec on obec.id = p.id_obec
         inner join okres on okres.id = obec.id_okres
where okres.nazov = 'Sabinov'
  and rok = '2012';
--
-- --6
select sum(p.zeny + p.muzi), rok
from populacia p
group by rok
order by rok;

--7
select obec.nazov, p.zeny + p.muzi as population
from obec
         inner join populacia p on obec.id = p.id_obec
         inner join okres okr on okr.id = obec.id_okres
where okr.nazov = 'Tvrdosin'
  and rok = '2011'
order by (p.zeny + p.muzi) asc
limit 2;

--8
select obec.nazov, (p.muzi + p.zeny) as population
from obec
         inner join populacia p on obec.id = p.id_obec
where rok = '2010'
  and (p.muzi + p.zeny) < 5000;


--9
select obec.nazov, p.zeny, p.muzi
from obec
         inner join populacia p on obec.id = p.id_obec
where rok = '2012'
  and p.muzi != 0
  and p.muzi + p.zeny > 20000
order by p.zeny / p.muzi
limit 10;


--10
select kraj.nazov,
       count(obec)          as pocet_obci,
       count(okr)           as pocet_okrecov,
       sum(p.muzi + p.zeny) as population
from populacia p
         inner join obec on obec.id = p.id_obec
         inner join okres okr on okr.id = obec.id_okres
         inner join kraj on okr.id_kraj = kraj.id
where rok = '2012'
group by kraj.nazov;

--11 nespravne
select count(nazov)
from obec
         inner join populacia on obec.id = populacia.id_obec
where rok = '2012'
  and (populacia.zeny + populacia.muzi) < (select (populacia.zeny + populacia.muzi)
                                           from populacia
                                           where rok = '2011')
order by count(nazov);

--12
select count(*)
from obec
         inner join populacia p on obec.id = p.id_obec
where rok = '2012'
  and p.muzi + p.zeny < (select sum(populacia.muzi + populacia.zeny) / count(*)
                         from populacia);
