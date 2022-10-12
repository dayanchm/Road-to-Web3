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

Täze ABI kodlaýjy, özbaşdak ýerleşdirilen yzygiderliligi we gurluşlary kodlamak we kodlamak ukybyny öz içine alýar. Az optimal kod öndürýär (koduň bu bölegi üçin optimizator henizem işlenip düzülýär) we köne kodlaýjy ýaly synagdan geçirilmeýär. Bu synag synag görnüşi
