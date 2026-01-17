---
layout: single
title: Principles of Reactive Programming
date: '2014-01-06 12:00:00'
categories: [mooc, coursera, reactiveProgramming, Rx, Scala]
---
Martin Odersky m.fl. har lige afholdt Coursera kurset Principles of Reactive Programming. Kurset skal se som en opfølger på det meget [populære](http://docs.scala-lang.org/news/functional-programming-principles-in-scala-impressions-and-statistics.html) MOOC kursus Functional Programming Principles In Scala, som Odersky har afholdt 2 gange også på Coursera platformen. Kurset har blandt andet være omtalt på [The Guardian](http://www.theguardian.com/info/developer-blog/2012/nov/02/functional-programming-scala-the-final-push). Formålet med dette blog indlæg er at beskrive, hvad jeg fik ud af at følge kurset.

<!--more-->

I september 2013 blev "[The Reactive Manifesto](http://www.reactivemanifesto.org/)" offentliggjort. Ideen om responsive programmer har vundet mere og mere indpas fx via mobile apps, hvor vi forventer øjeblikkelige svartider. Responsive programmer er blandt andet karakteriseret ved at være:

* skalerbare
* event-drevne
* robuste overfor fejlsituationer (engelsk - resilient)

Underskriverne af manifestet argumenterer for at baggrunden for software udvikling har ændret sig, da

* mængden af data vokser
* mobile apps forventes at svare hurtigt
* krav til oppe tid 24/7

hvilket stiller nye krav til de principper som vi lægger til grund for software udvikling. Hvis du vil vide mere om baggrunden for manifestet, så kan du læse mere [her](http://www.typesafe.com/blog/why_do_we_need_a_reactive_manifesto%3F) i et blogindlæg hos Typesafe.

Umiddelbart kommer jeg til at tænke på Node.js, når jeg læser manifestet. Node.js er både skalerbar og event-dreven (men i sig selv ikke resilient) og er på kort tid blevet meget populær. Måske ved at være klassens nye frække dreng som udfordrer eksisterende webservere ved at have fokus på ikke-blokerede event-drevet I/O. Tiden og programmeringssprogene er for alvor moden til asynkron programmering. I C# 5.0 har vi fået `async` og `await`, og Scala har fra version 2.10 fået `Future`s og `Promise`s for blot at nævne et par eksempler.

Traditionelt har man fået applikationer og servere til at skalere ved dels at investere i hurtigere hardware og / eller omskrivning af programmer så dele af programmet kan udføres parallelt (fremfor sekventielt).

Vi er nået til punkt, hvor man ikke længere altid kan forbedre performance ved blot at købe hurtigere hardware, og derfor ses en anden tendens, hvor man skalerer systemer ved at bruge flere computere samtidigt, som så arbejder sammen om at løse en given opgave. Dette sætter nye krav til softwaresystemerne som i højere grad skal kunne håndtere fejlsituationer som følge at fx software, hardware eller netværksfejl. The Reactive Manifesto argumenterer for, at man bruger en arkitektur, hvor løst koblede systemer kommunikerer via beskeder (læs fx events). Hvis du kender til den klassiske bog Design Patterns - Elements of Reusable Object-Oriented Software husker du sikkert Observer design mønsteret. Man kan med rette spørge om dette 

Observer er baseret på håndtering af events via såkaldte event handlers. Når man registrerer ens interesse i at blive notificeret ved en bestemt situation, så giver man også en callback funktion, som så bliver kaldt, når begivenheden indtræffer. Men hvad nu, hvis man har flere callback funktioner som skal kaldes samtidigt eller man fx ønsker at filtrere i de events. Det kan lade sig gøre i et traditionelt Observer mønster, men det giver ofte anledning til kode som er vanskelig at læse og forstå. Mange bruger betegnelsen callback helvede. I stedet ønsker man et programmeringsparadigme, hvor events optræder som første klasses objekter. Konceptuelt kan man her tænke på funktioners virkemåde i funktionsprogrammeringssprog, hvor funktioner også er første klasses objekter. Vi skal i næste afsnit se nærmere på Reactive Extensions som er et framework, der adresserer ovennævnte problemstillinger.

### Asynkron programmering og Reactive Extensions  (Rx) 
Asynkron programmering har traditionelt været forbundet med at registrere en callback funktion, som så blev kaldt, når det asynkrone kald var udført. I et sprog som C# gav det ofte temmelig uoverskuelig kode, hvor det var svært at læse flowet omkring det asynkrone kald. C# 5.0 har fået `async` og `await`, som har gjort det betydeligt lettere og kodemæssigt pænere at skrive asynkrone kald.

Scala har fra version 2.10 fået `Future`s. Hvis man kalder nedenstående funktion `f` vil funktionen returnere øjeblikkeligt selvom det tager lang tid at kalde `getRecentPosts` funktionen som potentielt afføder et netværkskald. Når `getRecentPosts` så returnerer bliver `onComplete` metoden kaldt, og hvis kaldet er gået godt skrives beskederne ud. I tilfælde af fejl kommer en fejlbesked.

{% highlight scala %}
val f: Future[List[String]] = future {
  session.getRecentPosts
}

f onComplete {
  case Success(posts) => for (post <- posts) println(post)
  case Failure(t) => println("An error has occured: " + t.getMessage)
}
{% endhighlight %}

Ud fra dette eksempel er det ikke oplagt, at man på denne måde med callback funtionen `onComplete` kan konstruere eksempler, hvor flere callback funktioner kædes sammen eller filtreres med dette kan opnås med en teknik kendt som [For-Comprehensions](http://docs.scala-lang.org/overviews/core/futures.html).

Det oprindelige observer design mønster har nogle væsentlige mangler. Nemlig mulighederne for at

* fortælle abonnenterne, at der er sket en fejl og
* signalere, at der ikke er flere beskeder.

Derudover bygger observer mønstret på en simpel callback/event model, når man tilmelder sig 

Frameworket Rx, oprindeligt udviklet af Microsoft, kan ses som en udvidet model, der løser førnævnte problemstillinger. Rx er nu open-source og er senere blevet tilgængelig i en JVM version som kan bruges på fx Java og Scala. JVM version blev udviklet af NetFlix.

Lad os starte med det klassiske Hello World eksempel her i Rx/C#

{% highlight csharp %}
class Program
{
  public static void Main (string[] args)
  {
    var xs = "Hello, World!".ToObservable();
    xs.Subscribe(x => Console.Write(x));
    Console.ReadLine ();
  }
}
{% endhighlight %}

Strengen "Hello, World!" erklæres til at være Observable og man kan derfor abonnere på den. Det er også muligt at filtrere, således at man kun får visse beskeder fra "Hello, World!" stregen. F.eks. kan vi vælge kun at modtage de første 5 beskeder

{% highlight csharp %}
var xs = "Hello, World!".ToObservable().Take(5);
{% endhighlight %}

får man kun skrevet "Hello".

Lad os se på et mere avanceret eksempel, hvor man for alvor udnytter at events kan filtreres. Bart De Smet var med til at udvikle Rx for Microsoft og i denne [video](http://channel9.msdn.com/Events/TechEd/Europe/2012/DEV413) viser han et eksempel, hvor man i en GUI tekstboks søger på internettet med indholdet af tekstboksen som søgestreng

{% highlight csharp %}
IObservable input = Observable.FromEventPattern(textbox, "TextChanged")
  .Select(_ => textbox.Text)
  .Throttle(TimeSpan.FromSeconds(0.5))
  .DistinctUntilChanged();
{% endhighlight %}

Her bliver den sædvanlige `TextChanged` event fra en tekstboks konverteret til en `Observable`. Dernæst vælges indholdet af tekstboksen, hvor efter man med `Throttle` sørger for kun at vælge teksten hver 1/2 sekund (der er ikke grund til at iværksætte en internet søgning kontinuert). Til sidst bruges `DistinctUntilChanged` til at sikre, at man ikke foretager den samme forespørgsel flere gange. Alt dette i en linie kode udtrykt på en meget genkendelig LINQ-agtig måde.

Ovenstående eksempler yder på ingen måde retfærdighed overfor Rx i forhold til at den funktionalitet som Rx tilbyder. Men dette er ikke en introduktion til Rx, og jeg vil henvise til den velskrevne online bog [Introduction to Rx](http://www.introtorx.com/) for flere detaljer og eksempler.

De to velkendte design mønstre Iterator og Observer kan forstås som måder hvorpå man enten selv aktivt spørger efter data eller passivt får data.  På engelsk bruges betegnelserne pull og push. Skematisk kan dette fremstilles som

<table>
	<tr>
		<td></td>
		<td>Enkelt returværdi</td>
		<td>Multiple returværdier</td>
	</tr>
	<tr>
		<td>Pull / Synkront</td>
		<td>T/Try[T]</td>
		<td>Iterable[T]</td>
	</tr>
	<tr>
		<td>Push / Asynkront</td>
		<td>Future[T]</td>
		<td>Observable[T]</td>
	</tr>
</table>

Meijer gik også i detaljer med et matematisk argument for at `Iterable` og `Observable` i en vis forstand kan ses som duale.  Jeg har fundet denne [artikel](http://codebetter.com/matthewpodwysocki/2009/11/03/introduction-to-the-reactive-framework-part-ii/) som beskriver dette nærmere.

### Akka
En af udfordringer for multitrådet programmering i et objekt orienteret sprog er at objekter har en tilstand, og hvis flere tråde samtidig tilgår denne tilstand, så kan det gå galt. Funktionsprogrammering undgår denne problemstilling ved ikke at have tilstand. Men funktionsprogrammering er nok ikke svaret på alle problemer opstået af multitrådet programmering, da der findes domæner og problemstillinger som er umulige at modellere uden tidstand.

I et objekt orienteret sprog kan man kan godt opfatte de offentlige metoder på en klasse som en måde at sende en besked til klassen på. Men hvis flere kalder den samme metode samtidig er der ingen garanti for hvordan klassens tilstand opdateres. 

Akka er Scalas svar på Actor modellen som fx også findes i sproget Erlang udviklet af Joe Armstrong hos svenske Erichson. Hos Ericson blev Erlang brugt til at udvikle den legendarisk AXD301 switch som har en nærmest uvirkelig oppetid eller for at citere [Armstrong](http://pragprog.com/articles/erlang): 

> The AXD301 has achieved a NINE nines reliability (yes, you read that right, 99.9999999%). Let’s put this in context: 5 nines is reckoned to be good (5.2 minutes of downtime/year). 7 nines almost unachievable ... but we did 9.

Man kan tænke på en Actor som en klasse med tilstand men tilstanden kan kun ændres via beskeder sent til klassen. En Actor har en postkasse som den modtager beskeder i og herefter behandles beskeder sekventielt. Når beskeden er modtaget i postkassen returneres øjeblikkeligt, dvs kald til en Actor er asynkrone.

Allerede nu kan vi se, at Akka passer godt ind i reactive programmeringsparadigme. Beskederne kan opfattes som events, og da beskeder behandles asynkront er de ikke-blokerende. Vi skal senere se, at Akka også har en robust fejlhåndteringsmodel.

En Actor i Akka er karakteriseret ved at

* have et unikt Id
* altid at have en forælder
* have tilstand som ikke kan deles
* kun at kunne kommunikere  via asynkrone beskeder

Nedenstående lettere modificerede eksempel er taget fra Akkas [website](http://akka.io/) og kan afvikles på platformen [Typesafe Activator](http://typesafe.com/platform/getstarted), som i øvrigt er en hurtig måde at komme i gang med Akka på.

{% highlight scala %}
import akka.actor.{ ActorRef, ActorSystem, Props, Actor }
import scala.concurrent.duration._

case class Greeting(who: String)

class GreetingActor extends Actor {
  def receive = {
    case Greeting(who) ⇒ println("Hello " + who)
  } 
}

object HelloAkkaScala extends App {
  val system = ActorSystem("MySystem")
  val greeter = system.actorOf(Props[GreetingActor], name = "greeter")
  greeter ! Greeting("Charlie Parker")  
}
{% endhighlight %}

En Actor er defineret ved

{% highlight scala %}
type Receive = PartialFunction[Any, Unit]
trait Actor {
  def receive: Receive
  ...
}
{% endhighlight %}

Dvs en Actor er dybest set interface som har en `receive`metode, der kan tage alt som argument og ikke returnerer noget.

I eksemplet er der brugt en case klasse som en bekvem måde at definere mulige beskeder på. `GreetingActor` vil altså når den modtager en `Greeting` besked indeholdende en streng  "Hello" sammensat med strengen. Som nævnt ovenfor har alle Actors en forælder. Hvis man ikke eksplicit angiver en forælder bliver `ActorSystem`'et forælder. I Scala kan man bruge operatoren `!` til at sende beskeder, så linien

{% highlight scala %}
greeter ! Greeting("Charlie Parker")
{% endhighlight %}

skal læses som send beskeden `Greeting("Charlie Parker")` til den Actor, der er erklæret som `greeter`.

Hvordan håndteres fejlsituationer for en Actor. Lad os udvide eksemplet ovenfor med en besked til heltalsdivision. 

{% highlight scala %}
import akka.actor.{ ActorRef, ActorSystem, Props, Actor }
import scala.concurrent.duration._

case class Greeting(who: String)
case class Divide(x: Int, y:Int)

class GreetingActor extends Actor {
  def log(message: String) { println(s"${self.path.name}: $message") }
  
  def receive = {
    case Greeting(who) ⇒ println("Hello " + who)
    case Divide(x, y) ⇒ log(s"$x / $y = ${x / y}")
  } 
  
  override def preRestart(reason: Throwable, message: Option[Any]) { 
    log(s"preRestart ($reason, $message)")
  }

  override def postRestart(reason: Throwable) { 
    log(s"postRestart ($reason)") }      
  }

object HelloAkkaScala extends App {
  val system = ActorSystem("MySystem")
  val greeter = system.actorOf(Props[GreetingActor], name = "greeter")
  greeter ! Greeting("Charlie Parker")  
  greeter ! Divide(1, 0)
  greeter ! Greeting("Charlie Parker")  
}
{% endhighlight %}

Hvad sker der når man sender beskeden `Divide(1, 0)`? En Actor forælder fungerer også som supervisor. Det er en Actors supervisor som afgør præcis hvad der sker i en fejlsituation. Som default vil supervisor forsøge at genstarte Actor hvilket implicit gør at Actor tilstanden genskabes til den oprindelige tilstand. Der er flere muligheder som er beskrevet i detaljer i ekstra kapitlet til bogen Seven Concurrency Models in Seven Weeks. Kapitlet om Akka kan gratis downloades [her](http://media.pragprog.com/titles/pb7con/Bonus_Chapter.pdf). Her kan man også se en mere komplet oversigt over den livscyklus model som gælder for en Actor.

I forbindelse med genstart bliver metoderne `preRestart` og `postRestart` kaldt, og dem kan man overskrive for ens konkrete Actor implementering.

Skematisk ser ovenstående eksempel sådan her ud:
![center](/images/akkaLifeCycleModel.png)
Denne slide er taget fra kursus videoen "Failure Handling with Actors".

I stil med Erlang benytter Akka en "let is crash" model, hvor man i stedet for en meget defensiv programmeringsstil simpelthen lader processor (læs Actors) gå ned. Det er her efter overladt til supervisor og Actor livscyklus modellen at tage stilling til, hvad der efterfølgende sker.

### Obligatoriske opgaver
De obligatoriske opgaver er en vigtig del af kurset. I uge 3 hed opgaven NodeScala og gik ud på at implementere en simpel asynkron HTTP server ved brug af Scala `Future`s. Så når jeg kom til at tænke på Node.js i begyndelsen af kurset, så var det en ganske sjov opgave selv at implementere en webserver i stil med Node.js.

Kursets sidste opgave strækte sig over flere uger, og opgaven var at implementere en simpel replikeret key-value database. Mange af principperne bag løsningen kunne genkendes fra MongoDB (som jeg tidligere har skrevet om her på [bloggen]({% post_url 2013-12-15-mongodb %})). Der var blandt andet en primær replika hvortil man kunne opdatere data samt en række sekundære replika hvorfra der kun var læseadgang. I lighed med MongoDB var der også et delsystem som afgjorde om en server skulle være primær eller sekundær server.

### Afslutning og konklusion
Principles of Reactive Programming er et virkeligt anbefalelsesværdigt Coursera kursus. Det er ikke helt så godt som Functional Programming Principles In Scala kurset, men det er også et exceptionelt godt kursus. Martin Odersky er en dygtig underviser og formidler, men den del af kurset, hvor han underviser, er ikke kursets mest spændende del, da der er en del overlap fra Scala kurset.

Erik Meijer kender Reactive Extension frameworket rigtig godt. Han har jo trods alt også være med til at designe og udvikle det mens han stadig arbejdede for Microsoft. Meijers evner som underviser er dog ikke overbevisende. Undervisningsmaterialet bliver for rodet, og der gives ikke eksempler på kode i sammenhæng som rent faktisk kan kompilere.

Der er ingen tvivl om at Roland Kuhn kan stoffet. Kuhn er tech lead hos Akka, så alt andet ville også være overraskende. Kuhn er også en fremragende underviser og formidler. 

### Henvisninger
**Diverse websites**

[Rx på CodePlex](https://rx.codeplex.com/)

[JVM version af Rx](https://github.com/Netflix/RxJava)

[Introduction to Rx](http://www.introtorx.com/)

[Functional Reactive Programming in the Netflix API](http://www.infoq.com/presentations/Netflix-API-rxjava-hystrix)

[Functional Reactive in the Netflix API with RxJava](http://techblog.netflix.com/2013/02/rxjava-netflix-api.html)

[I følge Gartner er Reactive Programming på vej frem](https://www.gartner.com/doc/2560015)

[Reactive Programming as an Emerging Trend](http://www.infoq.com/news/2013/08/reactive-programming-emerging)

[Functional Reactive Programming](http://fsharpforfunandprofit.com/posts/concurrency-reactive/)

**Bøger**

[Effective Akka](http://amzn.com/1449360076)

[Akka Concurrency](http://amzn.com/0981531660)

[Akka in Action](http://amzn.com/1617291013)