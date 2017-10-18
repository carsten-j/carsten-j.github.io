---
layout: post
title: "MAN RAY og algebraisk geometri"
date: 2015-09-04 16:10:20 +0200
categories: matematik geometri kunst
---
<!-- MathJax configuration -->
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML,http://arnabocean.com/javascripts/MathJaxLocal.js">
</script>
<!-- End MathJax Configuration -->

Er en Kummer flade kunst? Skal det nu handle om kunst? Traditionelt ikke et område jeg har beskæftiget mig med her på bloggen. Men tilbage til spørgsmålet i overskriften. Er en Kummer flade kunst? Ikke i sig selv! Men den har tjenst som inspiration for kunstneren Man Ray.

<!--more-->

# Udstilling på Glyptoteket

Man Ray er nok mest kendt som som [surrealistisk](https://da.wikipedia.org/wiki/Surrealisme) kunstfotograf. Men lige nu kan man på [Glyptotektet](https://www.artsy.net/show/glyptoteket-man-ray-human-equations) se udstillingen Man Ray - Menneske // Ligninger med primært oliemalerier.

Inspirationen til disse malerier er hentet i en række matematiske objekter, som Man Ray fandt på Institut Henri Poincaré i Paris i 1934 på opfordring af Max Ernst. Både Man Rays malerier og de originale matematiske objekter, som også er udstillet på Glyptoteket,er yderst inspirende.

I begyndelsen af 1900-tallet havde vi ikke computere og matematisk software til visualisering af matematiske objekter, så jeg forestiller mig, at det ikke har været en triviel opgave at lave en gips model af en Kummer flade som denne:

<img src="http://teachers.phillipscollection.org/sites/default/files/Mathematical%20model%20_03.jpg" width="60%" height="60%" alt="mathematical model"/>

[Modellen](http://teachers.phillipscollection.org/artwork/real-part-function-we) tilhører Brill-Schilling Collection. Institut Henri Poincaré, Paris og fotoet er taget af Elie Posner.

# Algebraisk geometri
Studiet af flader som Kummer fladen hører under området [algebraisk geometri](http://www.denstoredanske.dk/It,_teknik_og_naturvidenskab/Matematik_og_statistik/Regning,_algebra_og_talteori/algebraisk_geometri).

En algebraisk kurve hhv. flade er bestemt ved de punkter i planen hhv rummet, som opfylder ligningen $$f(x,y) = 0$$ for en kurve og $$g(x, y, z) = 0$$ for en flade, hvor $$f$$ og $$g$$ er polynomier. Vi kalder den højeste potens af polynomiet for graden $$d$$ af fladen, så fx beskriver ligningen $$g(x, y, z) = x^2 + y^2 - z^2= 0$$ en flade af grad 2.

# SURFER
I forbindelse med udstillingen har Glyptoteket indrettet en matematisk tankegang, hvor publikum selv kan eksperimentere videre med de matematiske objekter og sammenhængen mellem formler og former. Der er adgang til computer programmet [SURFER](https://imaginary.org/program/surfer), som du også kan downloade og installere på din egen computer.

Lad os starte med to simplere eksempler end Kummer fladen. Generelt er det sådan, at langt de fleste punkter på en algebraisk flade "opfører sig pænt" (lad os ikke gå dybere ind i en præcis matematisk formulering her). Det gælder fx alle punkter på en torus, hvor overfladen er "glat".

![center](/images/torus.png)

Men der er flader med særlige punkter, kaldet singulære, som udviser en helt anden natur. Et eksempel ses i denne dobbelt kegle.

![center](/images/doubleCone.png)

Begge disse flader er genereret med programmet Surfer, og du kan finde kildekoden [her](https://gist.github.com/ffbcc6bf5f135b875552) og [her](https://gist.github.com/6a0e068e5ceb126fc3de).

Hvis vi bruger betegnelsen $$\mu (d)$$ om det maksimale antal singulære punkter en flade af grad $$d$$ kan have, så er det fortsat en uløst matematisk spørgsmål, hvad $$\mu (d)$$ er for $$d > 6$$.

For $$d$$ op til 6 haves følgende værdier:

$$
\begin{array}{c|cccccccc|c}
d & 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & d \\
\hline
\mu (d) \geq & 0 & 1 & 4 & 16 & 31 & 65 &  99 & 168 & \approx \frac{5}{12} d^3\\
\mu (d) \leq & 0 & 1 & 4 & 16 & 31 & 65 & 104 & 174 & \approx \frac{4}{9} d^3 \\
\end{array}
$$

Den tidligere optalte Kummer flade er en flade med grad 4. Den blev studeret af Eduard Kummer i 1875 som også bevidste at $$\mu (4) = 16$$. Det var først i 1996 at man bestemte $$\mu (6) = 65$$.

Der er langt fra statiske gips modeller til denne dynamiske interaktive visualisering:

<div style="text-align:center" markdown="1">
<iframe width="420" height="315" src="https://www.youtube.com/embed/ZOFFueKD_Ec" frameborder="0" allowfullscreen></iframe>
</div>

Kummer fladen er også modelleret med SURFER og koden findes [her](https://gist.github.com/04fa4309c73038fa4db1).

# Du kan nå det endnu
Udstillingen på Glyptoteket vises frem til den 20. september 2015. Hvis du ikke har mulighed for
at besøge udstillingen og/eller mere har lyst til at eksperimentere mere med matematiske figurer, så vil jeg varmt anbefale programmet [Surfer](https://imaginary.org/program/surfer). Jeg blev grebet af mulighederne i Surfer og så gik den aften hurtigt.

Jeg er ikke den eneste som er begejsret. [Information](http://www.information.dk/536073) gav også udstillingen fine ord med på vejen.

Efter sigende forstod Man Ray ikke selv matematikken bag men det forhindrede ham ikke at fascineres af og
eksperimentere videre med formerne. Og det bør heller ikke forhindre dig i at nyde udstillingen.

# Hvorfor er algebraisk geometri relevant?
Algebraisk geometri er langt mere end fascinerende flader. Elliptiske kurver er fx på vej til at blive standard i krypteringsalgoritmer. Algoritmer som blandt andet kan bruges til beskyttelse af dit [privatliv på internettet](http://www.theguardian.com/technology/2013/oct/03/algorithims-google-internet-search-security-onlin).
