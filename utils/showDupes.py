import sys
import subprocess

starList = {}

prefixFile = "prefix.txt"
suffixFile = "suffix.txt"
outFile = "star-dupes.txt"

fiPre = open(str(prefixFile), 'r')
fiSuf = open(str(suffixFile), 'r')
foStarList = open(str(outFile), 'w')

prefix = fiPre.read().split(',')
suffix = fiSuf.read().split(',')

fiPre.close()
fiSuf.close() 

# populate dict of all the stars w/dupelist 
def CheckStars():
    for galaxy in suffix:
        for pre in prefix:
            star = pre + galaxy.strip()
            bashCommand = "getPlanets " + star
            output = subprocess.run(bashCommand.split(), capture_output=True, text=True)
            planetList = output.stdout.split('\n')
            dupe = ""
            for planet in planetList:
                if len(planet) > 0:
                    planet = planet[1:14]
                    nodes = planet.split('-')
                    if (nodes[0]==nodes[1]):
                        dupe = dupe + " ~" + planet
            starList[star] = str(dupe.count('~')) + ", " + dupe

def WriteList():
    for w in sorted(starList, key=starList.get, reverse=True):
        foStarList.write(w + " " + starList[w] + "\n")

CheckStars()
WriteList()

foStarList.close()

