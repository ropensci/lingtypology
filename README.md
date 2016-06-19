# lingtypology

lingtypology provides R with the [Glottolog database (v. 2.7)](http://glottolog.org/) and some more abilities for purposes of linguistic typology. The glottolog database containes the catalogue of languages of the world. This package helps researchers to make a linguistic maps, using philosophy of [The Cross-Linguistic Linked Data project](http://clld.org/), which allows for while at the same time facilitating uniform access to the data across publications.

## Installation

Get the released version from github:

```R
install.packages("devtools")
devtools::install_github("agricolamz/lingtypology")
```

Загружаем библиотеку:
```R
library(lingtypology)
```
погнали... потом переведу

### Базовые функции
В пакет встроены фрагменты базы данных Glottolog: языкоиды (linguoids), ISO коды, координаты, аффилиация и страны распространения языков. Для того, чтобы даставать эту информацию в пакете `lingtypology` есть несколько функций, имеющих структуру дай мне X на основе Y. В результате можно:

- узнать ISO код по названию языка
```R
iso.lang("Adyghe")
[1] "ady"
```
- узнать навзание языка по ISO
```R
lang.iso("ady")
[1] "Adyghe"
```
- узнать страны, в которых говорят на языке
```R
country.lang("Adyghe")
[1] "Turkey (Asia), United States, Israel, Australia, Egypt, Macedonia, France, Russian Federation (Asia), Netherlands, Germany, Syria, Jordan, Iraq"
```
- узнать генеалогическую классификацию языков
```R
aff.lang("Adyghe")
[1] "Abkhaz-Adyge, Circassian"
```
- узнать языки, относящиеся к одной из генеалогических групп
```R
lang.aff("Abkhaz-Adyge")
[1] "Abkhazian" "Abaza"     "Adyghe"   "Kabardian" "Ubykh" 
```
- узнать координаты из базы данных Glottolog
```R
lat.lang("Adyghe")
[1] 44
long.lang("Adyghe")
[1] 39.33
```

### Комбинации функций
Естественно, все эти функции могут принимать не только по одному аргументу, но ивектор аргументов:
```R
iso.lang(c("Adyghe", "Russian"))
[1] "ady" "rus"
```
Кроме того функции можно комбенировать. Например, давайте получим вектор ISO кодов восточно-славянских языков.
```R
iso.lang(lang.aff("East Slavic"))
[1] "bel" "orv" "rue" "rus" "ukr"
```
Здесь в целом от всех функций фокусов ожидать не приходится, единственным исключением является функция `country.lang`. По умолчанию данная функция обработает вектор языков и вернет вектор строк, содержащих списки стран, на которых говорят на языках из запроса. Однако если добавить аргумент `intersection = TRUE`, то функция выдаст страну, где говорят на двух языках из запроса.
```R
country.lang(c("Udi", "Laz"))
[1] "Russian Federation (Asia), Georgia, Azerbaijan, Turkmenistan"   
[2] "Turkey (Asia), Georgia, France, United States, Germany, Belgium"
country.lang(c("Udi", "Laz"), intersection = TRUE)
[1] "Georgia"
```

### Строим карты
Вообще данный пакет задумывался для картографирования, этим в данном пакете занимается функция `map.feature`. Давайте отметим на карте все абхазо-адыгские языки:
```R
map.feature(lang.aff("Abkhaz-Adyge"))
```
Любую точку можно отключить, можно приблизится и удалится. Но никакая типология не мыслит себя без типов. В нашем примере вставим два вектора: в первом перечислим языки, а в следующем признаки:
```R
map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
```
Функция сама сгрупировала все точки по признаку, раскрасила их и пересчитала.

Если ткнуть в точку, то она подсветиться и покажет язык, который данной точкой обозначен. Внутри появившегося окошка доступна ссылка, которая ведет на glottolog. Если же добавить еще один аргумент `popup`, то тогда к кроме названия языка будет отображаться интересующая информация. В нашем примере отображаться будут типы.
```R
map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"))
```
Кроме того имеет смысл добавить заглавие, это делает аргумент `title`:
```R
map.feature(c("Adyghe", "Kabardian", "Polish", "Russian", "Bulgarian"),
c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
c("polysynthetic", "polysynthetic", "fusion", "fusion", "fusion"),
"тип языка")
```
Естественно, совершенно не стоит помнить наизусть, чему какой аргумент соответствует. Всегда имеет смысл вызвать справку или воспользоваться автозаполнением.
