(:Primera query simple. Nombres de los paises que terminan por la letra 'i':)

//country/name[ends-with(., 'i')]

(: Query simple. Nombre de los países en los que la natalidad permite el reemplazo generacional :)
//country[@population_growth>2.1]/name

(: Query compleja anidada. Devolver países con más de 10 provincias, teniendo como atributos
el nombre del país, número de provincias y la población promedia de estas. Dentro de estos
habrá elementos hijos con el nombre de cada provincia, siendo estos elementos ordenados
por su población.:)

for $c in //country
let $name:=$c/name
let $avg_pro_pop:=avg($c/province/@population)
let $pro_count:=count($c/province)
where $pro_count>10
return <country name="{$name}" prov_number="{$pro_count}" avg_prov_pop="{$avg_pro_pop}">{
  for $province in $c/province
  order by $province/@population descending
  return <province>{data($province/@name)}</province>
}</country>


(:Primera query compleja anidada. Devuelve las ciudades cuyo nombre empieza por A y tienen más de 200000 habitantes en
elementos 'population' con el nombre de la ciudad como atributo y su población como contenido:)

for $p in //province/city
let $city:=$p/name
where $p/population>200000
and $city[starts-with(.,'A')]
    return <population city="{$city}">{
      for $b in $p/population
      return $b/text()
    }</population>

(:Primera consulta FLWOR. Obtener los países con menos población del mundo. Mostraremos aquellos que tengan menos de 100.000 habitantes:)

for $c in //country
let $name:=$c/name
where $c/population<100000 and $c/name!='Holy See'
order by $c/population ascending
    return <population country="{$name}">{
      for $p in $c/population
      return $p/text()
    }</population>

(:Segunda consulta FLWOR. Obtener aquellos países en los que haya mayor diversidad religiosa. Mostraremos aquellos en los que haya más de 5 religiones:)

for $c in //country
let $name:=$c/name
where count($c/religions)>5
return <religions country="{$name}">{count($c/religions)}</religions>
