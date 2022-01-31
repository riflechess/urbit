# urbit
Projects and code in support of [Urbit](urbit.org).

## TGO-Roller - The-Great-Outdoors chat-bot
This is a chatbot for the urbit group, the-great-outdoors (found on urbit at ~sitsev-lomrem/the-great-outdoors).  It utilizes the [urbit rust chatbot framework](https://github.com/robkorn/urbit-chatbot-framework).

TGO Roller runs as a comet in TGO, and responds to the following commands (rolls the dice):

 - `!rollnp` - Serve link to random National Park
 - `!rollnf` - Serve link to random National Forest
 - `!rollsp` - Serve link to random State Park/monument/recreation/wildlife area

![TGO-Roller Example](https://raw.githubusercontent.com/riflechess/urbit/main/tgo-roller/img/tgo-roller.png)
                      
## Urbit-utils 
In Urbit, there are 256 galaxies (e.g. ~zod), each of which that can spawn 255 stars (e.g. ~tirten) for a total of about 65k stars in the ecosystem.  Each star can generate 65,535 planets (e.g. ~ralber-rosleg or ~pander-normed).  Planets are what a person usually boots and joins the network with.  More details can be found [here](https://urbit.org/blog/the-urbit-address-space).

The relationship between a given star and the planets it is able to spawn is purposefully obfuscated. Through code we can get obtain the list of planets for a given star.  That is what GetPlanets does, utilizing the [Urbit Haskell utilities](https://github.com/urbit/urbit-hob), allowing us to explore potential planet spawns.

`urbit-utils.hs` is one Haskell binary that can be invoked as `getPlanets`, `getPlanetNums`, or `getShipName`

 - getShipName - Get name of "ship" from azimimuth integer.
   ```shell
   ./getShipName 6                  # galaxy
   ~sut
   ./getShipName 666                # star
   ~bintus
   ./getShipName 66666              # planet
   ~ladrem-sitfen
   ./getShipName 66666666           # planet
   ~lasdep-tommes
   ./getShipName 66666666666        # moon from star (lol)
   ~dozsun-dillev-dopzod
   ./getShipName 6666666666666666   # comet
   ~dozdep-tidwyn-magneb-pidfeb
   ```
 - getPlanets - Get list of planets for given star
   ```shell
   ./getPlanets tirten | wc -l     
   65535
   ./getPlanets tirten | tail -n 10
   ~tacryt-patsul
   ~tidtul-dallun
   ~matrym-forwex
   ~malmut-hapryd
   ~livnel-tinfep
   ~hatmun-dandyt
   ~ramfeb-tipnyd
   ~donnub-bondyr
   ~davpyl-salfen
   ~lodmud-pacmul
   ./getPlanets tirten >> /dev/null  0.18s user 0.01s system 93% cpu 0.209 total       # decently fast
   ```
 - getPlanetNums - Get list of azimuth integers from star
   ```shell
   ./getPlanetNums sitsev | wc -l     
   65535
   ./getPlanetNums sitsev | tail -n 10
   673540
   608004
   542468
   476932
   411396
   345860
   280324
   214788
   149252
   83716
   ./getShipName 673540
   ~bidsug-bidlyx
   ./getParent 673540       
   ~sitsev
   ```

`urbit_monitor.sh` Is a simple monitor that will validate your urbit ships/planets are running and text you if they are not.

`showDupes.sh` Is an example of how we can use the above Haskell binaries to further explore the Urbit address space.
 
 As mentioned, each Urbit star can spawn 65,535 planet.  There are a few things that may effect the rarity of a given planet.  One is azimuth number (`getPlanetNums`), though that is generally layered under a fair amount of abstraction.  The second is the planet ["sigil"](https://urbit.org/blog/creating-sigils).  The third is the planet name. 

 Sigils are derived from planet names, and having a "duplicate" planet name (e.g. ~sitsev-sitsev) creates a cool sigil.


|Dupes Count	|% of Total Stars|	Number of Stars|
| ---- | ---- | ---- |
|7	|0.0061|	4|
|6	|0.0473|	31|             
|5	|0.3051|	200|
|4	|1.5197|	996|
|3	|6.1813|	4051|
|2	|18.347|	12024|
|1	|36.828|	24136|
|0	|36.764|	24094|

```
# stars that can spawn six or seven dupe planets
~tacfyl 7, ~woltyr-woltyr ~sognum-sognum ~tarlyr-tarlyr ~naprys-naprys ~milmeb-milmeb ~tolbud-tolbud ~lavsyd-lavsyd
~migtyn 7, ~socteg-socteg ~hilpen-hilpen ~dalpex-dalpex ~libfus-libfus ~banfyn-banfyn ~locmep-locmep ~hacwyd-hacwyd
~togfyn 7, ~pasdys-pasdys ~davpem-davpem ~binmug-binmug ~sammut-sammut ~pildur-pildur ~fonres-fonres ~binlex-binlex
~salsel 7, ~labset-labset ~diblys-diblys ~radsyp-radsyp ~havsun-havsun ~lomnum-lomnum ~radnus-radnus ~moprun-moprun
~halsyd 6, ~wathep-wathep ~larbur-larbur ~tarnut-tarnut ~fodtev-fodtev ~rilteg-rilteg ~mordev-mordev
~habryp 6, ~tonmet-tonmet ~tinret-tinret ~fadtyv-fadtyv ~dacbyn-dacbyn ~hasmer-hasmer ~marsyt-marsyt
~ronrud 6, ~todsem-todsem ~bitteg-bitteg ~dibwer-dibwer ~litryg-litryg ~fabrun-fabrun ~barpun-barpun
~pacsun 6, ~sarsun-sarsun ~forsup-forsup ~namwen-namwen ~tocput-tocput ~dibleb-dibleb ~pasful-pasful
~tocwyx 6, ~saltep-saltep ~matweg-matweg ~halhul-halhul ~widryd-widryd ~doclud-doclud ~sarfeb-sarfeb
~nalbec 6, ~rovmyr-rovmyr ~satrel-satrel ~fopsyr-fopsyr ~sicdem-sicdem ~filryx-filryx ~wicmyn-wicmyn
~sibtux 6, ~ritmev-ritmev ~watlex-watlex ~dotned-dotned ~ribsun-ribsun ~batlud-batlud ~midlyx-midlyx
~fabdun 6, ~riswed-riswed ~mocseg-mocseg ~sabpex-sabpex ~maptyl-maptyl ~panmer-panmer ~litbyn-litbyn
~bosnyl 6, ~millen-millen ~pagpes-pagpes ~lonryc-lonryc ~sivmus-sivmus ~pintud-pintud ~havtyr-havtyr
~ropret 6, ~migtex-migtex ~pacdep-pacdep ~mopfyn-mopfyn ~narben-narben ~dovsym-dovsym ~dibfel-dibfel
~witheb 6, ~migfex-migfex ~laspun-laspun ~tobwyc-tobwyc ~ridpun-ridpun ~modsec-modsec ~sicnus-sicnus
~nimrem 6, ~lostyr-lostyr ~libpub-libpub ~tognec-tognec ~nosdyt-nosdyt ~simdyl-simdyl ~dibper-dibper
~fodnyr 6, ~lospec-lospec ~panwes-panwes ~nilsud-nilsud ~padteb-padteb ~hanpyx-hanpyx ~tapbyn-tapbyn
~tantuc 6, ~loptug-loptug ~bolmed-bolmed ~lappyl-lappyl ~bantud-bantud ~difdus-difdus ~hadleb-hadleb
~sorres 6, ~habput-habput ~ridsev-ridsev ~modsun-modsun ~morres-morres ~parret-parret ~tagtec-tagtec
~mirpex 6, ~fodmet-fodmet ~libhul-libhul ~tiller-tiller ~mactyd-mactyd ~davfun-davfun ~havmev-havmev
~dacdul 6, ~fippeg-fippeg ~ladmyn-ladmyn ~tarmur-tarmur ~sibwes-sibwes ~fodsut-fodsut ~lopdyl-lopdyl
~nalsun 6, ~filnup-filnup ~navfer-navfer ~lonber-lonber ~dopseb-dopseb ~folper-folper ~sonreg-sonreg
~tanryx 6, ~fildur-fildur ~ticner-ticner ~ridtug-ridtug ~satwyx-satwyx ~tacbus-tacbus ~datsym-datsym
~mocbel 6, ~figlex-figlex ~faltex-faltex ~lapbel-lapbel ~moprec-moprec ~sibrut-sibrut ~ropruc-ropruc
~bolsyd 6, ~fidrux-fidrux ~tilpes-tilpes ~timdeg-timdeg ~sivrem-sivrem ~sabsul-sabsul ~miclud-miclud
~foptus 6, ~fasnev-fasnev ~savdeb-savdeb ~halpec-halpec ~lissyl-lissyl ~salduc-salduc ~pasfex-pasfex
~nortem 6, ~fashex-fashex ~somfen-somfen ~tilrec-tilrec ~sattel-sattel ~hodmeg-hodmeg ~botten-botten
~barwer 6, ~dovrup-dovrup ~rivryc-rivryc ~larlev-larlev ~torwer-torwer ~molpel-molpel ~fambet-fambet
~matdun 6, ~dorhul-dorhul ~dotrux-dotrux ~billud-billud ~sipdyr-sipdyr ~sitpeg-sitpeg ~hodmug-hodmug
~hintud 6, ~diffun-diffun ~witryt-witryt ~nimset-nimset ~minleg-minleg ~sonmut-sonmut ~lapruc-lapruc
~docnyd 6, ~diblux-diblux ~ragseb-ragseb ~fitsel-fitsel ~lavdef-lavdef ~rigten-rigten ~novheb-novheb
~firpem 6, ~dapsed-dapsed ~sonnet-sonnet ~ticneb-ticneb ~hadpyl-hadpyl ~fitbex-fitbex ~hodbus-hodbus
~difpun 6, ~dansun-dansun ~hasryg-hasryg ~bidten-bidten ~lodlyt-lodlyt ~tanfyn-tanfyn ~navler-navler
~moplec 6, ~dacwet-dacwet ~harpyl-harpyl ~pidwyl-pidwyl ~marryc-marryc ~lagrul-lagrul ~nacryd-nacryd
~nombex 6, ~dabped-dabped ~dalzod-dalzod ~pitrec-pitrec ~linnes-linnes ~bispet-bispet ~linwes-linwes
```