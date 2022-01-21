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
