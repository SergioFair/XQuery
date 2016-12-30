(:Primera query simple. Nombres de los paises que terminan por la letra 'i':)

//country/name[ends-with(., 'i')]

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
