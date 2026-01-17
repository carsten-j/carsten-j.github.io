---
layout: single
title: "Mandelbrots mængde og MANDELZOOM"
date: 2015-08-22 08:34:01 +0200
categories: F# mandelbrot fraktaler mandelzoom
---

I august 1985 udgaven af Scientific America var der et billede af Mandelbrots mængde på forsiden af bladet.

<!--more-->

## 25 års jubilæum
Det er i denne måned 25 år siden, og hvis man læser den oprindelige artikel [(findes som PDF download fra denne side)](http://www.scientificamerican.com/article/mandelbrot-set/) vil man hurtigt opdage hvor ufatteligt meget der er sket med regnekraften i computere i den periode. Det er i sig selv ikke overraskende, men man kan alligevel i godt i hverdagen "glemme" hvor hurtigt udviklen er gået!

![center](/images/scientificAmericaAugust1985.jpeg)

Jeg blev selv opmærksom på fraktaler (vist nok) første gang i 1986 i forbindelse med en udgave af Danmarks Radios videnskabsprogram [Hvælv][1], som havde [Tor Nørretranders](https://twitter.com/norretranders) som vært. Det var før jeg fandt ud af, at man kan læse matematik på universitetet, og jeg var vist mere fascineret af de uendelig smukke billeder end af selve matematikken bag.

Udvikling i computer regnekraft er gået rigtig hurtig. I artiklen omtales 400 x 400 = 160.000 beregninger som værende en beregningstung opgave. I dag er dette en både hurtig og triviel opgave for selv en smartphone.
Min oprindelige plan var at ledsage dette blogindlæg med en "moderne" implementering af algoritmen bag Mandelbrots mængde. Men efter at have lavet en hurtig søgning med Google opgav jeg denne tanke. Det er så populær en algoritme at man kan finde nærmest ALT i forvejen: parallelle version, GPU implemeteringer og mere eksotiske version baseret på Erlangs actor model.

## MANDELZOOM
Artiklen i Scientific America referer til et program kaldet MANDELZOOM, som er blevet brugt til at generere de billeder der illustrerer artiklen.
I stedet for en "moderne" implementering af algoritmen, vil jeg har forsøge at genskabe den oprindelig funktionalitet i MANDELZOOM. Dette vil vise, at selv en simpel og naiv implementering med dagens regnekraft ikke giver performancemæssige udfordringer.

Jeg vil ikke her gennemgå matematikken bag algoritmen men blot henvise til [Wikipedia artiklen](https://en.wikipedia.org/wiki/Mandelbrot_set) om emnet.

Programmet MANDELZOOM består af tre dele:

    1. Specifikation af det område, hvor man ønsker at bestemme Mandelbrots mængde
    2. En justering af arrayet "pic" som det passer til området valgt i 1.
    3. Hovedalgoritmen hvor det undersøges om de komplekse tal som er bestemt af 1. og 2. tilhører Mandelbrots mængde eller ej. Dette trin er inddelt i fire undertrin:
      3.1. Bestem det komplekst tal svarende til den pixel i billedet som undersøges nu
      3.2. Sæt den komplekse variable z til 0 + 0i og tællevariable count til 0
      3.3. Gentag nu følgende 3 trin indtil enten længden af z er større end 2 eller count er større end 1000:
            3.3.1. z <- z^2 + c
            3.3.2. count <- + 1
            3.3.3. size <- size af z
    4. Tildel en farvekode til pic(m, n) afhængig af hvad count endte med at være i trin 3.3.

Jeg er helt sikker på at MANDELZOOM var implementeret i et imperativt programmeringssprog, men lad os se en simpel implementering i F#.

{% highlight ocaml %}
open System.Drawing
open System.Numerics
open System.Windows.Forms

// Absolute Square function for complex numbers
type System.Numerics.Complex with
  member this.Length = this.Real * this.Real + this.Imaginary * this.Imaginary

// PART ONE: select any square region of the complex plane to be examined.

let title = "Mandelbrot Set"
// Number of rows and columns in the pic array
let rows = 400
let columns = 400
// The coordinates of the southwest corner
let acorner = -2.0 // real part
let bcorner = -1.25 // imaginary part
// Length of each side
let side = 2.5

// PART TWO. adjusts the array pic to match the square of interest

// Distance within the square (determined by the southwest corner and length of each side)
// between each adjacent pixels
let gap = side / float (columns)

let maxIterations = 1000

// PART THREE: the heart of the program. Here a search is made for the
// complex numbers c in the Mandelbrot set, and colors are assigned to the // numbers that are, in a special sense, nearby.

// PART THREE: step 1

// Transforms pixel positions into corresponding complex numbers
let transformPixelPositionToComplexNumber x y =
  new Complex((float) x * gap + acorner, (float) y * gap - (bcorner + side))
// PART THREE: step 3

// A point in the complex plane c belong to the Mandelbrot Set
// if the sequence Z(n+1) = Z(n)^2 + c stays bounded.
// By definition Z(0) = 0
let rec MandelbrotSeq (z : Complex) c iterationNumber =
  if (z.Length > 4.0) then iterationNumber
  else if (iterationNumber = maxIterations) then maxIterations
  else
    let nextValue = z * z + c
    MandelbrotSeq nextValue c (iterationNumber + 1)

// PART THREE: step 4
// Map number of iterations to convergence to a color
let colorMap n maxIterations =
  match n with
  | n when (n < maxIterations && n > 0) -> mandelbrotColorSchemeWikipedia.[n % 16]
  | _ -> Color.FromArgb(0, 0, 0)

/// Returns whether or not the given complex number is in the set to the
/// best possible accuracy we can get from the given number of iterations
let inMandelbrotSet num =
  let res = MandelbrotSeq Complex.Zero num 0
  colorMap res maxIterations

/// Sets up the canvas and generates the set on it
let generateBitMapWithMandelbrotSet (rows : int) (columns : int) =
  let bmp = new Bitmap(rows, columns)
  for m in 0..(rows - 1) do
    for n in 0..(columns - 1) do
      let c = transformPixelPositionToComplexNumber m n
      bmp.SetPixel(m, n, (inMandelbrotSet c))
  bmp
{% endhighlight %}

Med dette script kan man genererer billeder svarende til dem i artiklen. Den komplette udgave finder [her](https://gist.github.com/carsten-j/7827b2fe791726b23c74#file-mandelzoom-fsx).

<center>Mandelbrots mængde</center>
![center](/images/MandelbrotSet.bmp)
<center>Søheste dalen</center>
![center](/images/MandelbrotSeahorseValley.bmp)
<center>Detalje</center>
![center](/images/MandelbrotMoreDetails.bmp)
<center>Mandelbrots mængde er selvsimilær - hvis man zoomer nok genfinder man mængden i sig selv</center>
![center](/images/MandelbrotDetails.bmp)

Funktionen `MandelbrotSeq` er hale rekursiv og giver derfor ikke performance problemer. Jeg forsøgte mig også med en [alternativ version](https://gist.github.com/carsten-j/b97b62c5bc39136426ec#file-mandelzoomalt-fsx) baseret på `seq`, men det var ikke en performancemæssig succes. Jeg vil mene, at denne version er mere intuitiv og lettere at forstå, men performance er ret dårlig. Så jeg forstår det fra diverse StackOverflow indlæg hænger det sammen med, at seq bruger IEnumerator og moveNext for at iterere gennem rækken. Derudover er der nok også boxing/unboxing på spil.

En "produktionsudgave" af algoritmen vil i dag aldrig anvende en sekventiel dobbeltløkke. Det er oplagt at paralleliseret algoritmen fx ved GPU, da alle trin 3.3 er uafhængige. Det skal dog lige her bemærkes at `setPixel` metoden ikke er trådsikker, og at den låser hele bitmap variable ved opdateringer. Det i sig selv giver dårlig performance. Man kan derfor ikke bare erstatte for-løkker med `Parallel.For`.

## Afslutning
Tilbage i 1985 var det på ingen måde alle læserne af artiklen i Scientific America som selv kunne generere sådanne billeder. Men til gengæld kunne man rekvirerer (via brevpost til John H. Hubbard) en brochure og en bestillingsform og dernæst bestille fysiske farvefotos af Mandelbrots mængde. Og kære læser – dette er kun 25 år siden.

Hvis man søger på Mandelbrot + Set giver [Google](https://www.google.com/search?q=mandelbrot+set) en masse hits. Et par af mine favoritter er disse to.

I det [første eksempel](https://thecreatorsproject.vice.com/blog/fractal-formations-imagine-a-futuristic-urban-sprawl) kan man se, hvordan fraktaler har inspireret andre områder end matematikken mens man i det [andet link](https://vimeo.com/1908224) kan tage på en næsten 10 minutter lang "neddykningsoplevelse" i Mandelbrots mængde.

[1] Hvælv: Det kosmiske kaos. DR-TV, 16. maj 1988
