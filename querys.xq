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
