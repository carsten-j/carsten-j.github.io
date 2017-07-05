---
layout:    page
title:     Kolofon
permalink: /kolofon/
---
Dette er min 4. blog. Den første var en ikke teknisk blog baseret på WordPress. Og hvis jeg skal være ærlig, så fik jeg vist kun skrevet et eneste indlæg på denne blog.

Dette er tredje version af min tekniske blog. Jeg startede ud med [Ghost](https://ghost.org/), men blev hurtig træt af den manglende integration med versionsstyring og at man skulle have en (SQLite) database bag bloggen. Mit blog var hosted hos DigitalOcean, og jeg var også træt af selv at skulle vedligeholde min Ubuntu boks hos dem.

Svaret lå i en statisk genereret blog og valget faldt på [Octopress](http://octopress.org/). Ud med databasen og ind med Github integration og hosting via GitHub [Pages](https://pages.github.com/).

Jeg har en backend udvikler baggrund og blev aldrig rigtig fortrolig med selv at ændre på layout i Octopress.

Videre til [Jekyll](http://jekyllrb.com/). Tredje udgave af min blog er baseret på Jekyll og [Vida](https://github.com/syaning/vida) temaet. Frontend og layout virker nemmere at gå til. Jeg har modificeret Vida temaet med udgangspunkt i [Tufte CSS](http://www.daveliepmann.com/tufte-css/) projektet.

Med Jekyll er alt kode i et repository og det er derfor meget lettere at tilføje nye blogindlæg fra iPad ved brug af den fantastiske [Editorial](http://omz-software.com/editorial/) app.

Når jeg skriver indlæg på min Mac er det typisk med hjælp fra [Atom](https://atom.io), [knitr](http://yihui.name/knitr/), [Pandoc](http://pandoc.org/) og [LaTeX](https://tug.org/mactex/). Nogle få sider med masser af R kode er genereret på denne [måde](http://www.jonzelner.net/jekyll/knitr/r/2014/07/02/autogen-knitr/).

Lige nu er min favorit font [Fira Sans](https://typekit.com/fonts/fira-sans).

Alle commits bliver checket med [Travis CI](https://travis-ci.org/).
