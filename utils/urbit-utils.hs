{-# LANGUAGE OverloadedStrings #-}

-- compile or run as
--   getPlanets       List planets under given star
--   getPlanetNums    List planet azimuth ints under given star
--   getShipname      Show shipname for given azimuth int

import System.Environment   
import qualified Urbit.Ob as Ob
import Data.Word (Word8)
import qualified Data.Text as T
import qualified Data.Vector as V


prefixes :: V.Vector T.Text
prefixes = V.fromList
  ["doz","mar","bin","wan","sam","lit","sig","hid","fid","lis","sog","dir"
  ,"wac","sab","wis","sib","rig","sol","dop","mod","fog","lid","hop","dar"
  ,"dor","lor","hod","fol","rin","tog","sil","mir","hol","pas","lac","rov"
  ,"liv","dal","sat","lib","tab","han","tic","pid","tor","bol","fos","dot"
  ,"los","dil","for","pil","ram","tir","win","tad","bic","dif","roc","wid"
  ,"bis","das","mid","lop","ril","nar","dap","mol","san","loc","nov","sit"
  ,"nid","tip","sic","rop","wit","nat","pan","min","rit","pod","mot","tam"
  ,"tol","sav","pos","nap","nop","som","fin","fon","ban","mor","wor","sip"
  ,"ron","nor","bot","wic","soc","wat","dol","mag","pic","dav","bid","bal"
  ,"tim","tas","mal","lig","siv","tag","pad","sal","div","dac","tan","sid"
  ,"fab","tar","mon","ran","nis","wol","mis","pal","las","dis","map","rab"
  ,"tob","rol","lat","lon","nod","nav","fig","nom","nib","pag","sop","ral"
  ,"bil","had","doc","rid","moc","pac","rav","rip","fal","tod","til","tin"
  ,"hap","mic","fan","pat","tac","lab","mog","sim","son","pin","lom","ric"
  ,"tap","fir","has","bos","bat","poc","hac","tid","hav","sap","lin","dib"
  ,"hos","dab","bit","bar","rac","par","lod","dos","bor","toc","hil","mac"
  ,"tom","dig","fil","fas","mit","hob","har","mig","hin","rad","mas","hal"
  ,"rag","lag","fad","top","mop","hab","nil","nos","mil","fop","fam","dat"
  ,"nol","din","hat","nac","ris","fot","rib","hoc","nim","lar","fit","wal"
  ,"rap","sar","nal","mos","lan","don","dan","lad","dov","riv","bac","pol"
  ,"lap","tal","pit","nam","bon","ros","ton","fod","pon","sov","noc","sor"
  ,"lav","mat","mip","fip"]

prefix :: Integral a => a -> T.Text
prefix = V.unsafeIndex prefixes . fromIntegral

fromPrefix :: T.Text -> Either T.Text Word8
fromPrefix syl = case V.findIndex (== syl) prefixes of
    Nothing -> Left msg
    Just x  -> Right (fromIntegral x :: Word8)
  where
    msg = "(urbit-hob) bad parse: invalid prefix \"" <> syl <> "\""

suffixes :: V.Vector T.Text
suffixes = V.fromList
  ["zod","nec","bud","wes","sev","per","sut","let","ful","pen","syt","dur"
  ,"wep","ser","wyl","sun","ryp","syx","dyr","nup","heb","peg","lup","dep"
  ,"dys","put","lug","hec","ryt","tyv","syd","nex","lun","mep","lut","sep"
  ,"pes","del","sul","ped","tem","led","tul","met","wen","byn","hex","feb"
  ,"pyl","dul","het","mev","rut","tyl","wyd","tep","bes","dex","sef","wyc"
  ,"bur","der","nep","pur","rys","reb","den","nut","sub","pet","rul","syn"
  ,"reg","tyd","sup","sem","wyn","rec","meg","net","sec","mul","nym","tev"
  ,"web","sum","mut","nyx","rex","teb","fus","hep","ben","mus","wyx","sym"
  ,"sel","ruc","dec","wex","syr","wet","dyl","myn","mes","det","bet","bel"
  ,"tux","tug","myr","pel","syp","ter","meb","set","dut","deg","tex","sur"
  ,"fel","tud","nux","rux","ren","wyt","nub","med","lyt","dus","neb","rum"
  ,"tyn","seg","lyx","pun","res","red","fun","rev","ref","mec","ted","rus"
  ,"bex","leb","dux","ryn","num","pyx","ryg","ryx","fep","tyr","tus","tyc"
  ,"leg","nem","fer","mer","ten","lus","nus","syl","tec","mex","pub","rym"
  ,"tuc","fyl","lep","deb","ber","mug","hut","tun","byl","sud","pem","dev"
  ,"lur","def","bus","bep","run","mel","pex","dyt","byt","typ","lev","myl"
  ,"wed","duc","fur","fex","nul","luc","len","ner","lex","rup","ned","lec"
  ,"ryd","lyd","fen","wel","nyd","hus","rel","rud","nes","hes","fet","des"
  ,"ret","dun","ler","nyr","seb","hul","ryl","lud","rem","lys","fyn","wer"
  ,"ryc","sug","nys","nyl","lyn","dyn","dem","lux","fed","sed","bec","mun"
  ,"lyr","tes","mud","nyt","byr","sen","weg","fyr","mur","tel","rep","teg"
  ,"pec","nel","nev","fes"]

suffix :: Integral a => a -> T.Text
suffix = V.unsafeIndex suffixes . fromIntegral

fromSuffix :: T.Text -> Either T.Text Word8
fromSuffix syl = case V.findIndex (== syl) suffixes of
    Nothing -> Left msg
    Just x  -> Right (fromIntegral x :: Word8)
  where
    msg = "(urbit-hob) bad parse: invalid suffix \"" <> syl <> "\""


iterateShips 0 = return ()
iterateShips n =
    do
        let ship = Ob.patp n
            shipint = Ob.fromPatp ship
            shiptype = Ob.clan ship
            shipparent = Ob.sein ship
            line = show shipint ++ "," ++ show ship ++ "," ++ show shiptype ++ "," ++ show shipparent
        putStrLn line
        iterateShips (n-1)

listPlanets x =
    do  
        if x < 4294901760
            then listPlanets (x+65536)
        else return ()
        let ship = Ob.patp x
            --line = show ship ++ " " ++ show x
            line = show ship
        if x > 65536
            then putStrLn line
        else return ()
        
listPlanetNums x =
    do  
        if x < 4294901760
            then listPlanetNums (x+65536)
        else return ()
        let ship = Ob.patp x
        if x > 65536
            then putStrLn (show x)
        else return ()

main :: IO ()
main = do
    args <- getArgs                 
    progName <- getProgName          
    --just grab first arg
    let arg = args !! 0 
    --run if getPlanets binary
    if T.isInfixOf "getPlanets" (T.pack progName)
        then do
            let shipname = arg
                shippre = take 3 shipname
                shipsuf = drop 3 shipname
                Right preint = fromPrefix (T.pack shippre)
                Right sufint = fromSuffix (T.pack shipsuf)
                starint = ( fromIntegral preint * 256 ) + fromIntegral sufint
            listPlanets starint
        else pure ()
    if T.isInfixOf "getPlanetNums" (T.pack progName)
        then do
            let shipname = arg
                shippre = take 3 shipname
                shipsuf = drop 3 shipname
                Right preint = fromPrefix (T.pack shippre)
                Right sufint = fromSuffix (T.pack shipsuf)
                starint = ( fromIntegral preint * 256 ) + fromIntegral sufint
            listPlanetNums starint
        else pure ()
    if T.isInfixOf "getShipName" (T.pack progName)
        then do
            let sint = arg
            let ship = Ob.patp sint
            putStrLn (show ship)
            putStrLn (arg)
        else pure ()