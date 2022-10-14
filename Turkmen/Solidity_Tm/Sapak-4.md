# <div align="center">Solidity in depth</div>

## Solidity çeşmesi faýlynyň gurluşy

Resource faýyllarynda özbaşdak şertnama kesgitlemeleri, <em>import we pragma</em> görkezmeleri bolup biler.

## Pragmalar

`Pragma` açar sözi, düzüjiniň aýratynlyklaryny ýa-da dolandyryşlaryny işletmek üçin ulanylýar. Pragma görkezmesi elmydama çeşme faýly üçin ýerli bolup durýar, şonuň üçin pragmany ähli taslamaňyza işletmek isleseňiz, ähli faýllaryňyza goşmaly. Başga bir faýl import etseňiz, şol faýldaky pragma import edilen faýla awtomatiki ulanylmaýar.

### Pragma Version

Resource faýyllary pragma wersiýasyna, gabat gelmeýän üýtgeşmeleri girizip biljek ýa-da faýlyň işlemeginiň öňüni alyp biljek täze düzüjiler wersiýalaryna duş gelende çeşme faýyllarynyň bozulmazlygy üçin koduň başynda aýan edilmelidir. Şeýlelik bilen, täze pragma wersiýalary bilen geljekdäki üýtgeşmeleri iň pes derejede saklamaga synanyşýarys we sintaksisde üýtgeşmeler girizip semantik üýtgeşmeleri sazlamaga synanyşýarys, ýöne elbetde bu hemişe mümkin däl. Esasanam `0.x.0` we `x.0.0` formada peýda bolan we uly üýtgeşmeleri öz içine alýan wersiýalar üçin üýtgeşmeler sanawyny gözden geçirmegiň zerurdygyny ýatladýarys.

Pragma version şu şekilde:

```
pragma solidity ^0.5.2;
```

Yokardaky kody öz içine alýan deslapky faýl 0.5.2-den ozal bir düzüji bilen düzülmez, ýa-da 0.6.0 wersiýasyndan başlap düzüjiniň üstünde işlemez (bu ikinji şert ^ ulanyp goşulýar). Munuň aňyrsyndaky pikir, kodumyzyň isleýşimiz ýaly düzjekdigine elmydama ynamymyz bolup biler, sebäbi 0.6 wersiýa çenli hiç hili üýtgeşiklik bolmaz. Çykan bug düzediş wersiýalary deslapky kodumyzda oňat işlär.

Düzediji wersiýa üçin has çylşyrymly düzgünleri kesgitlemek mümkin. Bu ýagdaýlarda, kodumyz npm tarapyndan ulanylýan jümleler bilen yzarlanýar.

#### Maslahat

```
“Pragma” wersiýasyny ulanmak düzüjiniň wersiýasyny üýtgetmez. Şeýle hem düzüjiniň aýratynlyklaryny işletmeýär ýa-da öçürmeýär. Diňe düzüjä, wersiýasynyň pragmanyň talaplaryna laýyk gelýändigini ýa-da ýokdugyny barlamagy tabşyrar. Gabat gelmese, düzüji ýalňyşlyk goýberer.
```

### Synag pragmalary

Pragmanyň başga bir görnüşi eksperimental pragma diýilýär. Düzüjiniň ýa-da diliň entek işlemedik diliniň aýratynlyklaryny barlamak üçin ulanylyp bilner. Aşakdaky synag synag pragmalary häzirki wagtda goldanýar:

#### ABIEncoderV2

Täze ABI kodlaýjy, özbaşdak ýerleşdirilen yzygiderliligi we gurluşlary kodlamak we kodlamak ukybyny öz içine alýar. Az optimal kod öndürýär (koduň bu bölegi üçin optimizator henizem işlenip düzülýär) we köne kodlaýjy ýaly synagdan geçirilmeýär. Bu synag synag wersiýasyny `pragma experimental ABIEncoderV2` buýrugy bilen ulanyp bilersiňiz.

#### SMTChecker

Solidity düzüjini guranyňyzda bu komponent işjeň bolmaly we şonuň üçin ähli Solidity ikiliklerinde elýeterli däl. Gurmak görkezmeleri bölüminde, bu opsiýany nädip işletmelidigini düşündireris. Ubuntu PPA goýberilişleriniň köpüsi üçin açyk bolmaly bolsa-da; Solc-js, Docker şekilleri, Windows ikili ýa-da statiki taýdan döredilen Linux ikiliklerini işletmegiň zerurlygy ýok.

`Pragma eksperimental SMTChecker`; faýlyňyzdaky kod, şonda mümkin SMT dekoderiniň bardygyna şübhelenýän goşmaça howpsuzlyk duýduryşlaryny alarsyňyz. Komponent entek Solidity diliniň ähli aýratynlyklaryny goldamaýar we köp duýduryş döredip biler. Goldaw berilmeýän aýratynlyklar bar bolsa, aýdylan sebäpler entek kanagatlanarly bolup bilmez.

### Beýleki çeşme faýyllaryny import etmek
 
### Syntax & Semantic

Solidity `export` beýanyny bilmeýän hem bolsa, JavaScript-de tapylan (ES6 görnüşinde) meňzeş `import` beýanyny goldaýar.

Global derejede, taslamalaryňyzda aşakdaky koda meňzeş `import` beýanyny ulanyp bilersiňiz:

```
import "filename";

```

Bu jümle, faýl adynyň resminamasyndan (we ol ýerden getirilen nyşanlardan) ähli global nyşanlary işleýän faýlymyzyň bar bolan global çägine (ES6-dan tapawutly, ýöne Solidity üçin yza gabat gelýär) import edýär. Şeýle-de bolsa, ýokardaky ulanyş iş ýerlerinde öňünden aýdylmaýan görnüşde hapalanýar, sebäbi adyň resminamasyna täze ýokary derejeli elementleri goşsaňyz, bu üýtgeşme ýokardaky ýaly faýl adyndan getirilen ähli faýllarda awtomatiki usulda görkeziler. Import wagtynda ulanylýan düşündirişde has anyk sözleri ulanmak maslahat berilýär.

Aşakdaky mysalda, "filename" resminamasyndaky ähli global nyşanlary öz içine alýan "symbolName" atly täze global nyşan döredildi.

 ```
 import * as symbolName from "filename";
 
 ```
 
Şeýle hem, at gapma-garşylygy bar bolsa 'import' edilende nyşanlaryň adyny üýtgedip bilersiňiz. Bu kod, "filename" resminamasynda "symbol1" we "symbol2" atly iki sany global nyşany we öz faýlymyzda "lakam" we "symbol2" atly iki sany täze global nyşany kesgitleýär.

```
import {symbol1 as alias, symbol2} from "filename";
```

ES6-a girmeýän, ýöne şonda-da ýeterlik bolup biljek başga bir ulanyş;

```
import "filename" as symbolName;
```
Yokardaky kod `import * as symbolName from "filename";`e eşdeğerdir.

Bellik 

```
"Filename.sol" -y moduleName hökmünde import etseňiz; ModeleName.C ýazyp, “filename.sol” atly resminamada C atly şertnama girip bilersiňiz. Göni C bilen ýazsaňyz, girmek mümkin däl.
```

### Faýlyň ýerleşýän ýeri
